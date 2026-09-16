import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_radius.dart';
import '../constants/app_spacing.dart';

/// Compact info card for one step, API class or recommendation.
///
/// Supports three leading styles: an [icon], a numbered [index], or (when
/// neither is given) a small accent dot — a plain bullet.
class ConceptCard extends StatelessWidget {
  /// Creates a [ConceptCard].
  const ConceptCard({
    super.key,
    this.title,
    this.index,
    this.icon,
    required this.body,
  });

  /// Optional bold heading, e.g. an API class name.
  final String? title;

  /// Optional leading number, e.g. a step in a sequence.
  final int? index;

  /// Optional leading icon replacing the number/dot.
  final IconData? icon;

  /// Main body text.
  final String body;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md + 2),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: const Color(0xFF242947)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Leading(index: index, icon: icon),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null) ...[
                  Text(
                    title!,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                ],
                Text(
                  body,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Leading visual: icon, number tile or accent dot.
class _Leading extends StatelessWidget {
  const _Leading({this.index, this.icon});

  final int? index;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    if (icon != null) {
      return Icon(icon, size: 18, color: AppColors.secondary);
    }
    if (index != null) {
      return Container(
        width: 26,
        height: 26,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.14),
          shape: BoxShape.circle,
        ),
        child: Text(
          '$index',
          style: const TextStyle(
            color: AppColors.chipLabel,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      );
    }
    return Container(
      width: 8,
      height: 8,
      margin: const EdgeInsets.only(top: 6),
      decoration: const BoxDecoration(
        color: AppColors.accent,
        shape: BoxShape.circle,
      ),
    );
  }
}
