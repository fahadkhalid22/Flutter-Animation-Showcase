import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';
import '../../shared/demo_lesson_view.dart';
import '../../shared/demo_screen_shell.dart';
import 'hero_animation_demo.dart';

/// Demo 02 — Hero Animation.
///
/// Shared element animation: a widget animated seamlessly between two
/// routes by placing a `Hero` with the same tag on both screens.
class HeroAnimationDemoScreen extends StatelessWidget {
  /// Creates the Hero animation demo screen.
  const HeroAnimationDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DemoScreenShell(
      title: AppStrings.heroAnimationTitle,
      category: AppStrings.heroAnimationCategory,
      child: DemoLessonView(
        intro:
            'Hero is a shared-element animation. Place a Hero widget with the '
            'same tag on both the source and destination route, and Flutter '
            'flies the element between the two screens during navigation.',
        demo: HeroAnimationDemo(),
        howItWorks: [
          'Wrap the element you want to share (an avatar, card or image) in a '
              'Hero on the source route.',
          'Add a matching Hero with the same tag on the destination route so '
              'the framework can pair them.',
          'Navigate with Navigator.push or pushNamed; during the transition '
              'the source Hero morphs into the destination Hero.',
          'The rest of the route animates normally while the shared element '
              'interpolates position, size and shape.',
        ],
        keyClasses: [
          (
            name: 'Hero',
            detail:
                'Renders a widget that "flies" between routes; matched by '
                'its unique tag.',
          ),
          (
            name: 'HeroController',
            detail:
                'Owned by the Navigator; finds Hero pairs with identical '
                'tags and animates the flight.',
          ),
          (
            name: 'MaterialPageRoute',
            detail:
                'The standard route type used to push the destination '
                'screen for this demo.',
          ),
        ],
        whenToUse: [
          'Moving a product image from a list card to its detail screen.',
          'Sharing a profile avatar from a list into a profile page.',
          'Drill-down navigation where an element should feel continuous '
              'between screens.',
        ],
      ),
    );
  }
}
