import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import 'routes.dart';

/// Root widget of the Flutter Animation Showcase application.
class AnimationShowcaseApp extends StatelessWidget {
  /// Creates the root application widget.
  const AnimationShowcaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Animation Showcase',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      initialRoute: AppRoutes.home,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
