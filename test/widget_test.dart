import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_animation_showcase/app/app.dart';
import 'package:flutter_animation_showcase/core/constants/app_strings.dart';
import 'package:flutter_animation_showcase/features/home/showcase_home_screen.dart';

void main() {
  testWidgets('app boots and shows the showcase home screen', (tester) async {
    await tester.pumpWidget(const AnimationShowcaseApp());

    expect(find.byType(ShowcaseHomeScreen), findsOneWidget);
    expect(find.text(AppStrings.appTitle), findsOneWidget);
  });
}
