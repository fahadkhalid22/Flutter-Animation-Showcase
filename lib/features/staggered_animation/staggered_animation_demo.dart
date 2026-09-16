import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_spacing.dart';

/// Interactive demo of a staggered animation sequence.
///
/// One [AnimationController] owns the whole timeline while four items each
/// claim a distinct [Interval] slice of it, so they animate one after another
/// on a shared timeline instead of all at once.
class StaggeredAnimationDemo extends StatefulWidget {
  /// Creates the staggered sequence demo.
  const StaggeredAnimationDemo({super.key});

  @override
  State<StaggeredAnimationDemo> createState() => _StaggeredAnimationDemoState();
}

class _StaggeredAnimationDemoState extends State<StaggeredAnimationDemo>
    with SingleTickerProviderStateMixin {
  /// How long the whole four-item sequence takes.
  static const Duration _sequenceDuration = Duration(milliseconds: 2600);

  /// The timing slices each item occupies on the shared 0→1 timeline.
  ///
  /// Item 1 starts immediately while Item 4 only begins 45% of the way
  /// through — every item enters the stage at a different moment.
  static const List<(double begin, double end)> _intervals = [
    (0.00, 0.40),
    (0.15, 0.55),
    (0.30, 0.70),
    (0.45, 0.85),
  ];

  /// Concept presented by each animated card, in presentation order.
  static const List<({String label, String subtitle, IconData icon})>
  _itemSpecs = [
    (
      label: 'Controller',
      subtitle: 'One AnimationController owns the whole timeline',
      icon: Icons.timeline,
    ),
    (
      label: 'Interval',
      subtitle: 'Each item claims its own slice of time',
      icon: Icons.hourglass_bottom,
    ),
    (
      label: 'Curves',
      subtitle: 'Per-item ease lands inside its own slice',
      icon: Icons.show_chart,
    ),
    (
      label: 'Sequence',
      subtitle: 'The cascade finishes one item at a time',
      icon: Icons.view_carousel,
    ),
  ];

  /// Accent tint for each item's number badge (one per presentation order).
  static const List<Color> _itemAccents = [
    AppColors.primary,
    AppColors.secondary,
    AppColors.accent,
    Color(0xFFFF6BB5),
  ];

  /// The single shared animation timeline.
  late final AnimationController _controller;

  /// One progress animation per item, each confined to its own interval.
  late final List<Animation<double>> _itemAnimations;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _sequenceDuration);
    _itemAnimations = [
      for (final (double begin, double end) in _intervals)
        Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Interval(begin, end, curve: Curves.easeOutCubic),
          ),
        ),
    ];
    // Play the sequence once on entry so the stagger is the first thing seen.
    _controller.forward();
  }

  @override
  void dispose() {
    // Never leave a ticker running after the widget goes away.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStage(),
        const SizedBox(height: AppSpacing.md),
        Text(
          'The four items enter one after another off a single controller.',
          style: theme.textTheme.bodySmall?.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  /// The canvas on which the four staggered items play out.
  Widget _buildStage() {
    return Container(
      height: 360,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: const Color(0xFF242947)),
      ),
      child: Column(
        children: [
          for (final (int i, Animation<double> animation)
              in _itemAnimations.indexed) ...[
            if (i > 0) const SizedBox(height: AppSpacing.sm),
            Expanded(
              child: _wrapItem(
                animation,
                _StaggeredItemCard(
                  number: i + 1,
                  label: _itemSpecs[i].label,
                  subtitle: _itemSpecs[i].subtitle,
                  icon: _itemSpecs[i].icon,
                  accent: _itemAccents[i],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// Applies the fade + slide + scale composition an item's interval drives.
  Widget _wrapItem(Animation<double> progress, Widget child) {
    final Animation<Offset> slide = Tween<Offset>(
      begin: const Offset(0, 0.6),
      end: Offset.zero,
    ).animate(progress);
    final Animation<double> scale = Tween<double>(
      begin: 0.92,
      end: 1,
    ).animate(progress);
    return FadeTransition(
      opacity: progress,
      child: SlideTransition(
        position: slide,
        child: ScaleTransition(scale: scale, child: child),
      ),
    );
  }
}

/// One card in the staggered sequence: a numbered concept with a badge.
class _StaggeredItemCard extends StatelessWidget {
  const _StaggeredItemCard({
    required this.number,
    required this.label,
    required this.subtitle,
    required this.icon,
    required this.accent,
  });

  /// Item position in the sequence (1–4).
  final int number;

  /// Concept name, e.g. `Interval`.
  final String label;

  /// One-line explanation of the concept.
  final String subtitle;

  /// Leading concept icon.
  final IconData icon;

  /// Accent tint for the number badge and icon.
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surfaceRaised,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: accent.withValues(alpha: 0.30)),
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: accent.withValues(alpha: 0.16),
              border: Border.all(color: accent.withValues(alpha: 0.55)),
            ),
            child: Text(
              '$number',
              style: theme.textTheme.labelLarge?.copyWith(
                color: accent,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Icon(icon, size: 22, color: accent),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 1),
                Text(
                  subtitle,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
