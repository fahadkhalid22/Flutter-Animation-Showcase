import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_animation_showcase/app/app.dart';
import 'package:flutter_animation_showcase/core/constants/app_strings.dart';
import 'package:flutter_animation_showcase/features/home/showcase_home_screen.dart';

/// A phone-sized portrait surface so controls are visible and tappable
/// without scrolling.
void _usePhoneSurface(WidgetTester tester) {
  tester.view.physicalSize = const Size(400, 1600);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
}

/// Completes a route push/pop without waiting for animations that never
/// settle — the rotation demo repeats forever by design.
Future<void> _pumpRouteTransition(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 500));
}

/// Navigates to a demo screen from the dashboard.
Future<void> _openDemo(WidgetTester tester, String title) async {
  await tester.tap(find.text(title));
  await _pumpRouteTransition(tester);
}

void main() {
  group('Phase 2 — AnimatedContainer (implicit)', () {
    /// The animated card's laid-out side length after a settle.
    double cardSize(WidgetTester tester) {
      return tester.getSize(find.byType(AnimatedContainer).first).width;
    }

    testWidgets('Animate expands, Reset collapses, Replay animates again', (
      tester,
    ) async {
      _usePhoneSurface(tester);
      await tester.pumpWidget(const AnimationShowcaseApp());
      await _openDemo(tester, AppStrings.animatedContainerTitle);
      await tester.pumpAndSettle();

      // Initial state is collapsed.
      expect(cardSize(tester), 120);

      // Animate → expands.
      await tester.tap(find.text('Animate'));
      await tester.pumpAndSettle();
      expect(cardSize(tester), 212);

      // Reset → collapses again.
      await tester.tap(find.text('Reset'));
      await tester.pumpAndSettle();
      expect(cardSize(tester), 120);

      // Replay → snaps back collapsed then animates forward again.
      await tester.tap(find.text('Replay'));
      await tester.pumpAndSettle();
      expect(cardSize(tester), 212);
    });

    testWidgets('rapid repeated taps never crash the implicit demo', (
      tester,
    ) async {
      _usePhoneSurface(tester);
      await tester.pumpWidget(const AnimationShowcaseApp());
      await _openDemo(tester, AppStrings.animatedContainerTitle);
      await tester.pumpAndSettle();

      for (int i = 0; i < 5; i++) {
        await tester.tap(find.text('Animate'));
        await tester.tap(find.text('Reset'));
        await tester.pump();
      }
      await tester.pumpAndSettle();

      expect(cardSize(tester), 120);

      // Pop safely after all the toggling.
      await tester.tap(find.byTooltip('Back'));
      await _pumpRouteTransition(tester);
      expect(find.byType(ShowcaseHomeScreen), findsOneWidget);
    });
  });

  group('Phase 2 — Tween Rotation (explicit)', () {
    testWidgets('play / pause / reverse / reset all update status', (
      tester,
    ) async {
      _usePhoneSurface(tester);
      await tester.pumpWidget(const AnimationShowcaseApp());
      await _openDemo(tester, AppStrings.tweenRotationTitle);

      // Starts repeating on its own.
      expect(find.text('Playing'), findsOneWidget);

      await tester.tap(find.text('Pause'));
      await tester.pump();
      expect(find.text('Paused'), findsOneWidget);

      await tester.tap(find.text('Play'));
      await tester.pump();
      expect(find.text('Playing'), findsOneWidget);

      await tester.tap(find.text('Reverse'));
      await tester.pump();
      expect(find.text('Reversing'), findsOneWidget);

      await tester.tap(find.text('Reset'));
      await tester.pump();
      expect(find.text('Idle'), findsOneWidget);
    });

    testWidgets('leaving the route while playing and returning is safe', (
      tester,
    ) async {
      _usePhoneSurface(tester);
      await tester.pumpWidget(const AnimationShowcaseApp());
      await _openDemo(tester, AppStrings.tweenRotationTitle);
      expect(find.text('Playing'), findsOneWidget);

      // Leave mid-animation: no ticker errors may be thrown.
      await tester.tap(find.byTooltip('Back'));
      await _pumpRouteTransition(tester);
      expect(find.byType(ShowcaseHomeScreen), findsOneWidget);

      // Return and it starts playing again.
      await _openDemo(tester, AppStrings.tweenRotationTitle);
      expect(find.text('Playing'), findsOneWidget);
    });

    testWidgets('repeat toggle stops looping after the current pass', (
      tester,
    ) async {
      _usePhoneSurface(tester);
      await tester.pumpWidget(const AnimationShowcaseApp());
      await _openDemo(tester, AppStrings.tweenRotationTitle);

      // Turn repeat off mid-flight.
      await tester.tap(find.byType(Switch));
      await tester.pump();

      // The current forward pass completes then stops.
      await tester.pump(const Duration(milliseconds: 2500));
      expect(find.text('Completed'), findsOneWidget);

      // Play now runs a single forward pass from zero.
      await tester.tap(find.text('Play'));
      await tester.pump();
      expect(find.text('Playing'), findsOneWidget);

      await tester.pump(const Duration(milliseconds: 2500));
      expect(find.text('Completed'), findsOneWidget);
    });
  });
}
