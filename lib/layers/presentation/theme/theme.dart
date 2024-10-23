import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeDataCustom {
  ThemeData light() {
    final baseTheme = ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color.fromARGB(255, 146, 129, 99),
      ).copyWith(
        primary: const Color.fromARGB(255, 146, 129, 99),
        // Ajuste outras cores conforme necessário
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
      ),
      useMaterial3: true,
    );

    return baseTheme.copyWith(
      textTheme: GoogleFonts.poppinsTextTheme(baseTheme.textTheme),
    );
  }

  ThemeData dark() {
    final baseTheme = ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color.fromARGB(255, 146, 129, 99),
        brightness: Brightness.dark,
      ).copyWith(
        primary: const Color.fromARGB(255, 146, 129, 99),
        surface: const Color.fromARGB(255, 11, 9, 6),
        shadow: const Color.fromARGB(255, 90, 83, 69),
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
      ),
      useMaterial3: true,
    );

    return baseTheme.copyWith(
      textTheme: GoogleFonts.poppinsTextTheme(baseTheme.textTheme),
    );
  }
}

// APENAS PARA CONSULTA
final ColorScheme lightColorSchema = ColorScheme.fromSeed(
  dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
  seedColor: const Color.fromARGB(255, 146, 129, 99),
  secondary: const Color(0xFF4b986c),
  tertiary: const Color(0xFF6D604A),
  error: const Color(0xFFC4454D),
  surface: const Color(0xFFf1f4f8),
  surfaceContainer: const Color(0xFFFFFFFF),
  onSurface: const Color(0xFF0B191E),
  onSurfaceVariant: const Color(0xFF384E58),
  shadow: const Color(0x41000000),
);

final ColorScheme darkColorSchema = ColorScheme.fromSeed(
  dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 146, 129, 99),
  secondary: const Color(0xFF4b986c),
  tertiary: const Color(0xFF6D604A),
  error: const Color(0xFFC4454D),
  surface: const Color(0xFF0b191e),
  surfaceContainer: const Color(0xFF0d1e23),
  onSurface: const Color(0xFFFFFFFF),
  onSurfaceVariant: const Color(0xFF658593),
  shadow: const Color(0x3fffffff),
);
