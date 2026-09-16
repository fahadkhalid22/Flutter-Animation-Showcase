import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../shared/motion_orb.dart';
import 'hero_tags.dart';

/// Destination route for the Hero shared-element demo.
///
/// Reuses [HeroTags.motionObject] on a larger [MotionOrb] so the flight
/// visibly grows the object while flying it between the two screens. Popping
/// the route plays the reverse flight back to the source.
class HeroDestinationScreen extends StatelessWidget {
  /// Creates the Hero destination screen.
  const HeroDestinationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    tooltip: 'Back',
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back),
                  ),
                ),
                const SizedBox(height: AppSpacing.xl * 2),
                Center(
                  child: Hero(
                    tag: HeroTags.motionObject,
                    child: const MotionOrb(size: 230),
                  ),
                ),
                const SizedBox(height: AppSpacing.xxxl),
                Text(
                  'Welcome to the destination!',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
