import 'package:biblioteca_pessoal/modules/home/controllers/home_page_controller.dart';
import 'package:biblioteca_pessoal/modules/livro/controllers/adicionar_livro_controller.dart';
import 'package:biblioteca_pessoal/modules/livro/controllers/livro_datail_controller.dart';
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
import 'package:biblioteca_pessoal/modules/livro/views/pesquisa_api_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LivroModule extends Module {
  @override
  void binds(Injector i) {
    i
      ..add<CreateLivroRepository>(CreateLivroRepository.new)
      ..add<DeleteLivroRepository>(DeleteLivroRepository.new)
      ..add<GetLivroByIdRepository>(GetLivroByIdRepository.new)
      ..add<GetLivroByNameRepository>(GetLivroByNameRepository.new)
      ..add<GetLivrosComEstoqueRepository>(GetLivrosComEstoqueRepository.new)
      ..add<GetLivrosRepository>(GetLivrosRepository.new)
      ..add<PesquisarLivroApiRepository>(PesquisarLivroApiRepository.new)
      ..add<SalvarImagemLivroRepository>(SalvarImagemLivroRepository.new)
      ..add<UpdateLivroRepository>(UpdateLivroRepository.new)

      // CONTROLLERS
      ..addLazySingleton<AdicionarLivroController>(
        () => AdicionarLivroController(i(), i(), i(), i()),
      )
      ..addLazySingleton<HomePageController>(
        () => HomePageController(i(), i()),
      )
      ..addLazySingleton<LivroDatailController>(
        () => LivroDatailController(i()),
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
        '/adicionar',
        child: (context) => const AdicionarLivroPage(),
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
