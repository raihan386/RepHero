/// ===================================================================
/// FitQuest — Navigation Provider
/// ===================================================================
/// Tracks the currently-selected index for the BottomNavigationBar.
/// ===================================================================

import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {
  int _currentIndex = 0;

  /// Currently selected tab index (0-3).
  int get currentIndex => _currentIndex;

  /// Switch to a different tab.
  void setIndex(int index) {
    if (index == _currentIndex) return; // avoid unnecessary rebuilds
    _currentIndex = index;
    notifyListeners();
  }
}
