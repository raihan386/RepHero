/// ===================================================================
/// FitQuest — App Theme
/// ===================================================================
/// Defines the global Material 3 theme with a JRPG-inspired dark
/// colour palette: deep indigo backgrounds, neon cyan accents, and
/// warm amber highlights for EXP/gold elements.
/// ===================================================================

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._(); // non-instantiable

  // ── Brand Colours ──────────────────────────────────────────────────
  static const Color _primary      = Color(0xFF00E5FF); // neon cyan
  static const Color _secondary    = Color(0xFFFFAB40); // warm amber
  static const Color _surface      = Color(0xFF1A1A2E); // dark indigo
  static const Color _background   = Color(0xFF0F0F23); // deep navy
  static const Color _card         = Color(0xFF16213E); // card panels
  static const Color _error        = Color(0xFFFF5252);
  static const Color _onPrimary    = Color(0xFF0F0F23);
  static const Color _onSurface    = Color(0xFFE0E0E0);
  static const Color _textMuted    = Color(0xFF8E8EA0);

  // ── Workout FSM Colours ────────────────────────────────────────────
  static const Color idle          = Color(0xFF2C2C54);
  static const Color activeWorkout = Color(0xFF1B5E20);
  static const Color resting       = Color(0xFF1A237E);

  // ── Dark Theme ─────────────────────────────────────────────────────
  static ThemeData get darkTheme {
    final baseText = GoogleFonts.pressStart2pTextTheme(
      ThemeData.dark().textTheme,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: _background,
      colorScheme: const ColorScheme.dark(
        primary: _primary,
        secondary: _secondary,
        surface: _surface,
        error: _error,
        onPrimary: _onPrimary,
        onSurface: _onSurface,
      ),

      // ── Card ───────────────────────────────────────────────────────
      cardTheme: CardThemeData(
        color: _card,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: _primary.withValues(alpha: 0.15)),
        ),
      ),

      // ── AppBar ─────────────────────────────────────────────────────
      appBarTheme: AppBarTheme(
        backgroundColor: _background,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.pressStart2p(
          fontSize: 14,
          color: _primary,
        ),
      ),

      // ── Bottom Nav ─────────────────────────────────────────────────
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: _surface,
        selectedItemColor: _primary,
        unselectedItemColor: _textMuted,
        type: BottomNavigationBarType.fixed,
        elevation: 12,
      ),

      // ── Elevated Button ────────────────────────────────────────────
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primary,
          foregroundColor: _onPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          textStyle: GoogleFonts.pressStart2p(fontSize: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      // ── Typography ─────────────────────────────────────────────────
      textTheme: baseText.copyWith(
        headlineLarge: GoogleFonts.pressStart2p(
          fontSize: 20,
          color: _primary,
        ),
        headlineMedium: GoogleFonts.pressStart2p(
          fontSize: 16,
          color: _onSurface,
        ),
        titleMedium: GoogleFonts.outfit(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: _onSurface,
        ),
        bodyLarge: GoogleFonts.outfit(
          fontSize: 16,
          color: _onSurface,
        ),
        bodyMedium: GoogleFonts.outfit(
          fontSize: 14,
          color: _onSurface,
        ),
        bodySmall: GoogleFonts.outfit(
          fontSize: 12,
          color: _textMuted,
        ),
        labelLarge: GoogleFonts.pressStart2p(
          fontSize: 10,
          color: _secondary,
        ),
      ),
    );
  }
}
