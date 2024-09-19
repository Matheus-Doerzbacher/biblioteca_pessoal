import 'package:get_it/get_it.dart';
import 'package:biblioteca_pessoal/layers/data/datasources/categoria_datasources/categoria_datasource.dart';
import 'package:biblioteca_pessoal/layers/data/datasources/categoria_datasources/firebase/create_categoria_firebase_datasource_imp.dart';
import 'package:biblioteca_pessoal/layers/data/datasources/categoria_datasources/firebase/delete_categoria_firebase_datasource_imp.dart';
import 'package:biblioteca_pessoal/layers/data/datasources/categoria_datasources/firebase/get_categorias_firebase_datasource_imp.dart';
import 'package:biblioteca_pessoal/layers/data/datasources/categoria_datasources/firebase/update_categoria_firebase_datasource_imp.dart';
import 'package:biblioteca_pessoal/layers/data/repositories_imp/categoria_repository_imp.dart';
import 'package:biblioteca_pessoal/layers/domain/repositories/categoria_repository.dart';
import 'package:biblioteca_pessoal/layers/domain/usecases/categoria_usecase/categoria_usecase.dart';
import 'package:biblioteca_pessoal/layers/domain/usecases/categoria_usecase/categoria_usecase_imp.dart';
import 'package:biblioteca_pessoal/layers/presentation/controllers/categoria_controller.dart';

void categoriaInject(GetIt getIt) {
  //datasources
  getIt.registerLazySingleton<CreateCategoriaDatasource>(
    () => CreateCategoriaFirebaseDatasourceImp(),
  );
  getIt.registerLazySingleton<DeleteCategoriaDatasource>(
    () => DeleteCategoriaFirebaseDatasourceImp(),
  );
  getIt.registerLazySingleton<GetCategoriasDatasource>(
    () => GetCategoriasFirebaseDatasourceImp(),
  );
  getIt.registerLazySingleton<UpdateCategoriaDatasource>(
    () => UpdateCategoriaFirebaseDatasourceImp(),
  );

  //repositories
  getIt.registerLazySingleton<CreateCategoriaRepository>(
    () => CreateCategoriaRepositoryImp(getIt()),
  );
  getIt.registerLazySingleton<DeleteCategoriaRepository>(
    () => DeleteCategoriaRepositoryImp(getIt()),
  );
  getIt.registerLazySingleton<GetCategoriasRepository>(
    () => GetCategoriasRepositoryImp(getIt()),
  );
  getIt.registerLazySingleton<UpdateCategoriaRepository>(
    () => UpdateCategoriaRepositoryImp(getIt()),
  );

  //usecases
  getIt.registerLazySingleton<CreateCategoriaUsecase>(
    () => CreateCategoriaUsecaseImp(getIt()),
  );
  getIt.registerLazySingleton<DeleteCategoriaUsecase>(
    () => DeleteCategoriaUsecaseImp(getIt()),
  );
  getIt.registerLazySingleton<GetCategoriasUsecase>(
    () => GetCategoriasUsecaseImp(getIt()),
  );
  getIt.registerLazySingleton<UpdateCategoriaUsecase>(
    () => UpdateCategoriaUsecaseImp(getIt()),
  );

  //controllers
  getIt.registerLazySingleton<CategoriaController>(
    () => CategoriaController(getIt(), getIt(), getIt(), getIt()),
  );
}

// Exitem 2 principais tipos de register
// - getIt.registerLazySingleton()
// - getIt.registerFactory()
// https://www.youtube.com/watch?v=hPm4oEBlwIM&list=PLRpTFz5_57cvCYRhHUui2Bis-5Ybh78TS&index=8
// min: 20:50