import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_spacing.dart';
import '../../shared/demo_screen_shell.dart';
import '../../shared/demo_lesson_view.dart';

/// The dashboard-wide animation reference guide.
///
/// Compares every technique demonstrated in the showcase side by side —
/// type, level of control and what each one is best for — and explains the
/// two animation families behind them: implicit vs explicit.
class AnimationGuideScreen extends StatelessWidget {
  /// Creates the animation techniques guide screen.
  const AnimationGuideScreen({super.key});

  /// One technique's entry in the comparison guide.
  static const List<_TechniqueEntry> _techniques = [
    _TechniqueEntry(
      name: 'AnimatedContainer',
      type: 'Implicit',
      control: 'Low / medium',
      bestFor: 'Simple visual property changes',
      icon: Icons.rounded_corner,
      accent: AppColors.primary,
    ),
    _TechniqueEntry(
      name: 'Hero',
      type: 'Shared element',
      control: 'Framework-managed',
      bestFor: 'Continuity between routes',
      icon: Icons.visibility,
      accent: AppColors.secondary,
    ),
    _TechniqueEntry(
      name: 'AnimationController + Tween',
      type: 'Explicit',
      control: 'High',
      bestFor: 'Precise, reversible, repeatable animation',
      icon: Icons.tune,
      accent: AppColors.accent,
    ),
    _TechniqueEntry(
      name: 'Staggered Animation',
      type: 'Explicit sequence',
      control: 'High',
      bestFor: 'Multi-element choreographed motion',
      icon: Icons.view_carousel,
      accent: Color(0xFFFF6BB5),
    ),
    _TechniqueEntry(
      name: 'PageRouteBuilder',
      type: 'Navigation',
      control: 'High',
      bestFor: 'Custom screen transitions',
      icon: Icons.auto_awesome,
      accent: Color(0xFFFFC24D),
    ),
  ];

  /// Aspect-by-aspect breakdown of the two animation families.
  static const List<({String aspect, String implicit, String explicit})>
  _implicitExplicit = [
    (
      aspect: 'Control',
      implicit: 'The framework tween the old value to the new one for you.',
      explicit: 'You drive every frame with an AnimationController.',
    ),
    (
      aspect: 'Setup',
      implicit: 'Declare the target value (and usually a duration).',
      explicit: 'Create a controller + Tween and wire it to a transition.',
    ),
    (
      aspect: 'Replay',
      implicit: 'Changing the target re-animates to the latest value.',
      explicit: 'forward / reverse / repeat replay on demand.',
    ),
    (
      aspect: 'Best for',
      implicit: 'Simple, one-off property changes (AnimatedContainer).',
      explicit:
          'Precise, choreographed and reversible motion (rotation, '
          'staggered sequence).',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return const DemoScreenShell(
      title: 'Animation Techniques',
      category: 'Reference Guide',
      child: DemoLessonView(
        intro:
            'Every demo in this showcase belongs to one of two animation '
            'families. Implicit animations let Flutter handle the tween '
            'automatically on a state change; explicit animations give you '
            'a controller you can play, reverse and repeat exactly. Pick a '
            'technique based on how much control the motion needs.',
        demo: _GuideDemoBody(),
        demonstrates: 'Technique Comparison',
        howItWorks: [
          'Implicit animations (AnimatedContainer) change one property to '
              'another as state changes; the framework fills in every frame '
              'between the old and new value.',
          'Shared element animations (Hero) fly a widget between two routes, '
              'with the framework matching source and destination by tag.',
          'Explicit animations (AnimationController + Tween) put you in '
              'control of every frame — you choose the duration, curve and '
              'direction.',
          'A staggered animation is a single explicit timeline split into '
              'intervals, so several elements choreograph on one clock.',
          'Navigation animations (PageRouteBuilder) define how a whole '
              'screen enters and exits, staying integrated with back and '
              'gesture navigation.',
        ],
        flow: [
          'Implicit — declare a target',
          'Shared element — tag the moving widget',
          'Explicit — own the controller',
          'Staggered — slice the timeline',
          'Navigation — craft the route',
        ],
        keyClasses: [
          (
            name: 'AnimatedContainer',
            detail:
                'Implicit: animates supported properties (padding, color, '
                'size) whenever its configuration changes.',
          ),
          (
            name: 'Hero',
            detail:
                'Shared element: a widget with a tag flies from one route '
                'to a matching tag on another.',
          ),
          (
            name: 'AnimationController + Tween',
            detail:
                'Explicit: a controller ticks 0→1 while Tweens map that '
                'progress onto offsets, rotations and more.',
          ),
          (
            name: 'Staggered Animation',
            detail:
                'Explicit sequence: one controller, several Intervals, so '
                'each element starts at its own moment.',
          ),
          (
            name: 'PageRouteBuilder',
            detail:
                'Navigation: builds a route whose entrance and exit use any '
                'animation, here a slide combined with a fade.',
          ),
        ],
        comparison: _implicitExplicit,
        whenToUse: [
          'Choose implicit when a single visual property should animate on '
              'its own after a state change.',
          'Choose shared element when content should feel continuous across '
              'a navigation.',
          'Choose explicit when you need precision, reversibility or a '
              'repeatable exact timeline.',
          'Choose staggered when several elements should enter in a '
              'deliberate order on one clock.',
          'Choose PageRouteBuilder when the standard route transition is '
              'not dramatic or branded enough.',
        ],
      ),
    );
  }
}

/// The comparison list: each technique rendered as a side-by-side entry.
///
/// Shown above the educational sections so a visitor can scan the five
/// techniques against each other at a glance.
class _GuideDemoBody extends StatelessWidget {
  const _GuideDemoBody();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final (int i, _TechniqueEntry technique)
            in AnimationGuideScreen._techniques.indexed) ...[
          if (i > 0) const SizedBox(height: AppSpacing.md),
          _TechniqueRow(entry: technique),
        ],
        const SizedBox(height: AppSpacing.xl),
        Text(
          'Control runs from low (the framework decides) to high (you '
          'decide). The more choreography a scene needs, the higher the '
          'technique you reach for.',
          style: theme.textTheme.bodySmall?.copyWith(
            color: AppColors.textSecondary,
            height: 1.4,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
      ],
    );
  }
}

/// One technique entry: name, type chip, control level and best-for line.
class _TechniqueRow extends StatelessWidget {
  const _TechniqueRow({required this.entry});

  final _TechniqueEntry entry;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: entry.accent.withValues(alpha: 0.30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                  color: entry.accent.withValues(alpha: 0.14),
                ),
                child: Icon(entry.icon, size: 22, color: entry.accent),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  entry.name,
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              _TypeChip(label: entry.type, accent: entry.accent),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          _LabeledLine(
            label: 'Control',
            value: entry.control,
            accent: entry.accent,
          ),
          const SizedBox(height: AppSpacing.sm),
          _LabeledLine(
            label: 'Useful for',
            value: entry.bestFor,
            accent: entry.accent,
          ),
        ],
      ),
    );
  }
}

/// Nested label + value line inside a technique card.
class _LabeledLine extends StatelessWidget {
  const _LabeledLine({
    required this.label,
    required this.value,
    required this.accent,
  });

  final String label;
  final String value;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 76,
          padding: const EdgeInsets.symmetric(vertical: 2),
          alignment: Alignment.centerLeft,
          child: Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: accent,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
              fontSize: 11,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            value,
            style: theme.textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}

/// Small pill declaring the type, e.g. `Implicit` or `Explicit sequence`.
class _TypeChip extends StatelessWidget {
  const _TypeChip({required this.label, required this.accent});

  final String label;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: accent.withValues(alpha: 0.40)),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: accent,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

/// Data for one technique compared in the guide.
class _TechniqueEntry {
  const _TechniqueEntry({
    required this.name,
    required this.type,
    required this.control,
    required this.bestFor,
    required this.icon,
    required this.accent,
  });

  final String name;
  final String type;
  final String control;
  final String bestFor;
  final IconData icon;
  final Color accent;
}
