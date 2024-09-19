import 'package:biblioteca_pessoal/layers/data/datasources/categoria_datasources/categoria_datasource.dart';
import 'package:biblioteca_pessoal/layers/domain/entities/categoria_entity.dart';
import 'package:biblioteca_pessoal/layers/domain/repositories/categoria_repository.dart';

class CreateCategoriaRepositoryImp implements CreateCategoriaRepository {
  final CreateCategoriaDatasource _createCategoriaDatasource;

  CreateCategoriaRepositoryImp(this._createCategoriaDatasource);
  @override
  Future<bool> call(Categoria categoria) async {
    return await _createCategoriaDatasource(categoria);
  }
}

class DeleteCategoriaRepositoryImp implements DeleteCategoriaRepository {
  final DeleteCategoriaDatasource _deleteCategoriaDatasource;

  DeleteCategoriaRepositoryImp(this._deleteCategoriaDatasource);
  @override
  Future<bool> call(String idCategoria) async {
    return await _deleteCategoriaDatasource(idCategoria);
  }
}

class GetCategoriasRepositoryImp implements GetCategoriasRepository {
  final GetCategoriasDatasource _getCategoriasDatasource;

  GetCategoriasRepositoryImp(this._getCategoriasDatasource);
  @override
  Future<List<Categoria>> call() async {
    return _getCategoriasDatasource();
  }
}

class UpdateCategoriaRepositoryImp implements UpdateCategoriaRepository {
  final UpdateCategoriaDatasource _updateCategoriaDatasource;

  UpdateCategoriaRepositoryImp(this._updateCategoriaDatasource);
  @override
  Future<bool> call(Categoria categoria) async {
    return await _updateCategoriaDatasource(categoria);
  }
}
