import 'package:flutter/material.dart';

/// Central theme definition for the showcase application.
///
/// This is the Phase 1 baseline theme. The full design system (brand
/// palette, spacing and radius tokens, gradients and typography) replaces
/// it in a later step.
abstract final class AppTheme {
  /// Dark, motion-inspired theme used across the whole app.
  static ThemeData get dark {
    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF7C5CFC),
      brightness: Brightness.dark,
    );
    return ThemeData(
      colorScheme: scheme,
      scaffoldBackgroundColor: const Color(0xFF0E1020),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
      ),
    );
  }
}
