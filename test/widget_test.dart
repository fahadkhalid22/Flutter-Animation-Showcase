import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_animation_showcase/app/app.dart';
import 'package:flutter_animation_showcase/core/constants/app_strings.dart';
import 'package:flutter_animation_showcase/features/animated_container/animated_container_demo_screen.dart';
import 'package:flutter_animation_showcase/features/home/showcase_home_screen.dart';

void main() {
  const List<String> demoTitles = [
    AppStrings.animatedContainerTitle,
    AppStrings.heroAnimationTitle,
    AppStrings.tweenRotationTitle,
    AppStrings.staggeredAnimationTitle,
    AppStrings.customRouteTitle,
  ];

  testWidgets('dashboard shows header and all five demo cards', (tester) async {
    await tester.pumpWidget(const AnimationShowcaseApp());

    expect(find.byType(ShowcaseHomeScreen), findsOneWidget);
    expect(find.text(AppStrings.demosBadge), findsOneWidget);
    expect(find.text(AppStrings.appSubtitle), findsOneWidget);
    for (final String title in demoTitles) {
      expect(find.text(title), findsOneWidget, reason: 'missing card: $title');
    }
  });

  testWidgets('tapping a demo card opens its screen and back returns home', (
    tester,
  ) async {
    await tester.pumpWidget(const AnimationShowcaseApp());

    await tester.tap(find.text(AppStrings.animatedContainerTitle));
    await tester.pumpAndSettle();

    expect(find.byType(AnimatedContainerDemoScreen), findsOneWidget);
    expect(find.text(AppStrings.animatedContainerCategory), findsOneWidget);

    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();

    expect(find.byType(ShowcaseHomeScreen), findsOneWidget);
  });
}
