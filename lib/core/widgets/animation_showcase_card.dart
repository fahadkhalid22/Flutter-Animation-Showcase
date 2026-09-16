import 'package:flutter/material.dart';

import '../../shared/demo_descriptor.dart';
import '../constants/app_colors.dart';
import '../constants/app_radius.dart';
import '../constants/app_spacing.dart';

/// Tappable card summarising one animation demo on the dashboard.
///
/// Shows the demo number, category, title, description, a tinted icon tile
/// and a forward arrow indicating the screen can be opened.
class AnimationShowcaseCard extends StatelessWidget {
  /// Creates an [AnimationShowcaseCard].
  const AnimationShowcaseCard({super.key, required this.demo, this.onTap});

  /// The demo this card describes.
  final DemoDescriptor demo;

  /// Called when the card is tapped; opens the demo route when provided.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(color: const Color(0xFF242947)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _IconTile(accent: demo.accent, icon: demo.icon),
              const SizedBox(width: AppSpacing.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          demo.number.toString().padLeft(2, '0'),
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: demo.accent,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Text(
                            demo.category,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: AppColors.textSecondary,
                              letterSpacing: 0.4,
                              fontSize: 12,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(demo.title, style: theme.textTheme.titleMedium),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      demo.description,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              const Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: AppColors.secondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Rounded tile holding the demo's icon on an accent gradient.
class _IconTile extends StatelessWidget {
  const _IconTile({required this.accent, required this.icon});

  /// Tint colour driving the tile gradient.
  final Color accent;

  /// Icon rendered on the tile.
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.md),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [accent, accent.withValues(alpha: 0.40)],
        ),
      ),
      child: Icon(icon, size: 26, color: Colors.white),
    );
  }
}
