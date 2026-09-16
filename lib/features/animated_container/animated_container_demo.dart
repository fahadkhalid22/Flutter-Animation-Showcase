import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_spacing.dart';

/// Interactive demo of [AnimatedContainer] — the implicit-animation showcase.
///
/// Every visual change here (size, gradient, corner radius, padding and
/// alignment) is an ordinary property swap driven by [setState]. There is no
/// [AnimationController] anywhere: [AnimatedContainer] interpolates between
/// the old and new values by itself.
class AnimatedContainerDemo extends StatefulWidget {
  /// Creates the interactive AnimatedContainer demo.
  const AnimatedContainerDemo({super.key});

  @override
  State<AnimatedContainerDemo> createState() => _AnimatedContainerDemoState();
}

class _AnimatedContainerDemoState extends State<AnimatedContainerDemo> {
  /// How long the implicit transition takes.
  static const Duration _transitionDuration = Duration(milliseconds: 650);

  /// Easing applied to every animated property.
  static const Curve _transitionCurve = Curves.easeInOutCubic;

  /// Side length of the collapsed card.
  static const double _collapsedSize = 120;

  /// Side length of the expanded card.
  static const double _expandedSize = 212;

  bool _isExpanded = false;

  /// Current transition duration. Temporarily set to [Duration.zero] by
  /// replay so the card snaps back before the animation runs again.
  Duration _duration = _transitionDuration;

  /// Expand to the animated state.
  void _animate() {
    setState(() {
      _duration = _transitionDuration;
      _isExpanded = true;
    });
  }

  /// Return to the initial state.
  void _reset() {
    setState(() {
      _duration = _transitionDuration;
      _isExpanded = false;
    });
  }

  /// Snap back instantly, then animate forward on the next frame so the
  /// transition is seen again from the very start.
  void _replay() {
    setState(() {
      _duration = Duration.zero;
      _isExpanded = false;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _duration = _transitionDuration;
        _isExpanded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildStage(),
        const SizedBox(height: AppSpacing.lg),
        _buildControls(),
      ],
    );
  }

  /// The canvas the animated card moves and grows inside.
  Widget _buildStage() {
    return Container(
      height: 280,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: const Color(0xFF242947)),
      ),
      child: AnimatedAlign(
        duration: _duration,
        curve: _transitionCurve,
        alignment: _isExpanded ? Alignment.center : Alignment.topLeft,
        child: AnimatedContainer(
          duration: _duration,
          curve: _transitionCurve,
          width: _isExpanded ? _expandedSize : _collapsedSize,
          height: _isExpanded ? _expandedSize : _collapsedSize,
          padding: EdgeInsets.all(_isExpanded ? 28 : 14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: _isExpanded
                  ? const [AppColors.secondary, AppColors.accent]
                  : [
                      AppColors.primary,
                      AppColors.primary.withValues(alpha: 0.7),
                    ],
            ),
            borderRadius: BorderRadius.circular(
              _isExpanded ? AppRadius.xxl + 12 : AppRadius.md,
            ),
            boxShadow: [
              BoxShadow(
                color: (_isExpanded ? AppColors.secondary : AppColors.primary)
                    .withValues(alpha: _isExpanded ? 0.45 : 0.30),
                blurRadius: _isExpanded ? 32 : 16,
                spreadRadius: _isExpanded ? 2 : 0,
                offset: Offset(0, _isExpanded ? 12 : 6),
              ),
            ],
          ),
          child: Center(
            child: Icon(
              _isExpanded ? Icons.open_in_full : Icons.crop_square,
              color: Colors.white,
              size: _isExpanded ? 44 : 28,
            ),
          ),
        ),
      ),
    );
  }

  /// Animate / Reset / Replay controls. Wrapped so they never overflow.
  Widget _buildControls() {
    return Wrap(
      spacing: AppSpacing.md,
      runSpacing: AppSpacing.md,
      children: [
        FilledButton.icon(
          onPressed: _animate,
          icon: const Icon(Icons.play_arrow),
          label: const Text('Animate'),
        ),
        OutlinedButton.icon(
          onPressed: _reset,
          icon: const Icon(Icons.restart_alt),
          label: const Text('Reset'),
        ),
        OutlinedButton.icon(
          onPressed: _replay,
          icon: const Icon(Icons.replay),
          label: const Text('Replay'),
        ),
      ],
    );
  }
}
