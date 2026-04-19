/// ===================================================================
/// FitQuest — Application Entry Point
/// ===================================================================
/// Sets up the [MultiProvider] at the widget-tree root so that all
/// feature screens can access shared state via `context.watch` /
/// `context.read`.
///
/// Provider tree:
///   ├── NavigationProvider  — bottom-nav tab index
///   ├── PlayerProvider      — hero stats (level, EXP, calories…)
///   ├── QuestProvider       — workout FSM (Idle / Active / Resting)
///   └── JournalProvider     — workout history list
/// ===================================================================

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/app_shell.dart';
import 'core/providers/navigation_provider.dart';
import 'core/theme/app_theme.dart';
import 'features/character/providers/player_provider.dart';
import 'features/journal/providers/journal_provider.dart';
import 'features/quest/providers/quest_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const FitQuestApp());
}

class FitQuestApp extends StatelessWidget {
  const FitQuestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => PlayerProvider()),
        ChangeNotifierProvider(create: (_) => QuestProvider()),
        ChangeNotifierProvider(create: (_) => JournalProvider()),
      ],
      child: MaterialApp(
        title: 'FitQuest',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        home: const AppShell(),
      ),
    );
  }
}
