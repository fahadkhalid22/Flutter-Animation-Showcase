import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_radius.dart';
import '../core/constants/app_spacing.dart';

/// Stage for the interactive demo area of a Phase 1 demo screen.
///
/// Stands in for the real animated example, which is built in a later
/// phase. The box shares the proportions of the future demo surface so
/// the layout does not shift once the animation lands.
class DemoPlaceholder extends StatelessWidget {
  /// Creates a [DemoPlaceholder].
  const DemoPlaceholder({super.key, this.height = 220});

  /// Height of the demo stage.
  final double height;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.surfaceRaised, AppColors.surface],
        ),
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: const Color(0xFF242947)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.motion_photos_on,
            size: 44,
            color: AppColors.secondary,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Demo area',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Interactive animation comes in Phase 2',
            style: theme.textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
