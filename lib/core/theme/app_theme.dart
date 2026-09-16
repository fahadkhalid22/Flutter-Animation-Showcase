import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

/// Central theme definition for the showcase application.
///
/// A curated dark theme built directly on the brand palette. Typography
/// relies on the platform font with a clear weight/size hierarchy rather
/// than a bundled custom font, keeping the app lean and offline-safe.
abstract final class AppTheme {
  /// Dark, motion-inspired theme used across the whole app.
  static ThemeData get dark {
    const ColorScheme scheme = ColorScheme.dark(
      primary: AppColors.primary,
      onPrimary: Color(0xFFFDFDFF),
      secondary: AppColors.secondary,
      onSecondary: Color(0xFF003354),
      tertiary: AppColors.accent,
      onTertiary: Color(0xFF00382B),
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
      onSurfaceVariant: AppColors.textSecondary,
      error: Color(0xFFFF6B6B),
      onError: Color(0xFF360A0A),
      outline: Color(0xFF2A2E4A),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: 'Roboto',
      textTheme: _textTheme,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
      ),
      cardTheme: const CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          side: BorderSide(color: Color(0xFF242947)),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.primary.withValues(alpha: 0.14),
        side: BorderSide(color: AppColors.primary.withValues(alpha: 0.35)),
        labelStyle: const TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: const Color(0xFFFDFDFF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
        ),
      ),
      iconTheme: const IconThemeData(color: AppColors.textPrimary),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textPrimary,
          side: const BorderSide(color: Color(0xFF2E3355)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: Color(0xFF242947),
        thickness: 1,
      ),
    );
  }

  static TextTheme get _textTheme {
    const Color primary = AppColors.textPrimary;
    const Color secondary = AppColors.textSecondary;
    const Color accent = AppColors.accent;
    final TextTheme base = ThemeData.dark().textTheme;

    return base.copyWith(
      displaySmall: base.displaySmall?.copyWith(
        color: primary,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.5,
        height: 1.1,
      ),
      headlineSmall: base.headlineSmall?.copyWith(
        color: primary,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.3,
      ),
      titleLarge: base.titleLarge?.copyWith(
        color: primary,
        fontWeight: FontWeight.w700,
      ),
      titleMedium: base.titleMedium?.copyWith(
        color: primary,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: base.bodyLarge?.copyWith(color: primary, height: 1.55),
      bodyMedium: base.bodyMedium?.copyWith(color: secondary, height: 1.55),
      bodySmall: base.bodySmall?.copyWith(
        color: accent,
        fontWeight: FontWeight.w500,
      ),
      labelMedium: base.labelMedium?.copyWith(
        color: secondary,
        letterSpacing: 0.2,
      ),
    );
  }
}
