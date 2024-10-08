import 'package:biblioteca_pessoal/layers/domain/entities/categoria_entity.dart';
import 'package:biblioteca_pessoal/layers/domain/repositories/categoria_repository.dart';
import 'package:biblioteca_pessoal/layers/domain/usecases/categoria_usecase/categoria_usecase.dart';

class CreateCategoriaUsecaseImp implements CreateCategoriaUsecase {
  final CreateCategoriaRepository _createCategoriaRepository;

  CreateCategoriaUsecaseImp(this._createCategoriaRepository);
  @override
  Future<bool> call(Categoria categoria) async {
    return _createCategoriaRepository(categoria);
  }
}

class DeleteCategoriaUsecaseImp implements DeleteCategoriaUsecase {
  final DeleteCategoriaRepository _deleteCategoriaRepository;

  DeleteCategoriaUsecaseImp(this._deleteCategoriaRepository);
  @override
  Future<bool> call(String idCategoria) async {
    return _deleteCategoriaRepository(idCategoria);
  }
}

class GetCategoriasUsecaseImp implements GetCategoriasUsecase {
  final GetCategoriasRepository _getCategoriasRepository;

  GetCategoriasUsecaseImp(this._getCategoriasRepository);

  @override
  Future<List<Categoria>> call(String uidUsuario) async {
    return _getCategoriasRepository(uidUsuario);
  }
}

class UpdateCategoriaUsecaseImp implements UpdateCategoriaUsecase {
  final UpdateCategoriaRepository _updateCategoriaRepository;

  UpdateCategoriaUsecaseImp(this._updateCategoriaRepository);
  @override
  Future<bool> call(Categoria categoria) async {
    return _updateCategoriaRepository(categoria);
  }
}
