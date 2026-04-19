/// ===================================================================
/// FitQuest — Main App Shell
/// ===================================================================
/// The root Scaffold that hosts the [BottomNavigationBar] and swaps
/// between the four feature screens via an [IndexedStack] (so each
/// page preserves its state when switching tabs).
/// ===================================================================

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/constants/app_strings.dart';
import '../core/providers/navigation_provider.dart';
import '../features/character/screens/character_sheet_screen.dart';
import '../features/journal/screens/quest_journal_screen.dart';
import '../features/map/screens/map_dashboard_screen.dart';
import '../features/quest/screens/active_quest_screen.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key});

  // The four main pages.
  static const List<Widget> _pages = [
    MapDashboardScreen(),
    ActiveQuestScreen(),
    CharacterSheetScreen(),
    QuestJournalScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final nav    = context.watch<NavigationProvider>();
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      // AppBar title changes per tab
      appBar: AppBar(
        title: Text(_appBarTitle(nav.currentIndex)),
        leading: Padding(
          padding: const EdgeInsets.all(10),
          child: Icon(Icons.auto_awesome, color: scheme.primary),
        ),
      ),

      // IndexedStack keeps pages alive in memory
      body: IndexedStack(
        index: nav.currentIndex,
        children: _pages,
      ),

      // ── Bottom Navigation ────────────────────────────────────────────
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: nav.currentIndex,
        onTap: nav.setIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            activeIcon: Icon(Icons.map),
            label: AppStrings.navMap,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center_outlined),
            activeIcon: Icon(Icons.fitness_center),
            label: AppStrings.navQuest,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: AppStrings.navCharacter,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_outlined),
            activeIcon: Icon(Icons.menu_book),
            label: AppStrings.navJournal,
          ),
        ],
      ),
    );
  }

  /// Returns a context-appropriate AppBar title for the current tab.
  String _appBarTitle(int index) {
    switch (index) {
      case 0:  return AppStrings.appName;
      case 1:  return AppStrings.navQuest;
      case 2:  return AppStrings.characterTitle;
      case 3:  return AppStrings.journalTitle;
      default: return AppStrings.appName;
    }
  }
}
