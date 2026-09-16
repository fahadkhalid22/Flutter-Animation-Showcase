/// Central string constants for the showcase application.
///
/// All user-visible copy that is shared across screens lives here so text
/// stays consistent and easy to review in one place.
abstract final class AppStrings {
  // ---------------------------------------------------------------------
  // App-level copy
  // ---------------------------------------------------------------------

  /// Name of the application.
  static const String appTitle = 'Flutter Animation Showcase';

  /// One-line description shown under the title on the dashboard.
  static const String appSubtitle =
      'Explore five essential Flutter animation techniques through '
      'interactive examples.';

  /// Badge shown in the dashboard header.
  static const String demosBadge = '5 Interactive Demos';

  // ---------------------------------------------------------------------
  // Demo card copy (title / category / description)
  // ---------------------------------------------------------------------

  static const String animatedContainerTitle = 'AnimatedContainer';
  static const String animatedContainerCategory = 'Implicit Animation';
  static const String animatedContainerDescription =
      'Automatically animate supported visual properties when state '
      'changes.';

  static const String heroAnimationTitle = 'Hero Animation';
  static const String heroAnimationCategory = 'Shared Element Animation';
  static const String heroAnimationDescription =
      'Animate a widget seamlessly between two routes.';

  static const String tweenRotationTitle = 'Tween Rotation';
  static const String tweenRotationCategory = 'Explicit Animation';
  static const String tweenRotationDescription =
      'Control rotation precisely with AnimationController and Tween.';

  static const String staggeredAnimationTitle = 'Staggered Sequence';
  static const String staggeredAnimationCategory = 'Sequenced Animation';
  static const String staggeredAnimationDescription =
      'Animate four elements with different intervals on one timeline.';

  static const String customRouteTitle = 'Slide + Fade Route';
  static const String customRouteCategory = 'Custom Navigation';
  static const String customRouteDescription =
      'Create a custom route transition using PageRouteBuilder.';

  // ---------------------------------------------------------------------
  // Shared section headings used on every demo screen
  // ---------------------------------------------------------------------

  static const String whatItDemonstrates = 'What It Demonstrates';
  static const String example = 'Example';
  static const String howItWorks = 'How It Works';
  static const String conceptualFlow = 'Conceptual Flow';
  static const String keyClasses = 'Key Classes';
  static const String implicitVsExplicit = 'Implicit vs Explicit';
  static const String whenToUse = 'When To Use';
}
