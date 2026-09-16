import 'package:flutter/material.dart';

/// Professional stand-in for an interactive demo area.
///
/// Used by every Phase 1 demo screen while the real animated demo for each
/// technique is still being built. Replaced by the actual demos in later
/// phases.
class DemoPlaceholder extends StatelessWidget {
  /// Creates a [DemoPlaceholder].
  const DemoPlaceholder({super.key, required this.description});

  /// One-line description of the demo shown above the stand-in area.
  final String description;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(description, style: theme.textTheme.bodyMedium),
        const SizedBox(height: 24),
        Center(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 32),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.motion_photos_on,
                  size: 56,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(height: 12),
                Text(
                  'Interactive demo\ncoming in Phase 2',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodySmall!.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
