import 'package:biblioteca_pessoal/layers/data/datasources/livro_datasources/firebase/pesquisar_livro_api_datasource_imp.dart';
import 'package:biblioteca_pessoal/layers/data/datasources/livro_datasources/livro_datasource.dart';
import 'package:biblioteca_pessoal/layers/data/repositories_imp/livro_repository_imp.dart';
import 'package:biblioteca_pessoal/layers/domain/repositories/livro_repository.dart';
import 'package:biblioteca_pessoal/layers/domain/usecases/livro_usecase/livro_usecase.dart';
import 'package:biblioteca_pessoal/layers/domain/usecases/livro_usecase/livro_usecase_imp.dart';
import 'package:biblioteca_pessoal/layers/presentation/controllers/pesquisa_api_controller.dart';
import 'package:get_it/get_it.dart';

void pesquisaLivroInject(GetIt getIt) {
  //datasources
  getIt
    ..registerLazySingleton<PesquisarLivroApiDatasource>(
      PesquisarLivroApiDatasourceImp.new,
    )

    //repositories
    ..registerLazySingleton<PesquisarLivroApiRepository>(
      () => PesquisarLivroApiRepositoryImp(getIt()),
    )

    //usecases
    ..registerLazySingleton<PesquisarLivroApiUsecase>(
      () => PesquisarLivroApiUsecaseImp(getIt()),
    )

    //controllers
    ..registerLazySingleton<PesquisaApiController>(
      () => PesquisaApiController(
        getIt(),
      ),
    );
}

// Exitem 2 principais tipos de register
// - getIt.registerLazySingleton()
// - getIt.registerFactory()
// https://www.youtube.com/watch?v=hPm4oEBlwIM&list=PLRpTFz5_57cvCYRhHUui2Bis-5Ybh78TS&index=8
// min: 20:50
