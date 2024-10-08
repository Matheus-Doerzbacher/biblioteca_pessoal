import 'package:flutter/material.dart';

final ColorScheme lightColorSchema = ColorScheme.fromSeed(
  dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
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
  brightness: Brightness.dark,
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
