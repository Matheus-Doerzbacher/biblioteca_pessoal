import 'package:biblioteca_pessoal/layers/domain/entities/categoria_entity.dart';
import 'package:biblioteca_pessoal/layers/domain/usecases/categoria_usecase/categoria_usecase.dart';
import 'package:biblioteca_pessoal/layers/presentation/controllers/user_controller.dart';
import 'package:flutter/material.dart';

class CategoriaController extends ChangeNotifier {
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
    getCategorias(userId);
  }
  final userId = UserController.user?.uid ?? '';
  late List<Categoria> categorias = [];

  Future<dynamic> createCategoria(Categoria categoria) async {
    final result = await _createCategoriaUsecase(categoria);
    await getCategorias(userId);
    return result;
  }

  Future<dynamic> deleteCategoria(String idCategoria) async {
    final result = await _deleteCategoriaUsecase(idCategoria);
    await getCategorias(userId);
    return result;
  }

  Future<dynamic> getCategorias(String uidUsuario) async {
    categorias = await _getCategoriasUsecase(uidUsuario);
    notifyListeners();
  }

  Future<dynamic> updateCategoria(Categoria categoria) async {
    final result = await _updateCategoriaUsecase(categoria);
    await getCategorias(userId);
    return result;
  }
}
