import 'package:flutter/material.dart';

final ColorScheme lightColorSchema = ColorScheme.fromSeed(
  dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
  brightness: Brightness.light,
  seedColor: const Color(0xFF928163),
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
  brightness: Brightness.light,
  seedColor: const Color(0xFF928163),
  secondary: const Color(0xFF4b986c),
  tertiary: const Color(0xFF6D604A),
  error: const Color(0xFFC4454D),
  surface: const Color(0xFF0b191e),
  surfaceContainer: const Color(0xFF0d1e23),
  onSurface: const Color(0xFFFFFFFF),
  onSurfaceVariant: const Color(0xFF658593),
  shadow: const Color(0x3fffffff),
);

// Cores adicionais
// const Color accent1 = Color(0xFF4D4B6C);
// const Color accent2 = Color(0xFF4D9281);
// const Color accent3 = Color(0xFF6D604A);
// const Color accent4 = Color(0xcdffffff);
// const Color success = Color(0xFF336A4A);
// const Color warning = Color(0xFFF3C344);
