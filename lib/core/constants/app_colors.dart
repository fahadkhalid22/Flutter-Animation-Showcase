import 'package:flutter/material.dart';

/// Brand color tokens for the showcase design system.
///
/// The palette is a dark navy / near-black foundation with a purple
/// primary, electric blue secondary and cyan accent — chosen to make
/// motion and gradients read clearly against the background.
abstract final class AppColors {
  /// Main application background — deep navy / near black.
  static const Color background = Color(0xFF0E1020);

  /// Slightly lighter navy used for gradient highlights behind the header.
  static const Color backgroundElevated = Color(0xFF13152A);

  /// Solid card / surface color.
  static const Color surface = Color(0xFF171A2D);

  /// Slightly lighter surface for hover states or raised cards.
  static const Color surfaceRaised = Color(0xFF1D2140);

  /// Primary brand color — purple.
  static const Color primary = Color(0xFF7C5CFC);

  /// Secondary brand color — electric blue.
  static const Color secondary = Color(0xFF4DA8FF);

  /// Accent color — cyan.
  static const Color accent = Color(0xFF55E6C1);

  /// High-contrast text on dark surfaces.
  static const Color textPrimary = Color(0xFFF7F8FC);

  /// Secondary text for descriptions and captions.
  static const Color textSecondary = Color(0xFFA7ADC7);

  /// Diamond-shaped gradient used behind the dashboard header.
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [backgroundElevated, background, Color(0xFF0A0C18)],
  );
}
