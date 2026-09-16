import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_animation_showcase/app/app.dart';
import 'package:flutter_animation_showcase/core/constants/app_strings.dart';
import 'package:flutter_animation_showcase/features/custom_route/custom_route_destination_screen.dart';
import 'package:flutter_animation_showcase/features/home/showcase_home_screen.dart';

/// Accessibility regression coverage for the dashboard:
///
/// * large system text (1.3× and 2.0×) causes no layout overflow anywhere on
///   the home screen, which is where the header badge and card title rows
///   live (both reflow via Flexible/Wrap instead of overflowing);
/// * the custom-route demo honours the platform "reduce motion" preference by
///   landing on the destination instantly;
/// * every navigation card is exposed to screen readers as a button.
void main() {
  Future<void> usePhone(WidgetTester tester) async {
    tester.view.physicalSize = const Size(360, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
  }

  for (final double scale in [1.3, 2.0]) {
    testWidgets('dashboard has no layout overflow at text scale $scale', (
      tester,
    ) async {
      await usePhone(tester);
      tester.platformDispatcher.textScaleFactorTestValue = scale;
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

      await tester.pumpWidget(const AnimationShowcaseApp());
      expect(find.byType(ShowcaseHomeScreen), findsOneWidget);

      // Scroll down the whole dashboard in steps; every step must render
      // cleanly (no RenderFlex overflow from the header badge, card title
      // rows or status pills).
      for (int i = 0; i < 10; i++) {
        await tester.drag(
          find.byType(SingleChildScrollView).first,
          const Offset(0, -260),
        );
        await tester.pump(const Duration(milliseconds: 60));
        expect(
          tester.takeException(),
          isNull,
          reason: 'overflow at text scale $scale after scroll step $i',
        );
      }
    });
  }

  testWidgets('custom route lands instantly under reduce-motion', (
    tester,
  ) async {
    await usePhone(tester);
    tester.platformDispatcher.accessibilityFeaturesTestValue =
        const FakeAccessibilityFeatures(disableAnimations: true);
    addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);

    await tester.pumpWidget(const AnimationShowcaseApp());
    await tester.drag(
      find.byType(SingleChildScrollView).first,
      const Offset(0, 2000),
    );
    await tester.pump(const Duration(milliseconds: 100));
    await tester.ensureVisible(find.text(AppStrings.customRouteTitle));
    await tester.pump(const Duration(milliseconds: 100));
    await tester.tap(find.text(AppStrings.customRouteTitle));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 700));

    await tester.drag(
      find.byType(SingleChildScrollView).first,
      const Offset(0, 2000),
    );
    await tester.pump(const Duration(milliseconds: 100));
    await tester.ensureVisible(find.text('Launch Custom Route'));
    await tester.pump(const Duration(milliseconds: 100));
    await tester.tap(find.text('Launch Custom Route'));

    // Only a couple of frames: the 600 ms slide-and-fade is skipped entirely
    // when "reduce motion" is on, so the destination must already be present.
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 24));
    expect(find.byType(CustomRouteDestinationScreen), findsOneWidget);
  });

  testWidgets('navigation cards expose button semantics', (tester) async {
    await usePhone(tester);
    await tester.pumpWidget(const AnimationShowcaseApp());

    // Five demo cards plus the guide card are all tappable buttons.
    final int buttonCards = find
        .byWidgetPredicate(
          (Widget w) => w is Semantics && w.properties.button == true,
        )
        .evaluate()
        .length;
    expect(buttonCards, greaterThanOrEqualTo(6));
  });
}
