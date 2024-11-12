import 'package:biblioteca_pessoal/core/utils/db_print.dart';
import 'package:biblioteca_pessoal/modules/categoria/models/categoria.dart';
import 'package:biblioteca_pessoal/modules/categoria/repositories/create_categoria_repository.dart';
import 'package:biblioteca_pessoal/modules/categoria/repositories/delete_categoria_repository.dart';
import 'package:biblioteca_pessoal/modules/categoria/repositories/get_categorias_repository.dart';
import 'package:biblioteca_pessoal/modules/categoria/repositories/update_categoria_repository.dart';
import 'package:biblioteca_pessoal/modules/usuario/controllers/user_controller.dart';
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

  List<Categoria> _categorias = [];

  bool isLoading = false;
  List<Categoria> get categorias => _categorias;

  Future<void> createCategoria(Categoria categoria) async {
    try {
      isLoading = true;
      notifyListeners();
      final result = await _createCategoriaRepository(categoria);
      if (result) {
        _categorias.add(categoria);
        notifyListeners();
      }
    } catch (error) {
      dbPrint('Erro ao criar Categoria');
      dbPrint(error);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteCategoria(String idCategoria) async {
    try {
      isLoading = true;
      notifyListeners();
      final result = await _deleteCategoriaRepository(idCategoria);
      if (result) {
        _categorias = _categorias.where((categoria) {
          return categoria.id != idCategoria;
        }).toList();
        notifyListeners();
      }
    } catch (error) {
      dbPrint('Erro ao deletar Categoria');
      dbPrint(error);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<dynamic> getCategorias(String uidUsuario) async {
    try {
      isLoading = true;
      notifyListeners();
      _categorias = await _getCategoriasRepository(uidUsuario);
      notifyListeners();
    } catch (error) {
      dbPrint('Erro ao buscar Categorias');
      dbPrint(error);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<dynamic> updateCategoria(Categoria categoria) async {
    try {
      isLoading = true;
      notifyListeners();
      final result = await _updateCategoriaRepository(categoria);
      await getCategorias(userId);
      return result;
    } catch (error) {
      dbPrint('Erro ao buscar Categorias');
      dbPrint(error);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
