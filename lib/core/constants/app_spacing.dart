import 'package:flutter/painting.dart';

/// Spacing scale tokens for the showcase design system.
///
/// All layout spacing in the app snaps to this 4 px base scale so vertical
/// rhythm and horizontal gutters stay consistent across screens.
abstract final class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double xxxl = 32;

  /// Convenience symmetric horizontal padding for a standard page edge.
  static const EdgeInsets pagePadding = EdgeInsets.symmetric(horizontal: xl);
}
