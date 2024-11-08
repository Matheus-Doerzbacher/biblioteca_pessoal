import 'package:biblioteca_pessoal/layers/data/datasources/categoria_datasources/categoria_datasource.dart';
import 'package:biblioteca_pessoal/layers/domain/entities/categoria.dart';
import 'package:biblioteca_pessoal/layers/domain/repositories/categoria_repository.dart';

class CreateCategoriaRepositoryImp implements CreateCategoriaRepository {
  final CreateCategoriaDatasource _createCategoriaDatasource;

  CreateCategoriaRepositoryImp(this._createCategoriaDatasource);
  @override
  Future<bool> call(Categoria categoria) async {
    return _createCategoriaDatasource(categoria);
  }
}

class DeleteCategoriaRepositoryImp implements DeleteCategoriaRepository {
  final DeleteCategoriaDatasource _deleteCategoriaDatasource;

  DeleteCategoriaRepositoryImp(this._deleteCategoriaDatasource);
  @override
  Future<bool> call(String idCategoria) async {
    return _deleteCategoriaDatasource(idCategoria);
  }
}

class GetCategoriasRepositoryImp implements GetCategoriasRepository {
  final GetCategoriasDatasource _getCategoriasDatasource;

  GetCategoriasRepositoryImp(this._getCategoriasDatasource);
  @override
  Future<List<Categoria>> call(String uidUsuario) async {
    return _getCategoriasDatasource(uidUsuario);
  }
}

class UpdateCategoriaRepositoryImp implements UpdateCategoriaRepository {
  final UpdateCategoriaDatasource _updateCategoriaDatasource;

  UpdateCategoriaRepositoryImp(this._updateCategoriaDatasource);
  @override
  Future<bool> call(Categoria categoria) async {
    return _updateCategoriaDatasource(categoria);
  }
}
