import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_animation_showcase/app/app.dart';
import 'package:flutter_animation_showcase/core/constants/app_strings.dart';
import 'package:flutter_animation_showcase/features/custom_route/custom_route_destination_screen.dart';
import 'package:flutter_animation_showcase/features/hero_animation/hero_animation_destination_screen.dart';
import 'package:flutter_animation_showcase/features/home/showcase_home_screen.dart';

/// Phone and tablet surfaces the showcase must render without overflow.
const List<(double, double)> _surfaces = [
  (360, 800),
  (375, 812),
  (390, 844),
  (412, 915),
  (768, 1024),
];

/// Applies a physical surface size for the current test.
void _useSurface(WidgetTester tester, double width, double height) {
  tester.view.physicalSize = Size(width, height);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
}

/// Bounded pumps; never settle so the looping rotation demo cannot hang.
/// Pumps 700 ms which exceeds every route-transition duration (600 ms) so
/// dual-route windows do not linger during Back taps.
Future<void> _pumpRouteTransition(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 700));
}

/// Walks the scroll view down in steps, failing if any layout exception
/// (for example a RenderFlex overflow) is reported along the way.
Future<void> _scrollAndAssertClean(WidgetTester tester) async {
  final Finder scrollable = find.byType(SingleChildScrollView);
  for (int i = 0; i < 8; i++) {
    await tester.drag(scrollable.first, const Offset(0, -260));
    await tester.pump(const Duration(milliseconds: 60));
    expect(
      tester.takeException(),
      isNull,
      reason: 'layout exception while scrolling on step $i',
    );
  }
}

/// Reveals [target] fully on-screen inside the current scroll view and taps
/// it. `ensureVisible` can leave a target partly above the viewport edge, so
/// a small downward drag nudges it into the clear before the tap.
Future<void> _revealAndTap(WidgetTester tester, Finder target) async {
  await tester.drag(
    find.byType(SingleChildScrollView).first,
    const Offset(0, 2000),
  );
  await tester.pump(const Duration(milliseconds: 100));
  await tester.ensureVisible(target);
  await tester.pump(const Duration(milliseconds: 100));
  await tester.drag(
    find.byType(SingleChildScrollView).first,
    const Offset(0, 120),
  );
  await tester.pump(const Duration(milliseconds: 100));
  await tester.tap(target);
}

/// Opens every screen at a given surface and asserts the whole screen is
/// free of overflow exceptions, including long educational sections.
Future<void> _verifyScreensAt(
  WidgetTester tester,
  double width,
  double height,
) async {
  _useSurface(tester, width, height);
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
    await _revealAndTap(tester, find.text(title));
    await _pumpRouteTransition(tester);
    await _scrollAndAssertClean(tester);

    // The Hero and custom-route demos also push real destination screens.
    if (title == AppStrings.heroAnimationTitle) {
      await _revealAndTap(tester, find.byType(Hero).first);
      await _pumpRouteTransition(tester);
      await _scrollAndAssertClean(tester);
      expect(find.byType(HeroDestinationScreen), findsOneWidget);
      await tester.tap(find.byTooltip('Back').last);
      await _pumpRouteTransition(tester);
    } else if (title == AppStrings.customRouteTitle) {
      await _revealAndTap(tester, find.text('Launch Custom Route'));
      await _pumpRouteTransition(tester);
      await _scrollAndAssertClean(tester);
      expect(find.byType(CustomRouteDestinationScreen), findsOneWidget);
      await tester.tap(find.byTooltip('Back').last);
      await _pumpRouteTransition(tester);
    }

    // `.last` targets the topmost route's Back button, avoiding ambiguity
    // when two routes are momentarily visible during a pop transition.
    await tester.tap(find.byTooltip('Back').last);
    await _pumpRouteTransition(tester);
    expect(find.byType(ShowcaseHomeScreen), findsOneWidget);
  }

  // The global techniques guide screen.
  await _revealAndTap(tester, find.text(AppStrings.guideTitle));
  await _pumpRouteTransition(tester);
  await _scrollAndAssertClean(tester);
}

void main() {
  for (final (double width, double height) in _surfaces) {
    testWidgets('${width.toInt()}x${height.toInt()} has no layout overflow', (
      tester,
    ) async {
      await _verifyScreensAt(tester, width, height);
    });
  }
}
