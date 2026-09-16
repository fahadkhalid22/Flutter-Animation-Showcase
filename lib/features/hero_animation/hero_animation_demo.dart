import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_spacing.dart';
import '../../shared/motion_orb.dart';
import 'hero_animation_destination_screen.dart';
import 'hero_tags.dart';

/// Interactive Hero source: a tappable shared element that flies to the
/// destination route when tapped.
///
/// The orb is wrapped in a [Hero] with [HeroTags.motionObject]; the
/// destination route reuses the same tag so the Navigator can pick the two
/// heroes apart and animate the flight between them.
class HeroAnimationDemo extends StatelessWidget {
  /// Creates the Hero source demo.
  const HeroAnimationDemo({super.key});

  void _openDestination(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const HeroDestinationScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      height: 360,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: const Color(0xFF242947)),
      ),
      child: Column(
        children: [
          const Spacer(flex: 10),
          Hero(
            tag: HeroTags.motionObject,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: () => _openDestination(context),
                child: const MotionOrb(size: 150),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          const Icon(
            Icons.touch_app_rounded,
            size: 18,
            color: AppColors.accent,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Tap the object to explore the Hero transition.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const Spacer(flex: 9),
        ],
      ),
    );
  }
}
