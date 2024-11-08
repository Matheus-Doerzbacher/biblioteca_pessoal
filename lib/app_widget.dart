import 'package:biblioteca_pessoal/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Biblioteca Pessoal',
      debugShowCheckedModeBanner: false,
      theme: ThemeDataCustom().light(),
      darkTheme: ThemeDataCustom().dark(),
      routerConfig: Modular.routerConfig,
    );
  }
}
