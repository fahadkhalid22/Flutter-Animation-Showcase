import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';

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

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _rotationDuration);
    _rotationAnimation = Tween<double>(begin: 0, end: 2 * math.pi).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
    );
    // Rotate continuously until the controls are used.
    _controller.repeat();
  }

  @override
  void dispose() {
    // Never leave a ticker running after the widget goes away.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildStage();
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
