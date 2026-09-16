import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_animation_showcase/app/app.dart';
import 'package:flutter_animation_showcase/core/constants/app_strings.dart';
import 'package:flutter_animation_showcase/features/guide/animation_guide_screen.dart';
import 'package:flutter_animation_showcase/features/home/showcase_home_screen.dart';
import 'package:flutter_animation_showcase/shared/demo_descriptor.dart';

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

/// Reads the current opacity of the FadeTransition wrapping one staggered
/// item, found by its unique subtitle line.
double _itemOpacity(WidgetTester tester, String subtitle) {
  final FadeTransition fade = tester.widget<FadeTransition>(
    find
        .ancestor(
          of: find.text(subtitle),
          matching: find.byType(FadeTransition),
        )
        .first,
  );
  return fade.opacity.value;
}

/// The staggered demo sorted by presentation order.
const List<String> _itemSubtitles = [
  'One AnimationController owns the whole timeline',
  'Each item claims its own slice of time',
  'Per-item ease lands inside its own slice',
  'The cascade finishes one item at a time',
];

void main() {
  group('Phase 4 — Staggered sequence (shared timeline)', () {
    testWidgets('renders exactly four items that enter on distinct intervals', (
      tester,
    ) async {
      _usePhoneSurface(tester);
      await tester.pumpWidget(const AnimationShowcaseApp());
      await _openDemo(tester, AppStrings.staggeredAnimationTitle);

      // Exactly four primary items, each with its own unique concept line.
      for (final String subtitle in _itemSubtitles) {
        expect(find.text(subtitle), findsOneWidget);
      }

      // Normalise to the start of the timeline.
      await tester.tap(find.text('Reset'));
      await tester.pump();
      for (final String subtitle in _itemSubtitles) {
        expect(_itemOpacity(tester, subtitle), closeTo(0.0, 0.001));
      }

      // Play the sequence and stop a third of the way through (~0.30 of the
      // 2.6 s timeline). Item 1 (interval 0.00–0.40) is nearly finished while
      // item 4 (interval 0.45–0.85) has not started yet — the stagger.
      await tester.tap(find.text('Play Sequence'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 780));
      expect(_itemOpacity(tester, _itemSubtitles[0]), greaterThan(0.9));
      expect(_itemOpacity(tester, _itemSubtitles[3]), closeTo(0.0, 0.02));

      // Let the whole cascade settle: every item ends fully visible.
      await tester.pump(const Duration(milliseconds: 1900));
      for (final String subtitle in _itemSubtitles) {
        expect(_itemOpacity(tester, subtitle), closeTo(1.0, 0.02));
      }
    });

    testWidgets('play, replay, reverse and reset drive it safely', (
      tester,
    ) async {
      _usePhoneSurface(tester);
      await tester.pumpWidget(const AnimationShowcaseApp());
      await _openDemo(tester, AppStrings.staggeredAnimationTitle);

      // Replay from a resting state brings the cascade back to the start.
      await tester.tap(find.text('Reset'));
      await tester.pump();
      await tester.tap(find.text('Replay'));
      await tester.pump();
      expect(_itemOpacity(tester, _itemSubtitles[0]), closeTo(0.0, 0.02));
      await tester.pump(const Duration(milliseconds: 2600));
      expect(_itemOpacity(tester, _itemSubtitles[3]), closeTo(1.0, 0.02));

      // Reverse undoes the later items first: mid-reverse item 4 fades back
      // while item 1 still holds its final state.
      await tester.tap(find.text('Reverse'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 1300));
      expect(_itemOpacity(tester, _itemSubtitles[0]), closeTo(1.0, 0.02));
      expect(_itemOpacity(tester, _itemSubtitles[3]), lessThan(0.5));
      await tester.pump(const Duration(milliseconds: 1400));
      for (final String subtitle in _itemSubtitles) {
        expect(_itemOpacity(tester, subtitle), closeTo(0.0, 0.02));
      }

      // Rapid repeated presses never crash or leak tickers.
      for (int i = 0; i < 5; i++) {
        await tester.tap(find.text('Replay'));
        await tester.tap(find.text('Reset'));
        await tester.pump(const Duration(milliseconds: 17));
      }
      await tester.tap(find.text('Reset'));
      await tester.pump();

      // Pop safely after all the toggling.
      await tester.tap(find.byTooltip('Back'));
      await _pumpRouteTransition(tester);
      expect(find.byType(ShowcaseHomeScreen), findsOneWidget);
    });
  });

  group('Phase 4 — Dashboard integration + guide', () {
    testWidgets('dashboard carries five complete demos and the guide entry', (
      tester,
    ) async {
      _usePhoneSurface(tester);
      await tester.pumpWidget(const AnimationShowcaseApp());

      // The five demo cards.
      for (final DemoDescriptor demo in kAnimationDemos) {
        expect(find.text(demo.title), findsOneWidget);
      }
      // The guide entry card.
      expect(find.text(AppStrings.guideTitle), findsOneWidget);
      // Every card (five demos + guide) is badged complete.
      expect(find.text('Complete'), findsNWidgets(6));
    });

    testWidgets('guide screen compares every technique and the two families', (
      tester,
    ) async {
      _usePhoneSurface(tester);
      await tester.pumpWidget(const AnimationShowcaseApp());

      await tester.ensureVisible(find.text(AppStrings.guideTitle));
      await tester.pump();
      await tester.tap(find.text(AppStrings.guideTitle));
      await _pumpRouteTransition(tester);

      expect(find.byType(AnimationGuideScreen), findsOneWidget);
      // Distinct comparison cells for each of the five techniques.
      expect(find.text('Low / medium'), findsOneWidget);
      expect(find.text('Framework-managed'), findsOneWidget);
      expect(find.text('Explicit sequence'), findsOneWidget);
      expect(find.text('Navigation'), findsOneWidget);
      // The implicit-vs-explicit section is rendered.
      expect(find.text(AppStrings.implicitVsExplicit), findsOneWidget);
      expect(find.text('Technique Comparison'), findsOneWidget);

      await tester.tap(find.byTooltip('Back'));
      await _pumpRouteTransition(tester);
      expect(find.byType(ShowcaseHomeScreen), findsOneWidget);
    });

    testWidgets('every card opens its working demo and back returns home', (
      tester,
    ) async {
      _usePhoneSurface(tester);
      await tester.pumpWidget(const AnimationShowcaseApp());

      for (final DemoDescriptor demo in kAnimationDemos) {
        await _openDemo(tester, demo.title);
        expect(
          find.text(AppStrings.keyClasses),
          findsOneWidget,
          reason: 'key classes section missing for: ${demo.title}',
        );
        await tester.tap(find.byTooltip('Back'));
        await _pumpRouteTransition(tester);
        expect(
          find.byType(ShowcaseHomeScreen),
          findsOneWidget,
          reason: 'did not return home after: ${demo.title}',
        );
      }
    });
  });
}
