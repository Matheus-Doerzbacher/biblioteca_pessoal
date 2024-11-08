import 'dart:io';

import 'package:biblioteca_pessoal/layers/domain/entities/livro.dart';
import 'package:biblioteca_pessoal/layers/domain/usecases/livro_usecase/livro_usecase.dart';
import 'package:biblioteca_pessoal/layers/presentation/controllers/user_controller.dart';
import 'package:biblioteca_pessoal/modules/categoria/models/categoria.dart';
import 'package:biblioteca_pessoal/modules/categoria/repositories/get_categorias_repository.dart';
import 'package:flutter/material.dart';

class AdicionarLivroController extends ChangeNotifier {
  final CreateLivroUsecase _createLivroUsecase;
  final UpdateLivroUsecase _updateLivroUsecase;
  final SalvarImagemLivroUsecase _salvarImagemLivroUsecase;
  final GetCategoriasRepository _getCategoriasRepository;

  AdicionarLivroController(
    this._createLivroUsecase,
    this._updateLivroUsecase,
    this._salvarImagemLivroUsecase,
    this._getCategoriasRepository,
  );

  List<Categoria> categoriasUsuario = [];

  Future<bool> createLivro(Livro livro) async {
    try {
      return _createLivroUsecase(livro);
    } catch (error) {
      throw Exception('Erro ao adicionar livro');
    } finally {
      await getCategorias();
    }
  }

  Future<bool> updateLivro(Livro livro) async {
    try {
      return _updateLivroUsecase(livro);
    } catch (error) {
      throw Exception('Erro ao atualizar livro');
    } finally {
      await getCategorias();
    }
  }

  Future<String> salvarImageLivro(File imagem) async {
    return _salvarImagemLivroUsecase(imagem);
  }

  Future<void> getCategorias() async {
    categoriasUsuario =
        await _getCategoriasRepository(UserController.user!.uid);
    notifyListeners();
  }
}
