import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';

/// A glossy, orbit-themed visual used as the shared element in the Hero demo.
///
/// Sized by [size] so the same visual can start small on the source route and
/// grow on the destination route — letting the Hero flight demonstrate scale
/// change as it moves between the two screens.
class MotionOrb extends StatelessWidget {
  /// Creates a [MotionOrb].
  const MotionOrb({super.key, this.size = 140});

  /// Diameter of the orb in logical pixels.
  final double size;

  @override
  Widget build(BuildContext context) {
    final double satellite = size * 0.09;
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          // Soft glow behind the orb.
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.55),
                  blurRadius: size * 0.28,
                  spreadRadius: size * 0.04,
                ),
              ],
            ),
          ),
          // Gradient sphere.
          Container(
            width: size,
            height: size,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: SweepGradient(
                colors: [
                  AppColors.primary,
                  AppColors.secondary,
                  AppColors.accent,
                  AppColors.primary,
                ],
              ),
            ),
          ),
          // Dark core for a 3D sphere feel.
          Container(
            width: size * 0.6,
            height: size * 0.6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [AppColors.surfaceRaised, AppColors.background],
              ),
            ),
          ),
          // Orbit ring around the sphere.
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.accent.withValues(alpha: 0.45),
                width: 2,
              ),
            ),
          ),
          // Orbiting satellite riding the rim.
          Align(
            alignment: const Alignment(0, -0.72),
            child: Container(
              width: satellite * 2,
              height: satellite * 2,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.accent,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accent.withValues(alpha: 0.8),
                    blurRadius: 8,
                  ),
                ],
              ),
            ),
          ),
          // Centre icon.
          Icon(
            Icons.auto_awesome_rounded,
            color: AppColors.textPrimary,
            size: size * 0.24,
          ),
        ],
      ),
    );
  }
}
