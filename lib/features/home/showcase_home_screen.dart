import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';

/// Home dashboard of the showcase.
///
/// Phase 1 placeholder: the full dashboard grid with the five animation
/// cards is built in a later step.
class ShowcaseHomeScreen extends StatelessWidget {
  /// Creates the home dashboard screen.
  const ShowcaseHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF13152A), Color(0xFF0E1020)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Text(
              AppStrings.appTitle,
              style: theme.textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
