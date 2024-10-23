import 'package:biblioteca_pessoal/layers/data/repositories_imp/categoria_repository_imp.dart';
import 'package:biblioteca_pessoal/layers/data/repositories_imp/emprestimo_repository_imp.dart';
import 'package:biblioteca_pessoal/layers/data/repositories_imp/livro_repository_imp.dart';
import 'package:biblioteca_pessoal/layers/domain/repositories/categoria_repository.dart';
import 'package:biblioteca_pessoal/layers/domain/repositories/emprestimo_respository.dart';
import 'package:biblioteca_pessoal/layers/domain/repositories/livro_repository.dart';
import 'package:get_it/get_it.dart';

void repositoriesInject(GetIt getIt) {
  getIt
    // CATEGORIA
    ..registerLazySingleton<CreateCategoriaRepository>(
      () => CreateCategoriaRepositoryImp(getIt()),
    )
    ..registerLazySingleton<DeleteCategoriaRepository>(
      () => DeleteCategoriaRepositoryImp(getIt()),
    )
    ..registerLazySingleton<GetCategoriasRepository>(
      () => GetCategoriasRepositoryImp(getIt()),
    )
    ..registerLazySingleton<UpdateCategoriaRepository>(
      () => UpdateCategoriaRepositoryImp(getIt()),
    )

    // EMPRESTIMOS
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

    // LIVROS
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
    ..registerLazySingleton<GetLivroByNameRepository>(
      () => GetLivroByNameRepositoryImp(getIt()),
    )
    ..registerLazySingleton<PesquisarLivroApiRepository>(
      () => PesquisarLivroApiRepositoryImp(getIt()),
    );
}
