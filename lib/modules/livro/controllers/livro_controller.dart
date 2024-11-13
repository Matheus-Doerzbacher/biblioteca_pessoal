import 'dart:io';

import 'package:biblioteca_pessoal/modules/categoria/models/categoria.dart';
import 'package:biblioteca_pessoal/modules/categoria/repositories/get_categorias_repository.dart';
import 'package:biblioteca_pessoal/modules/livro/models/livro.dart';
import 'package:biblioteca_pessoal/modules/livro/repositories/create_livro_repository.dart';
import 'package:biblioteca_pessoal/modules/livro/repositories/delete_livro_repository.dart';
import 'package:biblioteca_pessoal/modules/livro/repositories/get_livros_repository.dart';
import 'package:biblioteca_pessoal/modules/livro/repositories/salvar_imagem_livro_repository.dart';
import 'package:biblioteca_pessoal/modules/livro/repositories/update_livro_repository.dart';
import 'package:biblioteca_pessoal/modules/usuario/controllers/user_controller.dart';
import 'package:flutter/foundation.dart';

class LivroController extends ChangeNotifier {
  final GetLivrosRepository _getLivrosRepository;
  final UpdateLivroRepository _updateLivroRepository;
  final CreateLivroRepository _createLivroRepository;
  final SalvarImagemLivroRepository _salvarImagemLivroRepository;
  final GetCategoriasRepository _getCategoriasRepository;
  final DeleteLivroRepository _deleteLivroRepository;

  LivroController(
    this._getLivrosRepository,
    this._updateLivroRepository,
    this._createLivroRepository,
    this._salvarImagemLivroRepository,
    this._getCategoriasRepository,
    this._deleteLivroRepository,
  ) {
    getLivros();
  }

  List<Livro> _livros = [];
  List<Categoria> _categoriasUsuario = [];

  bool isLoading = false;

  List<Livro> get livros => _livros;
  List<Categoria> get categoriasUsuario => _categoriasUsuario;

  Future<void> getLivros() async {
    try {
      isLoading = true;
      notifyListeners();
      _livros = await _getLivrosRepository(UserController.user!.uid);
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void _updateLivro(Livro livro) {
    final index = _livros.indexWhere((liv) => liv.id == livro.id);
    _livros
      ..removeAt(index)
      ..insert(index, livro);
    notifyListeners();
  }

  Future<void> favoritarLivro(Livro livro) async {
    try {
      livro.atualizarIsFavorito();
      await _updateLivroRepository(livro);
      _updateLivro(livro);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> createLivro(Livro livro) async {
    try {
      isLoading = true;
      notifyListeners();

      final newLivro = await _createLivroRepository(livro);
      if (newLivro != null) {
        _livros.add(newLivro);
        notifyListeners();
      }
    } catch (error) {
      throw Exception('Erro ao adicionar livro');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateLivro(Livro livro) async {
    try {
      isLoading = true;
      notifyListeners();

      await _updateLivroRepository(livro);
      _updateLivro(livro);
    } catch (error) {
      throw Exception('Erro ao atualizar livro');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<String> salvarImageLivro(File imagem) async {
    return _salvarImagemLivroRepository(imagem);
  }

  Future<void> getCategorias() async {
    _categoriasUsuario =
        await _getCategoriasRepository(UserController.user!.uid);
    notifyListeners();
  }

  Future<void> deleteLivro(String idLivro) async {
    try {
      isLoading = true;
      notifyListeners();

      await _deleteLivroRepository(idLivro);
      _livros = _livros.where((livro) => livro.id != idLivro).toList();
      notifyListeners();
    } catch (error) {
      throw Exception('Erro ao atualizar livro');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
