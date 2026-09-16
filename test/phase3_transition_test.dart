import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_animation_showcase/app/app.dart';
import 'package:flutter_animation_showcase/core/constants/app_strings.dart';
import 'package:flutter_animation_showcase/features/hero_animation/hero_animation_demo.dart';
import 'package:flutter_animation_showcase/features/hero_animation/hero_animation_destination_screen.dart';
import 'package:flutter_animation_showcase/features/hero_animation/hero_tags.dart';
import 'package:flutter_animation_showcase/features/home/showcase_home_screen.dart';

/// A phone-sized portrait surface so controls and objects are tappable.
void _usePhoneSurface(WidgetTester tester) {
  tester.view.physicalSize = const Size(400, 1600);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
}

/// Opens a demo screen from the dashboard, using bounded pumps so the
/// rotation demo's infinite repeat does not cause a pumpAndSettle timeout.
Future<void> _openDemo(WidgetTester tester, String title) async {
  await tester.tap(find.text(title));
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 500));
}

/// Naps long enough for any route transition to finish without hanging on
/// infinite animations (rotation demo repeats forever by design).
Future<void> _pumpRouteTransition(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 500));
}

void main() {
  group('Phase 3 — Hero shared element', () {
    testWidgets('source tap forwards, back reverses, tags stay unique', (
      tester,
    ) async {
      _usePhoneSurface(tester);
      await tester.pumpWidget(const AnimationShowcaseApp());
      await _openDemo(tester, AppStrings.heroAnimationTitle);

      // Instruction is visible on the source screen.
      expect(
        find.text('Tap the object to explore the Hero transition.'),
        findsOneWidget,
      );

      // Exactly one Hero with the motion tag on the source route.
      Finder sourceHero() => find.descendant(
        of: find.byType(HeroAnimationDemo),
        matching: find.byWidgetPredicate(
          (Widget w) => w is Hero && w.tag == HeroTags.motionObject,
        ),
      );
      expect(sourceHero(), findsOneWidget);

      // Forward flight: tap the object.
      await tester.tap(find.byType(Hero).first);
      await tester.pumpAndSettle();
      expect(find.byType(HeroDestinationScreen), findsOneWidget);

      // Exactly one Hero with the tag on the destination route.
      final Finder destinationHero = find.descendant(
        of: find.byType(HeroDestinationScreen),
        matching: find.byWidgetPredicate(
          (Widget w) => w is Hero && w.tag == HeroTags.motionObject,
        ),
      );
      expect(destinationHero, findsOneWidget);

      // Reverse flight: back returns to the source.
      await tester.tap(find.byTooltip('Back'));
      await tester.pumpAndSettle();
      expect(find.byType(HeroAnimationDemo), findsOneWidget);
      expect(
        find.text('Tap the object to explore the Hero transition.'),
        findsOneWidget,
      );
    });

    testWidgets('rapid repeated forward / reverse navigation is safe', (
      tester,
    ) async {
      _usePhoneSurface(tester);
      await tester.pumpWidget(const AnimationShowcaseApp());
      await _openDemo(tester, AppStrings.heroAnimationTitle);

      for (int i = 0; i < 3; i++) {
        await tester.tap(find.byType(Hero).first);
        await tester.pumpAndSettle();
        expect(find.byType(HeroDestinationScreen), findsOneWidget);

        await tester.tap(find.byTooltip('Back'));
        await tester.pumpAndSettle();
        expect(find.byType(HeroAnimationDemo), findsOneWidget);
      }

      // Still on the demo screen; no Hero-tag exceptions were thrown.
      expect(
        find.text('Tap the object to explore the Hero transition.'),
        findsOneWidget,
      );
    });
  });

  group('Phase 3 — Custom Slide + Fade route', () {
    testWidgets('launch slides and fades in, back replays the reverse', (
      tester,
    ) async {
      _usePhoneSurface(tester);
      await tester.pumpWidget(const AnimationShowcaseApp());
      await _openDemo(tester, AppStrings.customRouteTitle);

      await tester.tap(find.text('Launch Custom Route'));

      // One frame in: the new route has started its animation.
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));

      final SlideTransition slide = tester.widget<SlideTransition>(
        find.byKey(const ValueKey('custom-route-slide')),
      );
      final FadeTransition fade = tester.widget<FadeTransition>(
        find.byKey(const ValueKey('custom-route-fade')),
      );

      // Both effects are observable mid-flight: partially slid, partially faded.
      expect(slide.position.value.dx, greaterThan(0.0));
      expect(slide.position.value.dx, lessThan(1.0));
      expect(fade.opacity.value, greaterThan(0.0));
      expect(fade.opacity.value, lessThan(1.0));
      expect(find.text('You just slid in from the right.'), findsOneWidget);

      // After the route settles: fully arrived and opaque.
      await tester.pumpAndSettle();
      expect(slide.position.value, Offset.zero);
      expect(fade.opacity.value, 1.0);

      // Back replays the transition in reverse.
      await tester.tap(find.byTooltip('Back'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));
      await tester.pumpAndSettle();
      expect(find.text('Launch Custom Route'), findsOneWidget);

      // Replay: launch again and verify it still slides and fades.
      await tester.tap(find.text('Launch Custom Route'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));
      final SlideTransition again = tester.widget<SlideTransition>(
        find.byKey(const ValueKey('custom-route-slide')),
      );
      expect(again.position.value.dx, greaterThan(0.0));
      await tester.pumpAndSettle();
      expect(find.text('You just slid in from the right.'), findsOneWidget);
    });
  });

  group('Phase 3 — regression', () {
    testWidgets('dashboard and all prior demos still work', (tester) async {
      _usePhoneSurface(tester);
      await tester.pumpWidget(const AnimationShowcaseApp());

      expect(find.byType(ShowcaseHomeScreen), findsOneWidget);
      for (final String title in [
        AppStrings.animatedContainerTitle,
        AppStrings.heroAnimationTitle,
        AppStrings.tweenRotationTitle,
        AppStrings.staggeredAnimationTitle,
        AppStrings.customRouteTitle,
      ]) {
        await _openDemo(tester, title);
        expect(find.text(AppStrings.howItWorks), findsOneWidget);
        await tester.tap(find.byTooltip('Back'));
        await _pumpRouteTransition(tester);
        expect(find.byType(ShowcaseHomeScreen), findsOneWidget);
      }
    });
  });
}
