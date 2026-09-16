import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_radius.dart';
import '../core/constants/app_spacing.dart';
import '../core/constants/app_strings.dart';
import '../core/widgets/code_example_card.dart';
import '../core/widgets/concept_card.dart';
import '../core/widgets/section_title.dart';

/// The standard educational layout for a demo screen.
///
/// Renders the introduction, the interactive demo area, and the learning
/// sections every demo must explain: What It Demonstrates, How It Works,
/// Key Classes and When To Use — plus an optional compact code example, a
/// conceptual flow diagram, and an implicit-vs-explicit comparison table.
class DemoLessonView extends StatelessWidget {
  /// Creates a [DemoLessonView].
  const DemoLessonView({
    super.key,
    required this.intro,
    required this.demo,
    this.demonstrates,
    this.codeExample,
    required this.howItWorks,
    this.flow,
    required this.keyClasses,
    this.comparison,
    required this.whenToUse,
  });

  /// Short introduction to the technique.
  final String intro;

  /// The interactive demo area for this technique.
  final Widget demo;

  /// Short label of what the demo demonstrates, e.g. `Implicit Animation`.
  final String? demonstrates;

  /// Optional compact code snippet shown under 'How It Works'.
  final String? codeExample;

  /// Ordered steps that explain how the animation works.
  final List<String> howItWorks;

  /// Optional ordered actors in the animation pipeline, drawn as a flow
  /// diagram (e.g. Controller → Tween → Animation → Transform).
  final List<String>? flow;

  /// Flutter APIs involved: `(name, detail)` pairs.
  final List<({String name, String detail})> keyClasses;

  /// Optional side-by-side comparison rows: implicit vs explicit animation.
  final List<({String aspect, String implicit, String explicit})>? comparison;

  /// Situations where the technique is the right choice.
  final List<String> whenToUse;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(intro, style: theme.textTheme.bodyMedium),
        const SizedBox(height: AppSpacing.xl),
        demo,
        if (demonstrates != null) ...[
          const SizedBox(height: AppSpacing.xxl),
          const SectionTitle(text: AppStrings.whatItDemonstrates),
          const SizedBox(height: AppSpacing.md),
          _DemonstratesBanner(label: demonstrates!),
        ],
        const SizedBox(height: AppSpacing.xxl),
        const SectionTitle(text: AppStrings.howItWorks),
        const SizedBox(height: AppSpacing.md),
        for (final (int i, String step) in howItWorks.indexed) ...[
          ConceptCard(index: i + 1, body: step),
          const SizedBox(height: AppSpacing.md),
        ],
        if (codeExample != null) ...[
          const SizedBox(height: AppSpacing.xs),
          CodeExampleCard(title: AppStrings.example, code: codeExample!),
        ],
        if (flow != null) ...[
          const SizedBox(height: AppSpacing.lg),
          const SectionTitle(text: AppStrings.conceptualFlow),
          const SizedBox(height: AppSpacing.md),
          FlowDiagram(steps: flow!),
        ],
        const SizedBox(height: AppSpacing.lg),
        const SectionTitle(text: AppStrings.keyClasses),
        const SizedBox(height: AppSpacing.md),
        for (final ({String name, String detail}) entry in keyClasses) ...[
          ConceptCard(
            title: entry.name,
            body: entry.detail,
            icon: Icons.widgets_outlined,
          ),
          const SizedBox(height: AppSpacing.md),
        ],
        const SizedBox(height: AppSpacing.lg),
        const SectionTitle(text: AppStrings.whenToUse),
        const SizedBox(height: AppSpacing.md),
        for (final String use in whenToUse) ...[
          ConceptCard(body: use, icon: Icons.check_circle_outline),
          const SizedBox(height: AppSpacing.md),
        ],
        if (comparison != null) ...[
          const SizedBox(height: AppSpacing.lg),
          const SectionTitle(text: AppStrings.implicitVsExplicit),
          const SizedBox(height: AppSpacing.md),
          ImplicitExplicitTable(rows: comparison!),
        ],
      ],
    );
  }
}

/// Vertical pipeline of numbered steps connected by arrows.
///
/// Full-width pills are safe at any screen size — a long step wraps to a
/// second line instead of overflowing horizontally.
class FlowDiagram extends StatelessWidget {
  const FlowDiagram({super.key, required this.steps});

  final List<String> steps;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final (int i, String step) in steps.indexed) ...[
          if (i > 0)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: AppSpacing.xs),
              child: Center(
                child: Icon(
                  Icons.arrow_downward_rounded,
                  size: 18,
                  color: AppColors.accent,
                ),
              ),
            ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm + 2,
            ),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(
                color: AppColors.accent.withValues(alpha: 0.35),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 22,
                  height: 22,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.accent.withValues(alpha: 0.16),
                    border: Border.all(
                      color: AppColors.accent.withValues(alpha: 0.5),
                    ),
                  ),
                  child: Text(
                    '${i + 1}',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: AppColors.accent,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(
                    step,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

/// Two-column comparison table: implicit animation vs explicit animation.
class ImplicitExplicitTable extends StatelessWidget {
  const ImplicitExplicitTable({super.key, required this.rows});

  final List<({String aspect, String implicit, String explicit})> rows;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: const Color(0xFF242947)),
      ),
      child: Column(
        children: [
          // Column headers.
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.md,
              AppSpacing.lg,
              AppSpacing.sm,
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 92,
                  child: Text('', style: theme.textTheme.labelSmall),
                ),
                Expanded(
                  child: Text(
                    'Implicit',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(
                    'Explicit',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: AppColors.accent,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ],
            ),
          ),
          for (final (
                int i,
                ({String aspect, String implicit, String explicit}) row,
              )
              in rows.indexed) ...[
            if (i > 0) const Divider(height: 1, color: Color(0xFF242947)),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.md,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 92,
                    child: Text(
                      row.aspect,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      row.implicit,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Text(
                      row.explicit,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Highlighted banner naming the animation family the demo belongs to.
class _DemonstratesBanner extends StatelessWidget {
  const _DemonstratesBanner({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md + 2,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.28)),
      ),
      child: Row(
        children: [
          const Icon(Icons.auto_awesome, size: 18, color: AppColors.accent),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              label,
              style: theme.textTheme.titleSmall?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
