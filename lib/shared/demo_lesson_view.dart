import 'package:flutter/material.dart';

import '../core/constants/app_spacing.dart';
import '../core/constants/app_strings.dart';
import '../core/widgets/concept_card.dart';
import '../core/widgets/section_title.dart';

/// The standard educational layout for a demo screen.
///
/// Renders the introduction, the interactive demo area and the three
/// learning sections every demo must explain: How It Works, Key Classes
/// and When To Use.
class DemoLessonView extends StatelessWidget {
  /// Creates a [DemoLessonView].
  const DemoLessonView({
    super.key,
    required this.intro,
    required this.demo,
    required this.howItWorks,
    required this.keyClasses,
    required this.whenToUse,
  });

  /// Short introduction to the technique.
  final String intro;

  /// The interactive demo area (a placeholder until Phase 2).
  final Widget demo;

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
        const SizedBox(height: AppSpacing.xxl),
        const SectionTitle(text: AppStrings.howItWorks),
        const SizedBox(height: AppSpacing.md),
        for (final (int i, String step) in howItWorks.indexed) ...[
          ConceptCard(index: i + 1, body: step),
          const SizedBox(height: AppSpacing.md),
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
