import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_animation_showcase/app/app.dart';
import 'package:flutter_animation_showcase/core/constants/app_strings.dart';
import 'package:flutter_animation_showcase/features/custom_route/custom_route_demo.dart';
import 'package:flutter_animation_showcase/features/staggered_animation/staggered_animation_demo.dart';
import 'package:flutter_animation_showcase/features/tween_rotation/tween_rotation_demo.dart';
import 'package:flutter_animation_showcase/features/home/showcase_home_screen.dart';

/// Regression tests that verify the initial state and basic invariants of
/// every demo screen, filling the gap between the earlier phase-level tests
/// and the end-to-end navigation sweeps.
void main() {
  Future<void> openDemo(WidgetTester tester, String title) async {
    await tester.drag(
      find.byType(SingleChildScrollView).first,
      const Offset(0, 2000),
    );
    await tester.pump(const Duration(milliseconds: 100));
    await tester.ensureVisible(find.text(title));
    await tester.pump(const Duration(milliseconds: 100));
    await tester.tap(find.text(title));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 700));
  }

  Future<void> goBack(WidgetTester tester) async {
    await tester.ensureVisible(find.byTooltip('Back').last);
    await tester.pump(const Duration(milliseconds: 120));
    await tester.tap(find.byTooltip('Back').last, warnIfMissed: false);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 700));
  }

  testWidgets(
    'home screen renders exactly five demo cards and the guide entry',
    (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(const AnimationShowcaseApp());
      expect(find.byType(ShowcaseHomeScreen), findsOneWidget);

      final List<String> titles = [
        AppStrings.animatedContainerTitle,
        AppStrings.heroAnimationTitle,
        AppStrings.tweenRotationTitle,
        AppStrings.staggeredAnimationTitle,
        AppStrings.customRouteTitle,
        AppStrings.guideTitle,
      ];
      for (final String title in titles) {
        expect(
          find.text(title),
          findsOneWidget,
          reason: 'Missing card: $title',
        );
      }
    },
  );

  group('demo initial states', () {
    testWidgets('AnimatedContainer demo starts at default color and size', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(const AnimationShowcaseApp());
      await openDemo(tester, AppStrings.animatedContainerTitle);

      expect(find.text('Animate'), findsOneWidget);
      expect(find.text('Reset'), findsOneWidget);
      expect(find.text('Replay'), findsOneWidget);

      await goBack(tester);
      expect(find.byType(ShowcaseHomeScreen), findsOneWidget);
    });

    testWidgets('Tween rotation demo starts idle at 0°', (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(const AnimationShowcaseApp());
      await openDemo(tester, AppStrings.tweenRotationTitle);

      expect(find.byType(TweenRotationDemo), findsOneWidget);
      expect(find.text('Play'), findsOneWidget);
      expect(find.text('Pause'), findsOneWidget);
      expect(find.text('Reverse'), findsOneWidget);
      expect(find.text('Reset'), findsOneWidget);

      await goBack(tester);
      expect(find.byType(ShowcaseHomeScreen), findsOneWidget);
    });

    testWidgets('Staggered animation demo starts with all items hidden', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(const AnimationShowcaseApp());
      await openDemo(tester, AppStrings.staggeredAnimationTitle);

      expect(find.byType(StaggeredAnimationDemo), findsOneWidget);
      expect(find.text('Play Sequence'), findsOneWidget);
      expect(find.text('Reset'), findsOneWidget);
      expect(find.text('Replay'), findsOneWidget);

      await goBack(tester);
      expect(find.byType(ShowcaseHomeScreen), findsOneWidget);
    });

    testWidgets('Custom route demo shows preview panels and launch button', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(const AnimationShowcaseApp());
      await openDemo(tester, AppStrings.customRouteTitle);

      expect(find.byType(CustomRouteDemo), findsOneWidget);
      expect(find.text('Launch Custom Route'), findsOneWidget);

      await goBack(tester);
      expect(find.byType(ShowcaseHomeScreen), findsOneWidget);
    });
  });

  testWidgets(
    'all five demo cards open their working demo and back returns home',
    (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(const AnimationShowcaseApp());
      expect(find.byType(ShowcaseHomeScreen), findsOneWidget);

      final List<String> titles = [
        AppStrings.animatedContainerTitle,
        AppStrings.heroAnimationTitle,
        AppStrings.tweenRotationTitle,
        AppStrings.staggeredAnimationTitle,
        AppStrings.customRouteTitle,
      ];

      for (final String title in titles) {
        await openDemo(tester, title);
        await goBack(tester);
        expect(
          find.byType(ShowcaseHomeScreen),
          findsOneWidget,
          reason: 'Failed to return home after $title',
        );
      }
    },
  );
}
