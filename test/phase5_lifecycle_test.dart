import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_animation_showcase/app/app.dart';
import 'package:flutter_animation_showcase/core/constants/app_strings.dart';
import 'package:flutter_animation_showcase/features/custom_route/custom_route_destination_screen.dart';
import 'package:flutter_animation_showcase/features/home/showcase_home_screen.dart';

/// A phone-sized portrait surface so controls are visible and tappable.
void _usePhoneSurface(WidgetTester tester) {
  tester.view.physicalSize = const Size(400, 1600);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
}

/// Bounded pump so infinite/looping animations never block settling.
Future<void> _pumpRouteTransition(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 500));
}

/// Opens a demo from the dashboard.
Future<void> _openDemo(WidgetTester tester, String title) async {
  await tester.tap(find.text(title));
  await _pumpRouteTransition(tester);
}

void main() {
  // An exception anywhere in a testWidgets body fails the test, so simply
  // driving the interactions inside the widget tree is the assertion: no
  // ticker leaks, no "setState after dispose", no duplicate-Hero-tag errors.

  testWidgets('AnimatedContainer survives rapid repeated toggling', (
    tester,
  ) async {
    _usePhoneSurface(tester);
    await tester.pumpWidget(const AnimationShowcaseApp());
    await _openDemo(tester, AppStrings.animatedContainerTitle);
    await tester.pumpAndSettle();

    for (int i = 0; i < 20; i++) {
      await tester.tap(find.text('Animate'));
      await tester.pump(const Duration(milliseconds: 30));
      await tester.tap(find.text('Reset'));
      await tester.pump(const Duration(milliseconds: 30));
      await tester.tap(find.text('Replay'));
      await tester.pump(const Duration(milliseconds: 30));
    }
    // Toggling must never leave it disabled or stuck.
    await tester.pumpAndSettle();
    await tester.tap(find.text('Animate'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Back'));
    await _pumpRouteTransition(tester);
    expect(find.byType(ShowcaseHomeScreen), findsOneWidget);
  });

  testWidgets('rotation survives play/pause/reverse/reset then leaves active', (
    tester,
  ) async {
    _usePhoneSurface(tester);
    await tester.pumpWidget(const AnimationShowcaseApp());
    await _openDemo(tester, AppStrings.tweenRotationTitle);

    for (int i = 0; i < 10; i++) {
      await tester.tap(find.text('Pause'));
      await tester.pump(const Duration(milliseconds: 20));
      await tester.tap(find.text('Play'));
      await tester.pump(const Duration(milliseconds: 20));
      await tester.tap(find.text('Reverse'));
      await tester.pump(const Duration(milliseconds: 20));
      await tester.tap(find.text('Reset'));
      await tester.pump(const Duration(milliseconds: 20));
    }

    // Leave while the controller is actively repeating — the ticker must be
    // disposed cleanly with no exception.
    await tester.tap(find.byTooltip('Back'));
    await _pumpRouteTransition(tester);
    expect(find.byType(ShowcaseHomeScreen), findsOneWidget);

    // Re-entering starts fresh instead of resurrecting a dead controller.
    await _openDemo(tester, AppStrings.tweenRotationTitle);
    expect(find.text('Playing'), findsOneWidget);
  });

  testWidgets(
    'staggered survives mid-animation reverse/reset and mid-flight exit',
    (tester) async {
      _usePhoneSurface(tester);
      await tester.pumpWidget(const AnimationShowcaseApp());
      await _openDemo(tester, AppStrings.staggeredAnimationTitle);

      // Hammer play, reverse and reset while the sequence is mid-flight.
      for (int i = 0; i < 8; i++) {
        await tester.tap(find.text('Play Sequence'));
        await tester.pump(const Duration(milliseconds: 40));
        await tester.tap(find.text('Reverse'));
        await tester.pump(const Duration(milliseconds: 40));
        await tester.tap(find.text('Reset'));
        await tester.pump(const Duration(milliseconds: 40));
        await tester.tap(find.text('Replay'));
        await tester.pump(const Duration(milliseconds: 40));
        await tester.tap(find.text('Reset'));
        await tester.pump(const Duration(milliseconds: 40));
      }

      // Leave the screen while the last sequence is still running.
      await tester.tap(find.byTooltip('Back'));
      await _pumpRouteTransition(tester);
      expect(find.byType(ShowcaseHomeScreen), findsOneWidget);
    },
  );

  testWidgets('hero survives rapid forward/back flying when not settled', (
    tester,
  ) async {
    _usePhoneSurface(tester);
    await tester.pumpWidget(const AnimationShowcaseApp());
    await _openDemo(tester, AppStrings.heroAnimationTitle);

    // Mid-flight taps may legitimately miss while the flight is in progress;
    // that is the app blocking a tap, not a defect. Any genuine exception
    // (duplicate Hero tag, ticker leak) still fails the test.
    for (int i = 0; i < 5; i++) {
      await tester.tap(find.byType(Hero).first, warnIfMissed: false);
      await tester.pump(const Duration(milliseconds: 150));
      // The topmost back button is the destination route's, which is the
      // one that pops the flight we just started.
      await tester.tap(find.byTooltip('Back').last, warnIfMissed: false);
      await tester.pump(const Duration(milliseconds: 150));
    }
    // The chaos loop must have thrown no exceptions (a duplicate tag or a
    // lost ticker would have failed the test here). Because some taps may
    // not land mid-flight, the heap can be left mid-stack — so walk every
    // remaining back button down to the dashboard to prove navigation still
    // pops cleanly after the abuse.
    await tester.pumpAndSettle();
    int guard = 0;
    while (find.byTooltip('Back').evaluate().isNotEmpty && guard < 10) {
      await tester.tap(find.byTooltip('Back').last, warnIfMissed: false);
      await tester.pumpAndSettle();
      guard++;
    }
    expect(find.byType(ShowcaseHomeScreen), findsOneWidget);
  });

  testWidgets('custom route pops cleanly mid-transition again and again', (
    tester,
  ) async {
    _usePhoneSurface(tester);
    await tester.pumpWidget(const AnimationShowcaseApp());
    await _openDemo(tester, AppStrings.customRouteTitle);

    // Launch then immediately back out while the slide+fade is still running.
    // Popping mid-flight disposes the route's transitions; repeating it must
    // never leak tickers or stack destinations.
    for (int i = 0; i < 5; i++) {
      await tester.tap(find.text('Launch Custom Route'));
      await tester.pump(const Duration(milliseconds: 60));
      await tester.pump(const Duration(milliseconds: 60));
      await tester.tap(find.byTooltip('Back').last, warnIfMissed: false);
      await tester.pump(const Duration(milliseconds: 60));
    }

    await tester.pumpAndSettle();
    expect(find.byType(CustomRouteDestinationScreen), findsNothing);
    expect(find.text('Launch Custom Route'), findsOneWidget);

    // A settled launch afterwards still works.
    await tester.tap(find.text('Launch Custom Route'));
    await tester.pumpAndSettle();
    expect(find.byType(CustomRouteDestinationScreen), findsOneWidget);
    await tester.tap(find.byTooltip('Back').last);
    await tester.pumpAndSettle();
    expect(find.text('Launch Custom Route'), findsOneWidget);
  });
}
