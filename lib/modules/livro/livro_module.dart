import 'package:biblioteca_pessoal/modules/categoria/categoria_module.dart';
import 'package:biblioteca_pessoal/modules/livro/controllers/livro_controller.dart';
import 'package:biblioteca_pessoal/modules/livro/controllers/pesquisa_api_controller.dart';
import 'package:biblioteca_pessoal/modules/livro/repositories/create_livro_repository.dart';
import 'package:biblioteca_pessoal/modules/livro/repositories/delete_livro_repository.dart';
import 'package:biblioteca_pessoal/modules/livro/repositories/get_livro_by_id_repository.dart';
import 'package:biblioteca_pessoal/modules/livro/repositories/get_livro_by_name_repository.dart';
import 'package:biblioteca_pessoal/modules/livro/repositories/get_livros_com_estoque_repository.dart';
import 'package:biblioteca_pessoal/modules/livro/repositories/get_livros_repository.dart';
import 'package:biblioteca_pessoal/modules/livro/repositories/pesquisar_livro_api_repository.dart';
import 'package:biblioteca_pessoal/modules/livro/repositories/salvar_imagem_livro_repository.dart';
import 'package:biblioteca_pessoal/modules/livro/repositories/update_livro_repository.dart';
import 'package:biblioteca_pessoal/modules/livro/views/adicionar_livro_page.dart';
import 'package:biblioteca_pessoal/modules/livro/views/livro_detail_page.dart';
import 'package:biblioteca_pessoal/modules/livro/views/livros_page.dart';
import 'package:biblioteca_pessoal/modules/livro/views/pesquisa_api_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';

class LivroModule extends Module {
  @override
  List<Module> get imports => [
        CategoriaModule(),
      ];

  @override
  void exportedBinds(Injector i) {
    i
      ..add<GetLivrosComEstoqueRepository>(GetLivrosComEstoqueRepository.new)
      ..add<GetLivroByIdRepository>(GetLivroByIdRepository.new);
    super.exportedBinds(i);
  }

  @override
  void binds(Injector i) {
    i
      ..add<GetLivrosRepository>(GetLivrosRepository.new)
      ..add<CreateLivroRepository>(CreateLivroRepository.new)
      ..add<DeleteLivroRepository>(DeleteLivroRepository.new)
      ..add<GetLivroByNameRepository>(GetLivroByNameRepository.new)
      ..add<PesquisarLivroApiRepository>(PesquisarLivroApiRepository.new)
      ..add<SalvarImagemLivroRepository>(SalvarImagemLivroRepository.new)
      ..add<UpdateLivroRepository>(UpdateLivroRepository.new)

      // CONTROLLERS
      ..addLazySingleton<LivroController>(
        () => LivroController(i(), i(), i(), i(), i(), i()),
      )
      ..addLazySingleton<PesquisaApiController>(
        () => PesquisaApiController(i()),
      );

    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r
      ..child(
        Modular.initialRoute,
        child: (_) => ChangeNotifierProvider<LivroController>(
          create: (_) => Modular.get<LivroController>(),
          child: const LivrosPage(),
        ),
      )
      ..child(
        '/adicionar',
        child: (context) => AdicionarLivroPage(livroUpdate: r.args.data),
      )
      ..child(
        '/detail',
        child: (context) => LivroDetailPage(livro: r.args.data),
      )
      ..child(
        '/pesquisa',
        child: (context) => const PesquisaApiPage(),
      );
    super.routes(r);
  }
}
