import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_spacing.dart';
import '../../shared/route_transitions.dart';
import 'custom_route_destination_screen.dart';

/// Interactive start of the custom route transition.
///
/// Shows a preview of the slide-and-fade effect and a launch button that
/// pushes the destination with [buildSlideFadeRoute]. Popping the destination
/// replays the transition in reverse, so it can be launched again.
class CustomRouteDemo extends StatelessWidget {
  /// Creates the custom route demo stage.
  const CustomRouteDemo({super.key});

  void _launch(BuildContext context) {
    Navigator.of(context).push(
      buildSlideFadeRoute<void>(page: const CustomRouteDestinationScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      height: 360,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: const Color(0xFF242947)),
      ),
      child: Column(
        children: [
          const Spacer(flex: 7),
          const _TransitionPreview(),
          const SizedBox(height: AppSpacing.xl),
          Text(
            'The next page slides in from the right while fading up.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          FilledButton.icon(
            onPressed: () => _launch(context),
            icon: const Icon(Icons.rocket_launch_rounded, size: 20),
            label: const Text('Launch Custom Route'),
          ),
          const Spacer(flex: 8),
        ],
      ),
    );
  }
}

/// Static illustration of the slide + fade transition.
class _TransitionPreview extends StatelessWidget {
  const _TransitionPreview();

  @override
  Widget build(BuildContext context) {
    // The three panels plus gaps exceed the tightest phone content width
    // (~320 px). Scale the whole preview down to fit instead of letting the
    // Row overflow; wider screens keep the natural size.
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Ghost copy, fully faded — where the page starts.
          _PreviewPanel(opacity: 0.18, offset: -26),
          const SizedBox(width: 6),
          // Mid-flight copy, partially faded and pushed right.
          _PreviewPanel(opacity: 0.45, offset: -12),
          const SizedBox(width: 6),
          // Landed copy, opaque and at rest.
          const _PreviewPanel(opacity: 1.0, offset: 0),
          const SizedBox(width: AppSpacing.md),
          Icon(
            Icons.arrow_forward_rounded,
            color: AppColors.accent.withValues(alpha: 0.9),
          ),
        ],
      ),
    );
  }
}

/// One panel in the slide-and-fade preview; [opacity] is the fade stage and
/// [offset] is a horizontal nudge mimicking the slide stage.
class _PreviewPanel extends StatelessWidget {
  const _PreviewPanel({required this.opacity, required this.offset});

  final double opacity;
  final double offset;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(offset, 0),
      child: Opacity(
        opacity: opacity,
        child: Container(
          width: 92,
          height: 120,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primary.withValues(alpha: 0.7),
                AppColors.secondary.withValues(alpha: 0.55),
              ],
            ),
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(
              color: AppColors.textPrimary.withValues(alpha: 0.18),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.flight_land_rounded,
                color: Colors.white,
                size: 26,
              ),
              SizedBox(height: 8),
              Text(
                'Arrive',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
