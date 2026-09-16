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
/// Key Classes and When To Use — plus an optional compact code example.
class DemoLessonView extends StatelessWidget {
  /// Creates a [DemoLessonView].
  const DemoLessonView({
    super.key,
    required this.intro,
    required this.demo,
    this.demonstrates,
    this.codeExample,
    required this.howItWorks,
    required this.keyClasses,
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

  /// Flutter APIs involved: `(name, detail)` pairs.
  final List<({String name, String detail})> keyClasses;

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
      ],
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
