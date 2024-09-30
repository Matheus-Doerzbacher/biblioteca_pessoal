import 'package:biblioteca_pessoal/layers/data/datasources/livro_datasources/firebase/create_livro_firebase_datasource_imp.dart';
import 'package:biblioteca_pessoal/layers/data/datasources/livro_datasources/firebase/delete_livro_firebase_datasource_imp.dart';
import 'package:biblioteca_pessoal/layers/data/datasources/livro_datasources/firebase/get_livro_by_id_firebase_datasource_imp.dart';
import 'package:biblioteca_pessoal/layers/data/datasources/livro_datasources/firebase/get_livros_firebase_datasource_imp.dart';
import 'package:biblioteca_pessoal/layers/data/datasources/livro_datasources/firebase/salvar_imagem_livro_firabase_datasource_imp.dart';
import 'package:biblioteca_pessoal/layers/data/datasources/livro_datasources/firebase/update_livro_firebase_datasource_imp.dart';
import 'package:biblioteca_pessoal/layers/data/datasources/livro_datasources/livro_datasource.dart';
import 'package:biblioteca_pessoal/layers/data/repositories_imp/livro_repository_imp.dart';
import 'package:biblioteca_pessoal/layers/domain/repositories/livro_repository.dart';
import 'package:biblioteca_pessoal/layers/domain/usecases/livro_usecase/livro_usecase.dart';
import 'package:biblioteca_pessoal/layers/domain/usecases/livro_usecase/livro_usecase_imp.dart';
import 'package:biblioteca_pessoal/layers/presentation/controllers/livro_controller.dart';
import 'package:get_it/get_it.dart';

void livroInject(GetIt getIt) {
  //datasources
  getIt
    ..registerLazySingleton<GetLivrosDatasource>(
      GetLivrosFirebaseDatasourceImp.new,
    )
    ..registerLazySingleton<GetLivroByIdDatasource>(
      GetLivroByIdFirebaseDatasourceImp.new,
    )
    ..registerLazySingleton<CreateLivroDatasource>(
      CreateLivroFirebaseDatasourceImp.new,
    )
    ..registerLazySingleton<UpdateLivroDatasource>(
      UpdateLivroFirebaseDatasourceImp.new,
    )
    ..registerLazySingleton<DeleteLivroDatasource>(
      DeleteLivroFirebaseDatasourceImp.new,
    )
    ..registerLazySingleton<SalvarImagemLivroDatasource>(
      SalvarImagemLivroFirabaseDatasourceImp.new,
    )

    //repositories
    ..registerLazySingleton<GetLivrosRepository>(
      () => GetLivrosRepositoryImp(getIt()),
    )
    ..registerLazySingleton<GetLivroByIdRepository>(
      () => GetLivroByIdRepositoryImp(getIt()),
    )
    ..registerLazySingleton<CreateLivroRepository>(
      () => CreateLivroRepositoryImp(getIt()),
    )
    ..registerLazySingleton<UpdateLivroRepository>(
      () => UpdateLivroRepositoryImp(getIt()),
    )
    ..registerLazySingleton<DeleteLivroRepository>(
      () => DeleteLivroRepositoryImp(getIt()),
    )
    ..registerLazySingleton<SalvarImagemLivroRepository>(
      () => SalvarImagemLivroRepositoryImp(getIt()),
    )

    //usecases
    ..registerLazySingleton<GetLivrosUsecase>(
      () => GetLivrosUsecaseImp(getIt()),
    )
    ..registerLazySingleton<GetLivroByIdUsecase>(
      () => GetLivroByIdUsecaseImp(getIt()),
    )
    ..registerLazySingleton<CreateLivroUsecase>(
      () => CreateLivroUsecaseImp(getIt()),
    )
    ..registerLazySingleton<UpdateLivroUsecase>(
      () => UpdateLivroUsecaseImp(getIt()),
    )
    ..registerLazySingleton<DeleteLivroUsecase>(
      () => DeleteLivroUsecaseImp(getIt()),
    )
    ..registerLazySingleton<SalvarImagemLivroUsecase>(
      () => SalvarImagemLivroUsecaseImp(getIt()),
    )

    //controllers
    ..registerLazySingleton<LivroController>(
      () => LivroController(
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
      ),
    );
}

// Exitem 2 principais tipos de register
// - getIt.registerLazySingleton()
// - getIt.registerFactory()
// https://www.youtube.com/watch?v=hPm4oEBlwIM&list=PLRpTFz5_57cvCYRhHUui2Bis-5Ybh78TS&index=8
// min: 20:50
