import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_spacing.dart';
import '../../shared/motion_orb.dart';
import 'hero_tags.dart';

/// Destination route for the Hero shared-element demo.
///
/// Reuses [HeroTags.motionObject] on a larger [MotionOrb] so the flight
/// visibly grows the object while flying it between the two screens. Popping
/// the route plays the reverse flight back to the source.
class HeroDestinationScreen extends StatelessWidget {
  /// Creates the Hero destination screen.
  const HeroDestinationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    tooltip: 'Back',
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                // Larger, transformed version of the source orb.
                Center(
                  child: Hero(
                    tag: HeroTags.motionObject,
                    child: const MotionOrb(size: 230),
                  ),
                ),
                const SizedBox(height: AppSpacing.xxxl),
                _ArrivalBadge(),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  'You found the Motion Orb!',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  'The same orb flew here from the previous screen. Flutter '
                  'found a matching Hero tag and animated it across the '
                  'transition — position, size and shape all morphed together.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: AppSpacing.xxxl),
                OutlinedButton.icon(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.arrow_back_rounded, size: 20),
                  label: const Text('Back to Source'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Small badge confirming the hero flight completed.
class _ArrivalBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: AppColors.accent.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: AppColors.accent.withValues(alpha: 0.35)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.flight_takeoff_rounded,
              size: 16,
              color: AppColors.accent,
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              'Hero flight complete',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppColors.accent,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
