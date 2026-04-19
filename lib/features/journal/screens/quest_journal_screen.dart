/// ===================================================================
/// FitQuest — Quest Journal Screen
/// ===================================================================
/// Displays a scrollable list of past workout entries pulled from
/// [JournalProvider]. Each entry shows the quest name, date,
/// duration, and EXP earned in an RPG-styled list tile.
/// ===================================================================

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/pixel_border_container.dart';
import '../providers/journal_provider.dart';

class QuestJournalScreen extends StatelessWidget {
  const QuestJournalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final journal = context.watch<JournalProvider>();
    final text    = Theme.of(context).textTheme;
    final scheme  = Theme.of(context).colorScheme;

    return SafeArea(
      child: journal.entries.isEmpty
          // ── Empty State ──────────────────────────────────────────────
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.menu_book_rounded,
                    size: 64,
                    color: scheme.primary.withValues(alpha: 0.3),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No quests recorded yet',
                    style: text.bodyMedium?.copyWith(
                      color: scheme.primary.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
            )
          // ── Entry List ───────────────────────────────────────────────
          : ListView.separated(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              itemCount: journal.entries.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final entry = journal.entries[index];
                return _JournalTile(entry: entry);
              },
            ),
    );
  }
}

// =====================================================================
// _JournalTile — a single quest-log entry
// =====================================================================

class _JournalTile extends StatelessWidget {
  final JournalEntry entry;
  const _JournalTile({required this.entry});

  @override
  Widget build(BuildContext context) {
    final text   = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;

    return PixelBorderContainer(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          // Quest icon
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: scheme.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.auto_stories_rounded,
              color: scheme.primary,
              size: 26,
            ),
          ),
          const SizedBox(width: 14),

          // Quest info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(entry.questName, style: text.titleMedium),
                const SizedBox(height: 4),
                Text(
                  '${entry.date}  •  ${entry.duration}',
                  style: text.bodySmall,
                ),
              ],
            ),
          ),

          // EXP badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: scheme.secondary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '+${entry.expEarned} XP',
              style: text.labelLarge?.copyWith(fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }
}
