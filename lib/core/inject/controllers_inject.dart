import 'package:biblioteca_pessoal/layers/presentation/controllers/adicionar_livro_controller.dart';
import 'package:biblioteca_pessoal/layers/presentation/controllers/categoria_controller.dart';
import 'package:biblioteca_pessoal/layers/presentation/controllers/emprestimo_controller.dart';
import 'package:biblioteca_pessoal/layers/presentation/controllers/home_page_controller.dart';
import 'package:biblioteca_pessoal/layers/presentation/controllers/livro_datail_controller.dart';
import 'package:biblioteca_pessoal/layers/presentation/controllers/pesquisa_api_controller.dart';
import 'package:get_it/get_it.dart';

void controllersInject(GetIt getIt) {
  getIt
    ..registerLazySingleton<AdicionarLivroController>(
      () => AdicionarLivroController(
        getIt(),
        getIt(),
        getIt(),
        getIt(),
      ),
    )
    ..registerLazySingleton<PesquisaApiController>(
      () => PesquisaApiController(
        getIt(),
      ),
    )
    ..registerLazySingleton<HomePageController>(
      () => HomePageController(
        getIt(),
        getIt(),
      ),
    )
    ..registerLazySingleton<LivroDatailController>(
      () => LivroDatailController(
        getIt(),
      ),
    )
    ..registerLazySingleton<CategoriaController>(
      () => CategoriaController(
        getIt(),
        getIt(),
        getIt(),
        getIt(),
      ),
    )
    ..registerLazySingleton<EmprestimoController>(
      () => EmprestimoController(
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
      ),
    );
}
