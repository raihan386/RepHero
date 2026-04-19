/// ===================================================================
/// FitQuest — Character Sheet Screen
/// ===================================================================
/// Hero profile displaying RPG-style stats in themed "stat cards":
///   • Level (with animated EXP bar)
///   • Total Calories Burned
///   • Workout Streak
/// ===================================================================

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/pixel_border_container.dart';
import '../providers/player_provider.dart';

class CharacterSheetScreen extends StatelessWidget {
  const CharacterSheetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final player = context.watch<PlayerProvider>();
    final scheme = Theme.of(context).colorScheme;
    final text   = Theme.of(context).textTheme;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            // ── Avatar & Title ─────────────────────────────────────────
            PixelBorderContainer(
              child: Column(
                children: [
                  // Pixel-style avatar placeholder
                  Container(
                    width: 96,
                    height: 96,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          scheme.primary.withValues(alpha: 0.7),
                          scheme.secondary.withValues(alpha: 0.7),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      border: Border.all(
                        color: scheme.primary.withValues(alpha: 0.5),
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      Icons.person,
                      size: 52,
                      color: scheme.onPrimary,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    AppStrings.characterTitle,
                    style: text.headlineMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Adventurer Class',
                    style: text.bodySmall,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ── Stat Cards ─────────────────────────────────────────────
            _StatCard(
              icon: Icons.shield,
              title: AppStrings.levelLabel,
              value: '${player.level}',
              accent: scheme.secondary,
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${player.currentExp} / ${player.expToNextLevel} EXP',
                    style: text.bodySmall,
                  ),
                  const SizedBox(height: 6),
                  SizedBox(
                    width: 140,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: player.expProgress,
                        minHeight: 8,
                        backgroundColor:
                            scheme.primary.withValues(alpha: 0.12),
                        valueColor: AlwaysStoppedAnimation(scheme.secondary),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            _StatCard(
              icon: Icons.local_fire_department,
              title: AppStrings.totalCalories,
              value: '${player.totalCalories} kcal',
              accent: const Color(0xFFFF7043),
            ),

            const SizedBox(height: 12),

            _StatCard(
              icon: Icons.bolt,
              title: AppStrings.workoutStreak,
              value: '${player.workoutStreak} days',
              accent: const Color(0xFF66BB6A),
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================================
// _StatCard — private reusable stat row
// =====================================================================

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String   title;
  final String   value;
  final Color    accent;
  final Widget?  trailing;

  const _StatCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.accent,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return PixelBorderContainer(
      borderColor: accent.withValues(alpha: 0.6),
      child: Row(
        children: [
          // Icon badge
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: accent, size: 28),
          ),
          const SizedBox(width: 16),

          // Title + value
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: text.bodySmall),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: text.titleMedium?.copyWith(
                    color: accent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Optional trailing widget (e.g. EXP bar)
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
