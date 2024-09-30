import 'package:biblioteca_pessoal/layers/data/datasources/emprestimo_datasources/emprestimo_datasource.dart';
import 'package:biblioteca_pessoal/layers/data/datasources/emprestimo_datasources/firebase/create_emprestimo_firebase_datasource_imp.dart';
import 'package:biblioteca_pessoal/layers/data/datasources/emprestimo_datasources/firebase/delete_emprestimo_firebase_imp.dart';
import 'package:biblioteca_pessoal/layers/data/datasources/emprestimo_datasources/firebase/get_emprestimos_by_id_firebase_datasource_imp.dart';
import 'package:biblioteca_pessoal/layers/data/datasources/emprestimo_datasources/firebase/get_emprestimos_firebase_datasource_imp.dart';
import 'package:biblioteca_pessoal/layers/data/datasources/emprestimo_datasources/firebase/update_emprestimo_firebase_imp.dart';
import 'package:biblioteca_pessoal/layers/data/repositories_imp/emprestimo_repository_imp.dart';
import 'package:biblioteca_pessoal/layers/domain/repositories/emprestimo_respository.dart';
import 'package:biblioteca_pessoal/layers/domain/usecases/emprestimo_usecase/emprestimo_usecase.dart';
import 'package:biblioteca_pessoal/layers/domain/usecases/emprestimo_usecase/emprestimo_usecase_imp.dart';
import 'package:biblioteca_pessoal/layers/presentation/controllers/emprestimo_controller.dart';
import 'package:get_it/get_it.dart';

void emprestimoInject(GetIt getIt) {
  // DATASOURCE
  getIt
    ..registerLazySingleton<CreateEmprestimoDatasource>(
      CreateEmprestimoFirebaseDatasourceImp.new,
    )
    ..registerLazySingleton<GetEmprestimoByIdDatasource>(
      GetEmprestimosByIdFirebaseDatasourceImp.new,
    )
    ..registerLazySingleton<GetEmprestimosDatasource>(
      GetEmprestimosFirebaseDatasourceImp.new,
    )
    ..registerLazySingleton<UpdateEmprestimoDatasource>(
      UpdateEmprestimoFirebaseDatasourceImp.new,
    )
    ..registerLazySingleton<DeleteEmprestimoDatasource>(
      DeleteEmprestimoFirebaseDatasourceImp.new,
    )

    // REPOSITORIES
    ..registerLazySingleton<CreateEmprestimoRepository>(
      () => CreateEmprestimoRepositoryImp(getIt()),
    )
    ..registerLazySingleton<GetEmprestimoByIdRepository>(
      () => GetEmprestimoByIdRepositoryImp(getIt()),
    )
    ..registerLazySingleton<GetEmprestimosRepository>(
      () => GetEmprestimosRepositoryImp(getIt()),
    )
    ..registerLazySingleton<UpdateEmprestimoRepository>(
      () => UpdateEmprestimoRepositoryImp(getIt()),
    )
    ..registerLazySingleton<DeleteEmprestimoRepository>(
      () => DeleteEmprestimoRepositoryImp(getIt()),
    )

    //USECASES
    ..registerLazySingleton<CreateEmprestimoUsecase>(
      () => CreateEmprestimoUsecaseImp(getIt()),
    )
    ..registerLazySingleton<GetEmprestimoByIdUsecase>(
      () => GetEmprestimoByIdUsecaseImp(getIt()),
    )
    ..registerLazySingleton<GetEmprestimosUsecase>(
      () => GetEmprestimosUsecaseImp(getIt()),
    )
    ..registerLazySingleton<UpdateEmprestimoUsecase>(
      () => UpdateEmprestimoUsecaseImp(getIt()),
    )
    ..registerLazySingleton<DeleteEmprestimoUsecase>(
      () => DeleteEmprestimoUsecaseImp(getIt()),
    )

    //CONTROLLER
    ..registerLazySingleton<EmprestimoController>(
      () => EmprestimoController(getIt(), getIt(), getIt(), getIt(), getIt()),
    );
}
