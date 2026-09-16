import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_radius.dart';
import '../constants/app_spacing.dart';

/// Compact, read-only code snippet rendered in a terminal-style card.
///
/// Used to show a small conceptual example — never a full source file.
class CodeExampleCard extends StatelessWidget {
  /// Creates a [CodeExampleCard].
  const CodeExampleCard({super.key, this.title, required this.code});

  /// Optional caption shown in the card header.
  final String? title;

  /// The snippet to display.
  final String code;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: const Color(0xFF242947)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.sm + 2,
              AppSpacing.md,
              AppSpacing.sm,
            ),
            child: Row(
              children: [
                const _WindowDot(color: Color(0xFFFF6B6B)),
                const SizedBox(width: 6),
                const _WindowDot(color: Color(0xFFFFC24D)),
                const SizedBox(width: 6),
                const _WindowDot(color: AppColors.accent),
                if (title != null) ...[
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Text(
                      title!,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFF242947)),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Text(
              code,
              softWrap: false,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.5,
                height: 1.6,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Small window dot used in the code card header.
class _WindowDot extends StatelessWidget {
  const _WindowDot({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
