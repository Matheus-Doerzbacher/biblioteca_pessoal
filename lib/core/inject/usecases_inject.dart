import 'package:biblioteca_pessoal/layers/domain/usecases/categoria_usecase/categoria_usecase.dart';
import 'package:biblioteca_pessoal/layers/domain/usecases/categoria_usecase/categoria_usecase_imp.dart';
import 'package:biblioteca_pessoal/layers/domain/usecases/emprestimo_usecase/emprestimo_usecase.dart';
import 'package:biblioteca_pessoal/layers/domain/usecases/emprestimo_usecase/emprestimo_usecase_imp.dart';
import 'package:biblioteca_pessoal/layers/domain/usecases/livro_usecase/livro_usecase.dart';
import 'package:biblioteca_pessoal/layers/domain/usecases/livro_usecase/livro_usecase_imp.dart';
import 'package:get_it/get_it.dart';

void usecasesInject(GetIt getIt) {
  getIt
    // CATEGORIA
    ..registerLazySingleton<CreateCategoriaUsecase>(
      () => CreateCategoriaUsecaseImp(getIt()),
    )
    ..registerLazySingleton<DeleteCategoriaUsecase>(
      () => DeleteCategoriaUsecaseImp(getIt()),
    )
    ..registerLazySingleton<GetCategoriasUsecase>(
      () => GetCategoriasUsecaseImp(getIt()),
    )
    ..registerLazySingleton<UpdateCategoriaUsecase>(
      () => UpdateCategoriaUsecaseImp(getIt()),
    )

    // EMPRESTIMOS
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

    // LIVROS
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
    ..registerLazySingleton<GetLivroByNameUsecase>(
      () => GetLivroByNameUsecaseImp(getIt()),
    )
    ..registerLazySingleton<PesquisarLivroApiUsecase>(
      () => PesquisarLivroApiUsecaseImp(getIt()),
    );
}
