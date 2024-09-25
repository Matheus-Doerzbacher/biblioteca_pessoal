import 'dart:io';

import 'package:biblioteca_pessoal/layers/data/datasources/livro_datasources/livro_datasource.dart';
import 'package:biblioteca_pessoal/layers/domain/entities/livro_entity.dart';
import 'package:biblioteca_pessoal/layers/domain/repositories/livro_repository.dart';

class CreateLivroRepositoryImp implements CreateLivroRepository {
  final CreateLivroDatasource _createLivroDatasource;

  CreateLivroRepositoryImp(this._createLivroDatasource);

  @override
  Future<bool> call(Livro livro) async {
    return await _createLivroDatasource(livro);
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////

class DeleteLivroRepositoryImp implements DeleteLivroRepository {
  final DeleteLivroDatasource _deleteLivroDatasource;

  DeleteLivroRepositoryImp(this._deleteLivroDatasource);

  @override
  Future<bool> call(String id) async {
    return await _deleteLivroDatasource(id);
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////

class GetLivroByIdRepositoryImp implements GetLivroByIdRepository {
  final GetLivroByIdDatasource _getLivroByIdDatasource;

  GetLivroByIdRepositoryImp(this._getLivroByIdDatasource);

  @override
  Future<Livro> call(String idLivro) async {
    return await _getLivroByIdDatasource(idLivro);
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////

class GetLivrosRepositoryImp implements GetLivrosRepository {
  final GetLivrosDatasource _getLivrosDatasource;

  GetLivrosRepositoryImp(this._getLivrosDatasource);

  @override
  Future<List<Livro>> call(String uidUsuario) async {
    return await _getLivrosDatasource(uidUsuario);
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////

class UpdateLivroRepositoryImp implements UpdateLivroRepository {
  final UpdateLivroDatasource _updateLivroDatasource;

  UpdateLivroRepositoryImp(this._updateLivroDatasource);

  @override
  Future<bool> call(Livro livro) async {
    return await _updateLivroDatasource(livro);
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////

class SalvarImagemLivroRepositoryImp implements SalvarImagemLivroRepository {
  final SalvarImagemLivroDatasource _salvarImagemLivroDatasource;

  SalvarImagemLivroRepositoryImp(this._salvarImagemLivroDatasource);
  @override
  Future<String> call(File imagem) async {
    return await _salvarImagemLivroDatasource(imagem);
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////

class PesquisarLivroApiRepositoryImp implements PesquisarLivroApiRepository {
  final PesquisarLivroApiDatasource _pesquisarLivroApiDatasource;

  PesquisarLivroApiRepositoryImp(this._pesquisarLivroApiDatasource);

  @override
  Future<List<Livro>> call(String titulo) async {
    return await _pesquisarLivroApiDatasource(titulo);
  }
}
