import 'package:flutter/material.dart';

import '../../app/routes.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_strings.dart';
import '../../core/widgets/animation_showcase_card.dart';
import '../../core/widgets/showcase_header.dart';
import '../../shared/demo_descriptor.dart';

/// Home dashboard of the showcase.
///
/// Renders a header and five demo cards in a responsive layout: a single
/// column on phones, two columns on larger screens and tablets.
class ShowcaseHomeScreen extends StatelessWidget {
  /// Creates the home dashboard screen.
  const ShowcaseHomeScreen({super.key});

  /// Breakpoint above which the card grid switches to two columns.
  static const double _twoColumnBreakpoint = 640;

  /// The guide entry shown beneath the five demo cards.
  static const DemoDescriptor _guide = DemoDescriptor(
    number: 6,
    title: AppStrings.guideTitle,
    category: AppStrings.guideCategory,
    description: AppStrings.guideDescription,
    icon: Icons.compare_arrows,
    accent: Color(0xFFFFC24D),
    route: AppRoutes.guide,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final bool isWide = constraints.maxWidth >= _twoColumnBreakpoint;
              final double cardWidth = isWide
                  ? (constraints.maxWidth - AppSpacing.lg) / 2
                  : constraints.maxWidth;
              return SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ShowcaseHeader(),
                    const SizedBox(height: AppSpacing.xxl),
                    Wrap(
                      spacing: AppSpacing.lg,
                      runSpacing: AppSpacing.lg,
                      children: [
                        for (final DemoDescriptor demo in kAnimationDemos)
                          SizedBox(
                            width: cardWidth,
                            child: AnimationShowcaseCard(
                              demo: demo,
                              onTap: () =>
                                  Navigator.pushNamed(context, demo.route),
                            ),
                          ),
                        const SizedBox(height: AppSpacing.xs),
                        SizedBox(
                          width: cardWidth,
                          child: AnimationShowcaseCard(
                            demo: _guide,
                            onTap: () =>
                                Navigator.pushNamed(context, _guide.route),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
