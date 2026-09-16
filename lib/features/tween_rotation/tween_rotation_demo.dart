import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_spacing.dart';

/// Interactive demo of an explicit rotation animation.
///
/// Unlike `AnimatedContainer`, nothing here animates by itself: an
/// [AnimationController] owns the timeline, a [Tween] maps its progress onto
/// an angle in radians, a [CurvedAnimation] eases it, and an
/// [AnimatedBuilder] + [Transform.rotate] render the current value.
class TweenRotationDemo extends StatefulWidget {
  /// Creates the interactive Tween rotation demo.
  const TweenRotationDemo({super.key});

  @override
  State<TweenRotationDemo> createState() => _TweenRotationDemoState();
}

class _TweenRotationDemoState extends State<TweenRotationDemo>
    with SingleTickerProviderStateMixin {
  /// How long one full rotation takes.
  static const Duration _rotationDuration = Duration(milliseconds: 2000);

  /// Owns the animation timeline. Runs from 0 to 1 (and back).
  late final AnimationController _controller;

  /// Maps controller progress onto an angle: 0 → 2π radians.
  late final Animation<double> _rotationAnimation;

  /// Whether the dial keeps looping until the user stops it.
  ///
  /// Defaults to on, but if the platform has reduced motion enabled the demo
  /// starts idle and every rotation must be requested with the controls.
  late bool _isRepeating;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _rotationDuration);
    _rotationAnimation = Tween<double>(begin: 0, end: 2 * math.pi).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
    );
    _isRepeating = !WidgetsBinding
        .instance
        .platformDispatcher
        .accessibilityFeatures
        .disableAnimations;
    if (_isRepeating) {
      // Rotate continuously until the controls are used.
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    // Never leave a ticker running after the widget goes away.
    _controller.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // Animation controls
  // ---------------------------------------------------------------------------

  String get _statusLabel {
    if (_controller.isAnimating) {
      return _controller.status == AnimationStatus.reverse
          ? 'Reversing'
          : 'Playing';
    }
    if (_controller.value == 0) return 'Idle';
    if (_controller.value >= 1) return 'Completed';
    return 'Paused';
  }

  Color get _statusColor {
    switch (_statusLabel) {
      case 'Playing':
        return AppColors.accent;
      case 'Reversing':
        return AppColors.secondary;
      case 'Paused':
        return const Color(0xFFFFC24D);
      case 'Completed':
        return AppColors.primary;
      default:
        return AppColors.textSecondary;
    }
  }

  void _play() {
    setState(() {
      if (_isRepeating) {
        _controller.repeat();
      } else {
        if (_controller.value >= 1) _controller.reset();
        _controller.forward();
      }
    });
  }

  void _pause() {
    setState(() {
      _controller.stop();
    });
  }

  void _reverse() {
    setState(() {
      _controller.reverse();
    });
  }

  void _reset() {
    setState(() {
      _controller.reset();
    });
  }

  void _setRepeating(bool value) {
    setState(() {
      _isRepeating = value;
      if (_isRepeating) {
        _controller.repeat();
      } else {
        _controller.forward();
      }
    });
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStage(),
        const SizedBox(height: AppSpacing.lg),
        _buildStatusChip(theme),
        const SizedBox(height: AppSpacing.lg),
        _buildControls(theme),
        const SizedBox(height: AppSpacing.lg),
        _buildRepeatToggle(theme),
      ],
    );
  }

  /// The canvas holding the rotating target.
  Widget _buildStage() {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: const Color(0xFF242947)),
      ),
      child: Center(
        child: AnimatedBuilder(
          animation: _rotationAnimation,
          builder: (BuildContext context, Widget? child) {
            return Transform.rotate(
              angle: _rotationAnimation.value,
              child: child,
            );
          },
          child: const _MotionDial(),
        ),
      ),
    );
  }

  /// Live status indicator pill.
  Widget _buildStatusChip(ThemeData theme) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        return Semantics(
          // Announce control changes to screen readers without requiring a
          // re-focus each time the status flips.
          liveRegion: true,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: _statusColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(color: _statusColor.withValues(alpha: 0.35)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _statusColor,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  _statusLabel,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: _statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Play / Pause / Reverse / Reset buttons.
  Widget _buildControls(ThemeData theme) {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: [
        FilledButton.icon(
          onPressed: _play,
          icon: const Icon(Icons.play_arrow_rounded, size: 20),
          label: const Text('Play'),
        ),
        OutlinedButton.icon(
          onPressed: _pause,
          icon: const Icon(Icons.pause_rounded, size: 20),
          label: const Text('Pause'),
        ),
        OutlinedButton.icon(
          onPressed: _reverse,
          icon: const Icon(Icons.skip_previous_rounded, size: 20),
          label: const Text('Reverse'),
        ),
        OutlinedButton.icon(
          onPressed: _reset,
          icon: const Icon(Icons.replay_rounded, size: 20),
          label: const Text('Reset'),
        ),
      ],
    );
  }

  /// Repeat-mode toggle row.
  Widget _buildRepeatToggle(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: const Color(0xFF242947)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.repeat_rounded,
            size: 20,
            color: AppColors.textSecondary,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              'Repeat continuously',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ),
          Switch(value: _isRepeating, onChanged: _setRepeating),
        ],
      ),
    );
  }
}

/// The rotating target: a gradient motion dial with a rim marker.
class _MotionDial extends StatelessWidget {
  const _MotionDial();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 190,
      height: 190,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Gradient ring.
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: SweepGradient(
                colors: [
                  AppColors.primary,
                  AppColors.secondary,
                  AppColors.accent,
                  AppColors.primary,
                ],
              ),
            ),
          ),
          // Inner disc punched out of the ring.
          Container(
            margin: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.background,
            ),
          ),
          // Marker riding the rim, so the rotation is easy to read.
          const Align(alignment: Alignment.topCenter, child: _RimMarker()),
          const Icon(
            Icons.rocket_launch_rounded,
            size: 40,
            color: AppColors.textPrimary,
          ),
        ],
      ),
    );
  }
}

/// Small illuminated marker that sits on the dial's rim.
class _RimMarker extends StatelessWidget {
  const _RimMarker();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 24,
      margin: const EdgeInsets.only(top: 4),
      decoration: BoxDecoration(
        color: AppColors.textPrimary,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: AppColors.accent.withValues(alpha: 0.6),
            blurRadius: 12,
          ),
        ],
      ),
    );
  }
}
