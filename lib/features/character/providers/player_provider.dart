/// ===================================================================
/// FitQuest — Player Provider
/// ===================================================================
/// Holds the hero's RPG-style stats: level, current EXP, calories
/// burned, and workout streak. Exposes helper methods to mutate
/// state and emit rebuilds via ChangeNotifier.
/// ===================================================================

import 'package:flutter/material.dart';

class PlayerProvider extends ChangeNotifier {
  // ── Core Stats ──────────────────────────────────────────────────────
  int _level          = 1;
  int _currentExp     = 60;   // dummy starting EXP
  int _expToNextLevel = 100;
  int _totalCalories  = 4280; // dummy total
  int _workoutStreak  = 7;    // dummy streak

  // ── Getters ─────────────────────────────────────────────────────────
  int    get level           => _level;
  int    get currentExp      => _currentExp;
  int    get expToNextLevel  => _expToNextLevel;
  int    get totalCalories   => _totalCalories;
  int    get workoutStreak   => _workoutStreak;

  /// EXP progress as a 0.0 – 1.0 fraction for the progress bar.
  double get expProgress     => _currentExp / _expToNextLevel;

  // ── Actions ─────────────────────────────────────────────────────────

  /// Award EXP after completing a workout set or finishing a quest.
  void gainExp(int amount) {
    _currentExp += amount;

    // Level up while we have enough EXP
    while (_currentExp >= _expToNextLevel) {
      _currentExp -= _expToNextLevel;
      _level++;
      _expToNextLevel = (_expToNextLevel * 1.25).round(); // scaling curve
    }
    notifyListeners();
  }

  /// Burn calories (called each workout tick or on set completion).
  void addCalories(int cal) {
    _totalCalories += cal;
    notifyListeners();
  }

  /// Increment daily streak (called once per qualifying day).
  void incrementStreak() {
    _workoutStreak++;
    notifyListeners();
  }
}
