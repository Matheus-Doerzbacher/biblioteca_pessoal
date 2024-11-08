import 'package:biblioteca_pessoal/layers/presentation/controllers/user_controller.dart';
import 'package:biblioteca_pessoal/modules/categoria/models/categoria.dart';
import 'package:biblioteca_pessoal/modules/categoria/repositories/create_categoria_repository.dart';
import 'package:biblioteca_pessoal/modules/categoria/repositories/delete_categoria_repository.dart';
import 'package:biblioteca_pessoal/modules/categoria/repositories/get_categorias_repository.dart';
import 'package:biblioteca_pessoal/modules/categoria/repositories/update_categoria_repository.dart';
import 'package:flutter/material.dart';

class CategoriaController extends ChangeNotifier {
  final CreateCategoriaRepository _createCategoriaRepository;
  final DeleteCategoriaRepository _deleteCategoriaRepository;
  final GetCategoriasRepository _getCategoriasRepository;
  final UpdateCategoriaRepository _updateCategoriaRepository;

  CategoriaController(
    this._createCategoriaRepository,
    this._deleteCategoriaRepository,
    this._getCategoriasRepository,
    this._updateCategoriaRepository,
  );

  final userId = UserController.user?.uid ?? '';
  late bool isLoading = false;
  late List<Categoria> categorias = [];

  Future<dynamic> createCategoria(Categoria categoria) async {
    isLoading = true;
    notifyListeners();
    final result = await _createCategoriaRepository(categoria);
    await getCategorias(userId);
    return result;
  }

  Future<dynamic> deleteCategoria(String idCategoria) async {
    isLoading = true;
    notifyListeners();
    final result = await _deleteCategoriaRepository(idCategoria);
    await getCategorias(userId);
    return result;
  }

  Future<dynamic> getCategorias(String uidUsuario) async {
    try {
      isLoading = true;
      notifyListeners();
      categorias = await _getCategoriasRepository(uidUsuario);
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<dynamic> updateCategoria(Categoria categoria) async {
    isLoading = true;
    notifyListeners();
    final result = await _updateCategoriaRepository(categoria);
    await getCategorias(userId);
    return result;
  }
}
