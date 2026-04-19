/// ===================================================================
/// FitQuest — Reusable "Pixel Border" Container
/// ===================================================================
/// A themed card with a subtle glowing border to evoke the feel of
/// retro RPG dialogue boxes. Used across multiple feature screens.
/// ===================================================================

import 'package:flutter/material.dart';

class PixelBorderContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color? borderColor;

  const PixelBorderContainer({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final glow   = borderColor ?? scheme.primary;

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: glow.withValues(alpha: 0.4), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: glow.withValues(alpha: 0.15),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: child,
    );
  }
}
