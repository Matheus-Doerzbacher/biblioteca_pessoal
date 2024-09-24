import 'package:biblioteca_pessoal/core/inject/_inject.dart';
import 'package:biblioteca_pessoal/layers/presentation/controllers/user_controller.dart';
import 'package:biblioteca_pessoal/layers/presentation/theme/theme.dart';
import 'package:biblioteca_pessoal/layers/presentation/ui/pages/adicionar_livro_page.dart';
import 'package:biblioteca_pessoal/layers/presentation/ui/pages/categoria_page.dart';
import 'package:biblioteca_pessoal/layers/presentation/ui/pages/home_page.dart';
import 'package:biblioteca_pessoal/layers/presentation/ui/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Inicialize todos os módulos de injeção de dependências
  Inject.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biblioteca Pessoal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        colorScheme: lightColorSchema,
        useMaterial3: true,
        appBarTheme: const AppBarTheme().copyWith(
          centerTitle: true,
          backgroundColor: lightColorSchema.primary,
          foregroundColor: lightColorSchema.onPrimary,
        ),
      ),
      darkTheme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        colorScheme: darkColorSchema,
        useMaterial3: true,
        appBarTheme: const AppBarTheme().copyWith(
          centerTitle: true,
          backgroundColor: darkColorSchema.primary,
          foregroundColor: darkColorSchema.onPrimary,
        ),
      ),
      initialRoute: UserController.user != null ? '/' : '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/': (context) => const HomePage(),
        '/categoria': (context) => const CategoriaPage(),
        '/adicionar': (context) => const AdicionarLivroPage()
      },
      themeMode: ThemeMode.system,
    );
  }
}
