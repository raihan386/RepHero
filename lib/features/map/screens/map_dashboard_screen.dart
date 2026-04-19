/// ===================================================================
/// FitQuest — Map Dashboard Screen
/// ===================================================================
/// Main landing page. Contains:
///   • Level badge and EXP progress bar (top)
///   • Top-Down Map Area placeholder (centre)
///   • "Start Quest" CTA button (bottom)
/// ===================================================================

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/pixel_border_container.dart';
import '../../character/providers/player_provider.dart';

class MapDashboardScreen extends StatelessWidget {
  const MapDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final player = context.watch<PlayerProvider>();
    final scheme = Theme.of(context).colorScheme;
    final text   = Theme.of(context).textTheme;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          children: [
            // ── Level & EXP Bar ────────────────────────────────────────
            PixelBorderContainer(
              child: Column(
                children: [
                  // Level badge row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.shield, color: scheme.secondary, size: 22),
                      const SizedBox(width: 8),
                      Text(
                        '${AppStrings.levelLabel} ${player.level}',
                        style: text.headlineMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // EXP progress bar
                  Row(
                    children: [
                      Text(AppStrings.expLabel, style: text.labelLarge),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: LinearProgressIndicator(
                            value: player.expProgress,
                            minHeight: 14,
                            backgroundColor:
                                scheme.primary.withValues(alpha: 0.15),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              scheme.secondary,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '${player.currentExp}/${player.expToNextLevel}',
                        style: text.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ── Top-Down Map Area ──────────────────────────────────────
            Expanded(
              child: PixelBorderContainer(
                borderColor: scheme.primary.withValues(alpha: 0.5),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Grid-pattern hint (pixel crosses)
                      Icon(
                        Icons.map_outlined,
                        size: 64,
                        color: scheme.primary.withValues(alpha: 0.35),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Top-Down Map Area',
                        style: text.headlineMedium?.copyWith(
                          color: scheme.primary.withValues(alpha: 0.5),
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Your quest map will render here',
                        style: text.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ── Start Quest Button ─────────────────────────────────────
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Award a small EXP bonus on quest start (demo)
                  player.gainExp(10);
                },
                icon: const Icon(Icons.play_arrow_rounded, size: 28),
                label: const Text(AppStrings.startQuest),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
