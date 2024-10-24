import 'package:biblioteca_pessoal/core/inject/_inject.dart';
import 'package:biblioteca_pessoal/core/routes/app_routes.dart';
import 'package:biblioteca_pessoal/layers/domain/entities/livro_entity.dart';
import 'package:biblioteca_pessoal/layers/presentation/controllers/categoria_controller.dart';
import 'package:biblioteca_pessoal/layers/presentation/controllers/home_page_controller.dart';
import 'package:biblioteca_pessoal/layers/presentation/controllers/pesquisa_api_controller.dart';
import 'package:biblioteca_pessoal/layers/presentation/controllers/user_controller.dart';
import 'package:biblioteca_pessoal/layers/presentation/theme/theme.dart';
import 'package:biblioteca_pessoal/layers/presentation/ui/pages/adicionar_livro/adicionar_livro_page.dart';
import 'package:biblioteca_pessoal/layers/presentation/ui/pages/adicionar_livro/pesquisa_api_page.dart';
import 'package:biblioteca_pessoal/layers/presentation/ui/pages/categoria/categoria_page.dart';
import 'package:biblioteca_pessoal/layers/presentation/ui/pages/emprestimos/emprestimo_page.dart';
import 'package:biblioteca_pessoal/layers/presentation/ui/pages/emprestimos/novo_emprestimo_page.dart';
import 'package:biblioteca_pessoal/layers/presentation/ui/pages/home_page.dart';
import 'package:biblioteca_pessoal/layers/presentation/ui/pages/livro_detail_page.dart';
import 'package:biblioteca_pessoal/layers/presentation/ui/pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Inicialize todos os módulos de injeção de dependências
  Inject.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GetIt.I<CategoriaController>(),
        ),
        ChangeNotifierProvider(
          create: (context) => GetIt.I<PesquisaApiController>(),
        ),
        ChangeNotifierProvider(
          create: (context) => GetIt.I<HomePageController>(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biblioteca Pessoal',
      debugShowCheckedModeBanner: false,
      theme: ThemeDataCustom().light(),
      darkTheme: ThemeDataCustom().dark(),
      initialRoute:
          UserController.user != null ? AppRoutes.home : AppRoutes.login,
      routes: {
        AppRoutes.login: (context) => const LoginPage(),
        AppRoutes.home: (context) => const HomePage(),
        AppRoutes.categoria: (context) => const CategoriaPage(),
        AppRoutes.livro.adicionar: (context) => const PesquisaApiPage(),
        AppRoutes.livro.adicionarManual: (context) => AdicionarLivroPage(
              livroUpdate: ModalRoute.of(context)!.settings.arguments as Livro?,
            ),
        AppRoutes.livro.livroDetail: (context) => LivroDetailPage(
              livro: ModalRoute.of(context)!.settings.arguments! as Livro,
            ),
        AppRoutes.emprestimo.base: (context) => const EmprestimosPage(),
        AppRoutes.emprestimo.novo: (context) => const NovoEmprestimoPage(),
      },
    );
  }
}
