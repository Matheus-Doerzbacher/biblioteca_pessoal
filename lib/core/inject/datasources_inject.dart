import 'package:biblioteca_pessoal/layers/data/datasources/categoria_datasources/categoria_datasource.dart';
import 'package:biblioteca_pessoal/layers/data/datasources/categoria_datasources/firebase/create_categoria_firebase_datasource_imp.dart';
import 'package:biblioteca_pessoal/layers/data/datasources/categoria_datasources/firebase/delete_categoria_firebase_datasource_imp.dart';
import 'package:biblioteca_pessoal/layers/data/datasources/categoria_datasources/firebase/get_categorias_firebase_datasource_imp.dart';
import 'package:biblioteca_pessoal/layers/data/datasources/categoria_datasources/firebase/update_categoria_firebase_datasource_imp.dart';
import 'package:biblioteca_pessoal/layers/data/datasources/emprestimo_datasources/emprestimo_datasource.dart';
import 'package:biblioteca_pessoal/layers/data/datasources/emprestimo_datasources/firebase/create_emprestimo_firebase_datasource_imp.dart';
import 'package:biblioteca_pessoal/layers/data/datasources/emprestimo_datasources/firebase/delete_emprestimo_firebase_imp.dart';
import 'package:biblioteca_pessoal/layers/data/datasources/emprestimo_datasources/firebase/get_emprestimos_by_id_firebase_datasource_imp.dart';
import 'package:biblioteca_pessoal/layers/data/datasources/emprestimo_datasources/firebase/get_emprestimos_firebase_datasource_imp.dart';
import 'package:biblioteca_pessoal/layers/data/datasources/emprestimo_datasources/firebase/update_emprestimo_firebase_imp.dart';
import 'package:biblioteca_pessoal/layers/data/datasources/livro_datasources/firebase/create_livro_firebase_datasource_imp.dart';
import 'package:biblioteca_pessoal/layers/data/datasources/livro_datasources/firebase/delete_livro_firebase_datasource_imp.dart';
import 'package:biblioteca_pessoal/layers/data/datasources/livro_datasources/firebase/get_livro_by_id_firebase_datasource_imp.dart';
import 'package:biblioteca_pessoal/layers/data/datasources/livro_datasources/firebase/get_livro_by_name_firebase_datasource_imp.dart';
import 'package:biblioteca_pessoal/layers/data/datasources/livro_datasources/firebase/get_livros_com_estoque_firebase_datasource_imp.dart';
import 'package:biblioteca_pessoal/layers/data/datasources/livro_datasources/firebase/get_livros_firebase_datasource_imp.dart';
import 'package:biblioteca_pessoal/layers/data/datasources/livro_datasources/firebase/pesquisar_livro_api_datasource_imp.dart';
import 'package:biblioteca_pessoal/layers/data/datasources/livro_datasources/firebase/salvar_imagem_livro_firabase_datasource_imp.dart';
import 'package:biblioteca_pessoal/layers/data/datasources/livro_datasources/firebase/update_livro_firebase_datasource_imp.dart';
import 'package:biblioteca_pessoal/layers/data/datasources/livro_datasources/livro_datasource.dart';
import 'package:get_it/get_it.dart';

void datasourcesInject(GetIt getIt) {
  getIt
    // CATEGORIA
    ..registerLazySingleton<CreateCategoriaDatasource>(
      CreateCategoriaFirebaseDatasourceImp.new,
    )
    ..registerLazySingleton<DeleteCategoriaDatasource>(
      DeleteCategoriaFirebaseDatasourceImp.new,
    )
    ..registerLazySingleton<GetCategoriasDatasource>(
      GetCategoriasFirebaseDatasourceImp.new,
    )
    ..registerLazySingleton<UpdateCategoriaDatasource>(
      UpdateCategoriaFirebaseDatasourceImp.new,
    )

    // EMPRESTIMOS
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

    // LIVROS
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
    ..registerLazySingleton<GetLivroByNameDatasource>(
      GetLivroByNameFirebaseDatasourceImp.new,
    )
    ..registerLazySingleton<PesquisarLivroApiDatasource>(
      PesquisarLivroApiDatasourceImp.new,
    )
    ..registerLazySingleton<GetLivrosComEstoqueDatasource>(
      GetLivrosComEstoqueFirebaseDatasourceImp.new,
    );
}
