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

  /// Compact conceptual code for the shared-element transition.
  static const String _codeExample = '''
// Source route — wrap the element in a Hero with a unique tag.
Hero(
  tag: 'product-image',
  child: ProductThumbnail(),
);

// Go to the destination.
Navigator.push(context, MaterialPageRoute(builder: (_) => DetailPage()));

// Destination route — same tag, larger layout.
Hero(
  tag: 'product-image',
  child: ProductImage(zoomed: true),
);

// Flutter pairs the two Heroes and flies from source to destination.
''';

  @override
  Widget build(BuildContext context) {
    return const DemoScreenShell(
      title: AppStrings.heroAnimationTitle,
      category: AppStrings.heroAnimationCategory,
      child: DemoLessonView(
        intro:
            'Hero is a shared-element animation: place a Hero widget with the '
            'same tag on both the source and the destination route, and '
            'Flutter flies the element between the two screens during '
            'navigation.',
        demo: HeroAnimationDemo(),
        demonstrates: 'Shared Element Animation',
        codeExample: _codeExample,
        howItWorks: [
          'Wrap the element you want to share (an avatar, card or image) in a '
              'Hero with a unique tag on the source route.',
          'Add a matching Hero with the same tag on the destination route so '
              'the framework can pair them.',
          'Hero tags must be unique within the active route subtree — '
              'exactly one Hero per tag on each screen.',
          'Navigate with Navigator.push; during the overlay flight the source '
              'Hero morphs into the destination Hero, interpolating position, '
              'size and shape.',
          'Popping the route runs the whole transition in reverse — the '
              'element flies back to the source screen.',
        ],
        flow: [
          'Source Hero',
          'Navigator.push',
          'Hero Flight',
          'Destination Hero',
        ],
        keyClasses: [
          (
            name: 'Hero',
            detail:
                'Renders a widget that "flies" between routes. It is matched '
                'by its tag, which must be unique within the active route '
                'subtree — one Hero per tag per screen.',
          ),
          (
            name: 'Navigator',
            detail:
                'Manages the route stack; during a push or pop it hosts the '
                'overlay in which matched Heroes animate their flight.',
          ),
          (
            name: 'Route',
            detail:
                'A single screen (page) on the stack. Each route owns its '
                'Hero subtree, so the same tag may appear on two routes at '
                'once — but only once per route.',
          ),
          (
            name: 'MaterialPageRoute',
            detail:
                'The standard Material route used to push the destination '
                'screen for this demo; its transition plays underneath the '
                'Hero flight.',
          ),
        ],
        whenToUse: [
          'Product thumbnail in a list flying to its full-size product detail.',
          'Profile avatar in a list expanding into the profile screen.',
          'Gallery thumbnail morphing into a fullscreen image view.',
        ],
      ),
    );
  }
}
