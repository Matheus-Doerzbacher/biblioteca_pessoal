import 'package:get_it/get_it.dart';
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

void emprestimoInject(GetIt getIt) {
  // DATASOURCE
  getIt.registerLazySingleton<CreateEmprestimoDatasource>(
    () => CreateEmprestimoFirebaseDatasourceImp(),
  );
  getIt.registerLazySingleton<GetEmprestimoByIdDatasource>(
    () => GetEmprestimosByIdFirebaseDatasourceImp(),
  );
  getIt.registerLazySingleton<GetEmprestimosDatasource>(
    () => GetEmprestimosFirebaseDatasourceImp(),
  );
  getIt.registerLazySingleton<UpdateEmprestimoDatasource>(
    () => UpdateEmprestimoFirebaseDatasourceImp(),
  );
  getIt.registerLazySingleton<DeleteEmprestimoDatasource>(
    () => DeleteEmprestimoFirebaseDatasourceImp(),
  );

  // REPOSITORIES
  getIt.registerLazySingleton<CreateEmprestimoRepository>(
    () => CreateEmprestimoRepositoryImp(getIt()),
  );
  getIt.registerLazySingleton<GetEmprestimoByIdRepository>(
    () => GetEmprestimoByIdRepositoryImp(getIt()),
  );
  getIt.registerLazySingleton<GetEmprestimosRepository>(
    () => GetEmprestimosRepositoryImp(getIt()),
  );
  getIt.registerLazySingleton<UpdateEmprestimoRepository>(
    () => UpdateEmprestimoRepositoryImp(getIt()),
  );
  getIt.registerLazySingleton<DeleteEmprestimoRepository>(
    () => DeleteEmprestimoRepositoryImp(getIt()),
  );

  //USECASES
  getIt.registerLazySingleton<CreateEmprestimoUsecase>(
    () => CreateEmprestimoUsecaseImp(getIt()),
  );
  getIt.registerLazySingleton<GetEmprestimoByIdUsecase>(
    () => GetEmprestimoByIdUsecaseImp(getIt()),
  );
  getIt.registerLazySingleton<GetEmprestimosUsecase>(
    () => GetEmprestimosUsecaseImp(getIt()),
  );
  getIt.registerLazySingleton<UpdateEmprestimoUsecase>(
    () => UpdateEmprestimoUsecaseImp(getIt()),
  );
  getIt.registerLazySingleton<DeleteEmprestimoUsecase>(
    () => DeleteEmprestimoUsecaseImp(getIt()),
  );

  //CONTROLLER
  getIt.registerLazySingleton<EmprestimoController>(
    () => EmprestimoController(getIt(), getIt(), getIt(), getIt(), getIt()),
  );
}
