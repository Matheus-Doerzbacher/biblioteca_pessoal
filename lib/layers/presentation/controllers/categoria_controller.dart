import 'package:biblioteca_pessoal/layers/domain/entities/categoria_entity.dart';
import 'package:biblioteca_pessoal/layers/domain/usecases/categoria_usecase/categoria_usecase.dart';
import 'package:biblioteca_pessoal/layers/presentation/controllers/user_controller.dart';

class CategoriaController {
  final CreateCategoriaUsecase _createCategoriaUsecase;
  final DeleteCategoriaUsecase _deleteCategoriaUsecase;
  final GetCategoriasUsecase _getCategoriasUsecase;
  final UpdateCategoriaUsecase _updateCategoriaUsecase;

  CategoriaController(
    this._createCategoriaUsecase,
    this._deleteCategoriaUsecase,
    this._getCategoriasUsecase,
    this._updateCategoriaUsecase,
  ) {
    getCategorias(UserController.user?.uid ?? '');
  }

  late List<Categoria> categorias;

  createCategoria(Categoria categoria) async {
    return await _createCategoriaUsecase(categoria);
  }

  deleteCategoria(String idCategoria) async {
    return await _deleteCategoriaUsecase(idCategoria);
  }

  getCategorias(String uidUsuario) async {
    categorias = await _getCategoriasUsecase(uidUsuario);
  }

  updateCategoria(Categoria categoria) async {
    return await _updateCategoriaUsecase(categoria);
  }
}
