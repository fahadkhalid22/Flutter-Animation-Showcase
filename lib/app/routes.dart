import 'package:flutter/material.dart';

import '../features/animated_container/animated_container_demo_screen.dart';
import '../features/custom_route/custom_route_demo_screen.dart';
import '../features/guide/animation_guide_screen.dart';
import '../features/hero_animation/hero_animation_demo_screen.dart';
import '../features/home/showcase_home_screen.dart';
import '../features/staggered_animation/staggered_animation_demo_screen.dart';
import '../features/tween_rotation/tween_rotation_demo_screen.dart';

/// Central registry of every navigation route in the application.
///
/// All screens are reached through these named routes so navigation stays
/// consistent and the home dashboard never hard-codes screen constructors.
abstract final class AppRoutes {
  /// Home dashboard listing every animation demo.
  static const String home = '/';

  /// Demo 01 — AnimatedContainer (implicit animation).
  static const String animatedContainer = '/animated-container';

  /// Demo 02 — Hero (shared element animation).
  static const String heroAnimation = '/hero-animation';

  /// Demo 03 — Tween rotation (explicit animation).
  static const String tweenRotation = '/tween-rotation';

  /// Demo 04 — Staggered sequence (exactly four animated items).
  static const String staggeredAnimation = '/staggered-animation';

  /// Demo 05 — Custom Slide + Fade route via PageRouteBuilder.
  static const String customRoute = '/custom-route';

  /// Reference guide comparing every animation technique in the showcase.
  static const String guide = '/animation-guide';

  /// Resolves a route name to its screen widget.
  static Route<void> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => _screenFor(settings.name),
    );
  }

  static Widget _screenFor(String? name) {
    switch (name) {
      case animatedContainer:
        return const AnimatedContainerDemoScreen();
      case heroAnimation:
        return const HeroAnimationDemoScreen();
      case tweenRotation:
        return const TweenRotationDemoScreen();
      case staggeredAnimation:
        return const StaggeredAnimationDemoScreen();
      case customRoute:
        return const CustomRouteDemoScreen();
      case guide:
        return const AnimationGuideScreen();
      case home:
      default:
        return const ShowcaseHomeScreen();
    }
  }
}
