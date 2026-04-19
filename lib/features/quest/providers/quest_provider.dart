/// ===================================================================
/// FitQuest — Quest Provider  (Finite State Machine)
/// ===================================================================
/// Implements a simple FSM with three states:
///
///   ┌──────┐  start()  ┌───────────────┐  rest()  ┌─────────┐
///   │ Idle │──────────►│ ActiveWorkout │────────►│ Resting │
///   └──────┘           └───────────────┘          └─────────┘
///       ▲                                             │
///       │                 resume()   ┌────────────────┘
///       │ finish()                   ▼
///       └────────────── ActiveWorkout
///
/// The UI reacts to the current state by changing background colour,
/// indicator text, and available action buttons.
/// ===================================================================

import 'dart:async';
import 'package:flutter/material.dart';

/// The three possible workout states.
enum WorkoutState { idle, activeWorkout, resting }

class QuestProvider extends ChangeNotifier {
  // ── FSM State ───────────────────────────────────────────────────────
  WorkoutState _state = WorkoutState.idle;
  WorkoutState get state => _state;

  // ── Elapsed Timer ───────────────────────────────────────────────────
  int _elapsedSeconds = 0;
  int get elapsedSeconds => _elapsedSeconds;
  Timer? _timer;

  int _setCount = 0;
  int get setCount => _setCount;

  // ── FSM Transitions ────────────────────────────────────────────────

  /// Idle ➜ ActiveWorkout:  begin the workout session.
  void start() {
    if (_state != WorkoutState.idle) return;
    _state = WorkoutState.activeWorkout;
    _elapsedSeconds = 0;
    _setCount = 0;
    _startTimer();
    notifyListeners();
  }

  /// ActiveWorkout ➜ Resting:  take a rest between sets.
  void rest() {
    if (_state != WorkoutState.activeWorkout) return;
    _state = WorkoutState.resting;
    _setCount++;
    _stopTimer();
    notifyListeners();
  }

  /// Resting ➜ ActiveWorkout:  resume the next set.
  void resume() {
    if (_state != WorkoutState.resting) return;
    _state = WorkoutState.activeWorkout;
    _startTimer();
    notifyListeners();
  }

  /// Any ➜ Idle:  end the entire workout session.
  void finish() {
    _state = WorkoutState.idle;
    _stopTimer();
    notifyListeners();
  }

  // ── Timer Helpers ──────────────────────────────────────────────────

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _elapsedSeconds++;
      notifyListeners();
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  /// Formatted mm:ss string for the elapsed counter.
  String get formattedTime {
    final m = (_elapsedSeconds ~/ 60).toString().padLeft(2, '0');
    final s = (_elapsedSeconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  // ── Cleanup ────────────────────────────────────────────────────────
  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }
}
