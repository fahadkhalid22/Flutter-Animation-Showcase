import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_radius.dart';
import '../constants/app_spacing.dart';
import '../constants/app_strings.dart';

/// Masthead for the dashboard: an activity badge, the big two-line title
/// and a short subtitle.
class ShowcaseHeader extends StatelessWidget {
  /// Creates the [ShowcaseHeader].
  const ShowcaseHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm - 2,
          ),
          decoration: BoxDecoration(
            color: AppColors.accent.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(AppRadius.sm),
            border: Border.all(color: AppColors.accent.withValues(alpha: 0.28)),
          ),
          // A Flexible label lets the badge text wrap to a second line when
          // system font scaling makes it wider than the phone, instead of
          // overflowing the pill to the right.
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.play_circle_outline,
                size: 16,
                color: AppColors.accent,
              ),
              const SizedBox(width: AppSpacing.sm - 2),
              Flexible(
                child: Text(
                  AppStrings.demosBadge,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: AppColors.accent,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text.rich(
          TextSpan(
            style: theme.textTheme.displaySmall?.copyWith(
              color: AppColors.textPrimary,
            ),
            children: const [
              TextSpan(
                text: 'Flutter\n',
                style: TextStyle(color: AppColors.secondary),
              ),
              TextSpan(text: 'Animation\nShowcase'),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          AppStrings.appSubtitle,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
