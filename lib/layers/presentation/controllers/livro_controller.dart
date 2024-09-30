import 'dart:io';

import 'package:biblioteca_pessoal/layers/domain/entities/livro_entity.dart';
import 'package:biblioteca_pessoal/layers/domain/usecases/livro_usecase/livro_usecase.dart';
import 'package:biblioteca_pessoal/layers/presentation/controllers/user_controller.dart';
import 'package:flutter/material.dart';

class LivroController extends ChangeNotifier {
  final GetLivroByIdUsecase _getLivroByIdUsecase;
  final GetLivroByNameUsecase _getLivroByNameUsecase;
  final GetLivrosUsecase _getLivrosUsecase;
  final CreateLivroUsecase _createLivroUsecase;
  final UpdateLivroUsecase _updateLivroUsecase;
  final DeleteLivroUsecase _deleteLivroUsecase;
  final SalvarImagemLivroUsecase _salvarImagemLivroUsecase;

  LivroController(
    this._getLivroByIdUsecase,
    this._getLivroByNameUsecase,
    this._getLivrosUsecase,
    this._createLivroUsecase,
    this._updateLivroUsecase,
    this._deleteLivroUsecase,
    this._salvarImagemLivroUsecase,
  ) {
    getLivros(UserController.user?.uid ?? '');
  }

  final _userId = UserController.user?.uid ?? '';

  late List<Livro> livros = [];
  bool isLoading = false;

  Future<Livro> getLivroById(String idLivro) async {
    return _getLivroByIdUsecase(idLivro);
  }

  Future<Livro?> getLivroByName(String titulo) async {
    return _getLivroByNameUsecase(titulo);
  }

  Future<void> getLivros(String uidUsuario) async {
    try {
      isLoading = true;
      notifyListeners();
      livros = await _getLivrosUsecase(uidUsuario);
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createLivro(Livro livro) async {
    try {
      isLoading = true;
      notifyListeners();
      final result = await _createLivroUsecase(livro);
      return result;
    } catch (e) {
      isLoading = false;
      notifyListeners();
      return false;
    } finally {
      await getLivros(_userId);
    }
  }

  Future<bool> updateLivro(Livro livro) async {
    try {
      isLoading = true;
      notifyListeners();
      final result = await _updateLivroUsecase(livro);
      return result;
    } catch (e) {
      isLoading = false;
      notifyListeners();
      return false;
    } finally {
      await getLivros(_userId);
    }
  }

  Future<bool> deleteLivro(String idLivro) async {
    try {
      isLoading = true;
      notifyListeners();
      final result = await _deleteLivroUsecase(idLivro);
      return result;
    } catch (e) {
      isLoading = false;
      notifyListeners();
      return false;
    } finally {
      await getLivros(_userId);
    }
  }

  Future<String> salvarImageLivro(File imagem) async {
    return _salvarImagemLivroUsecase(imagem);
  }
}
