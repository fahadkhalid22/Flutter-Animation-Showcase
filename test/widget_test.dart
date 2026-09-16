import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_animation_showcase/app/app.dart';
import 'package:flutter_animation_showcase/core/constants/app_strings.dart';
import 'package:flutter_animation_showcase/features/home/showcase_home_screen.dart';
import 'package:flutter_animation_showcase/shared/demo_descriptor.dart';

/// A phone-sized portrait surface so the whole dashboard is visible and
/// every card is tappable without scrolling.
void _usePhoneSurface(WidgetTester tester) {
  tester.view.physicalSize = const Size(400, 1600);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
}

void main() {
  testWidgets('dashboard shows header and all five demo cards', (tester) async {
    _usePhoneSurface(tester);
    await tester.pumpWidget(const AnimationShowcaseApp());

    expect(find.byType(ShowcaseHomeScreen), findsOneWidget);
    expect(find.text(AppStrings.demosBadge), findsOneWidget);
    expect(find.text(AppStrings.appSubtitle), findsOneWidget);
    for (final DemoDescriptor demo in kAnimationDemos) {
      expect(
        find.text(demo.title),
        findsOneWidget,
        reason: 'missing card: ${demo.title}',
      );
      expect(
        find.text(demo.category),
        findsOneWidget,
        reason: 'missing category for: ${demo.title}',
      );
    }
  });

  testWidgets('every demo card opens its screen and back returns home', (
    tester,
  ) async {
    _usePhoneSurface(tester);
    await tester.pumpWidget(const AnimationShowcaseApp());

    for (final DemoDescriptor demo in kAnimationDemos) {
      await tester.tap(find.text(demo.title));
      await tester.pumpAndSettle();

      // The demo screen shell shows the category badge (and intro text).
      expect(
        find.text(demo.category),
        findsWidgets,
        reason: 'demo did not open for: ${demo.title}',
      );
      expect(
        find.text(AppStrings.howItWorks),
        findsOneWidget,
        reason: 'how it works section missing for: ${demo.title}',
      );
      expect(
        find.text(AppStrings.keyClasses),
        findsOneWidget,
        reason: 'key classes section missing for: ${demo.title}',
      );
      expect(
        find.text(AppStrings.whenToUse),
        findsOneWidget,
        reason: 'when to use section missing for: ${demo.title}',
      );

      await tester.tap(find.byTooltip('Back'));
      await tester.pumpAndSettle();

      expect(
        find.byType(ShowcaseHomeScreen),
        findsOneWidget,
        reason: 'did not return home after: ${demo.title}',
      );
    }
  });
}
