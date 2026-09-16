import 'package:flutter/material.dart';

import '../app/routes.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_strings.dart';

/// Static description of one animation demo shown on the dashboard.
class DemoDescriptor {
  /// Creates a [DemoDescriptor].
  const DemoDescriptor({
    required this.number,
    required this.title,
    required this.category,
    required this.description,
    required this.icon,
    required this.accent,
    required this.route,
  });

  /// Position in the showcase (1–5).
  final int number;

  /// Display name of the demo.
  final String title;

  /// Animation family, e.g. `Explicit Animation`.
  final String category;

  /// One- or two-line explanation of what the demo demonstrates.
  final String description;

  /// Leading icon rendered on the card.
  final IconData icon;

  /// Accent colour that tints the card icon tile.
  final Color accent;

  /// Named route that opens the demo screen.
  final String route;
}

/// The five demos featured in the showcase, in presentation order.
const List<DemoDescriptor> kAnimationDemos = [
  DemoDescriptor(
    number: 1,
    title: AppStrings.animatedContainerTitle,
    category: AppStrings.animatedContainerCategory,
    description: AppStrings.animatedContainerDescription,
    icon: Icons.rounded_corner,
    accent: AppColors.primary,
    route: AppRoutes.animatedContainer,
  ),
  DemoDescriptor(
    number: 2,
    title: AppStrings.heroAnimationTitle,
    category: AppStrings.heroAnimationCategory,
    description: AppStrings.heroAnimationDescription,
    icon: Icons.visibility,
    accent: AppColors.secondary,
    route: AppRoutes.heroAnimation,
  ),
  DemoDescriptor(
    number: 3,
    title: AppStrings.tweenRotationTitle,
    category: AppStrings.tweenRotationCategory,
    description: AppStrings.tweenRotationDescription,
    icon: Icons.rotate_right,
    accent: AppColors.accent,
    route: AppRoutes.tweenRotation,
  ),
  DemoDescriptor(
    number: 4,
    title: AppStrings.staggeredAnimationTitle,
    category: AppStrings.staggeredAnimationCategory,
    description: AppStrings.staggeredAnimationDescription,
    icon: Icons.view_carousel,
    accent: Color(0xFFFF6BB5),
    route: AppRoutes.staggeredAnimation,
  ),
  DemoDescriptor(
    number: 5,
    title: AppStrings.customRouteTitle,
    category: AppStrings.customRouteCategory,
    description: AppStrings.customRouteDescription,
    icon: Icons.auto_awesome,
    accent: Color(0xFFFFC24D),
    route: AppRoutes.customRoute,
  ),
];
