/// ===================================================================
/// FitQuest — Active Quest Screen  (FSM-driven UI)
/// ===================================================================
/// The workout session view. Its background colour, status indicator,
/// and action buttons all change dynamically based on the current
/// [WorkoutState] from [QuestProvider].
///
/// State transitions:
///   Idle ─► ActiveWorkout ─► Resting ─► ActiveWorkout ─► … ─► Idle
/// ===================================================================

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/pixel_border_container.dart';
import '../providers/quest_provider.dart';

class ActiveQuestScreen extends StatelessWidget {
  const ActiveQuestScreen({super.key});

  // ── Helper: resolve visual properties from the FSM state ──────────
  Color _bgColor(WorkoutState s) {
    switch (s) {
      case WorkoutState.idle:          return AppTheme.idle;
      case WorkoutState.activeWorkout: return AppTheme.activeWorkout;
      case WorkoutState.resting:       return AppTheme.resting;
    }
  }

  String _statusLabel(WorkoutState s) {
    switch (s) {
      case WorkoutState.idle:          return AppStrings.statusIdle;
      case WorkoutState.activeWorkout: return AppStrings.statusActive;
      case WorkoutState.resting:       return AppStrings.statusResting;
    }
  }

  IconData _statusIcon(WorkoutState s) {
    switch (s) {
      case WorkoutState.idle:          return Icons.hourglass_empty;
      case WorkoutState.activeWorkout: return Icons.directions_run;
      case WorkoutState.resting:       return Icons.self_improvement;
    }
  }

  @override
  Widget build(BuildContext context) {
    final quest  = context.watch<QuestProvider>();
    final scheme = Theme.of(context).colorScheme;
    final text   = Theme.of(context).textTheme;

    final bg    = _bgColor(quest.state);
    final label = _statusLabel(quest.state);
    final icon  = _statusIcon(quest.state);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      color: bg,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            children: [
              const Spacer(),

              // ── Status Indicator ─────────────────────────────────────
              PixelBorderContainer(
                borderColor: scheme.primary,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Animated icon
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      child: Icon(
                        icon,
                        key: ValueKey(quest.state),
                        size: 64,
                        color: scheme.primary,
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Status label
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: Text(
                        label,
                        key: ValueKey(label),
                        style: text.headlineMedium?.copyWith(
                          color: scheme.primary,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Elapsed time
                    Text(
                      quest.formattedTime,
                      style: text.headlineLarge?.copyWith(fontSize: 36),
                    ),
                    const SizedBox(height: 8),

                    // Set count
                    Text(
                      'Sets completed: ${quest.setCount}',
                      style: text.bodyMedium,
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // ── Action Buttons (change per state) ────────────────────
              _buildActions(context, quest),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds different button layouts depending on the FSM state.
  Widget _buildActions(BuildContext context, QuestProvider quest) {
    switch (quest.state) {
      // ── Idle: single START button ──────────────────────────────────
      case WorkoutState.idle:
        return SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton.icon(
            onPressed: quest.start,
            icon: const Icon(Icons.play_arrow_rounded, size: 28),
            label: const Text(AppStrings.btnStart),
          ),
        );

      // ── Active: REST and FINISH buttons ────────────────────────────
      case WorkoutState.activeWorkout:
        return Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: quest.rest,
                  icon: const Icon(Icons.pause_rounded),
                  label: const Text(AppStrings.btnRest),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: SizedBox(
                height: 56,
                child: OutlinedButton.icon(
                  onPressed: quest.finish,
                  icon: const Icon(Icons.stop_rounded),
                  label: const Text(AppStrings.btnFinish),
                  style: OutlinedButton.styleFrom(
                    foregroundColor:
                        Theme.of(context).colorScheme.error,
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );

      // ── Resting: RESUME and FINISH buttons ─────────────────────────
      case WorkoutState.resting:
        return Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: quest.resume,
                  icon: const Icon(Icons.play_arrow_rounded),
                  label: const Text(AppStrings.btnResume),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: SizedBox(
                height: 56,
                child: OutlinedButton.icon(
                  onPressed: quest.finish,
                  icon: const Icon(Icons.stop_rounded),
                  label: const Text(AppStrings.btnFinish),
                  style: OutlinedButton.styleFrom(
                    foregroundColor:
                        Theme.of(context).colorScheme.error,
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
    }
  }
}
