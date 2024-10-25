import 'package:flutter/material.dart';

class LogoApp extends StatelessWidget {
  final double size;
  const LogoApp({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return RichText(
      textScaler: MediaQuery.of(context).textScaler,
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Minha',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          TextSpan(
            text: 'Biblioteca',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: colorScheme.primary,
                ),
          ),
        ],
        style: TextStyle(fontSize: size),
      ),
    );
  }
}
