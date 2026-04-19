/// ===================================================================
/// FitQuest — Journal Provider
/// ===================================================================
/// Holds a list of past workout entries (dummy data for now).
/// Each entry records the quest name, date, duration, and EXP earned.
/// ===================================================================

import 'package:flutter/material.dart';

/// A single journal entry representing a completed workout.
class JournalEntry {
  final String questName;
  final String date;
  final String duration;
  final int    expEarned;

  const JournalEntry({
    required this.questName,
    required this.date,
    required this.duration,
    required this.expEarned,
  });
}

class JournalProvider extends ChangeNotifier {
  // ── Dummy workout history ─────────────────────────────────────────
  final List<JournalEntry> _entries = [
    const JournalEntry(
      questName: 'Forest of Squats',
      date: '2026-04-18',
      duration: '25 min',
      expEarned: 30,
    ),
    const JournalEntry(
      questName: 'Iron Tower Push-Ups',
      date: '2026-04-17',
      duration: '18 min',
      expEarned: 22,
    ),
    const JournalEntry(
      questName: 'Cardio Canyon Run',
      date: '2026-04-16',
      duration: '35 min',
      expEarned: 45,
    ),
    const JournalEntry(
      questName: 'Dungeon Plank Hold',
      date: '2026-04-15',
      duration: '12 min',
      expEarned: 18,
    ),
    const JournalEntry(
      questName: 'Mountain Burpees',
      date: '2026-04-14',
      duration: '20 min',
      expEarned: 28,
    ),
    const JournalEntry(
      questName: 'Lunge Labyrinth',
      date: '2026-04-13',
      duration: '22 min',
      expEarned: 26,
    ),
  ];

  /// All journal entries (most-recent first).
  List<JournalEntry> get entries => List.unmodifiable(_entries);

  /// Add a new entry at the top.
  void addEntry(JournalEntry entry) {
    _entries.insert(0, entry);
    notifyListeners();
  }
}
