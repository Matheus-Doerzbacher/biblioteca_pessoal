import 'dart:io';

import 'package:biblioteca_pessoal/modules/livro/models/livro.dart';
import 'package:biblioteca_pessoal/modules/categoria/models/categoria.dart';
import 'package:biblioteca_pessoal/modules/categoria/repositories/get_categorias_repository.dart';
import 'package:biblioteca_pessoal/modules/livro/repositories/create_livro_repository.dart';
import 'package:biblioteca_pessoal/modules/livro/repositories/salvar_imagem_livro_repository.dart';
import 'package:biblioteca_pessoal/modules/livro/repositories/update_livro_repository.dart';
import 'package:biblioteca_pessoal/modules/usuario/controllers/user_controller.dart';
import 'package:flutter/material.dart';

class AdicionarLivroController extends ChangeNotifier {
  final CreateLivroRepository _createLivroRepository;
  final UpdateLivroRepository _updateLivroRepository;
  final SalvarImagemLivroRepository _salvarImagemLivroRepository;
  final GetCategoriasRepository _getCategoriasRepository;

  AdicionarLivroController(
    this._createLivroRepository,
    this._updateLivroRepository,
    this._salvarImagemLivroRepository,
    this._getCategoriasRepository,
  );

  List<Categoria> categoriasUsuario = [];

  Future<bool> createLivro(Livro livro) async {
    try {
      return _createLivroRepository(livro);
    } catch (error) {
      throw Exception('Erro ao adicionar livro');
    } finally {
      await getCategorias();
    }
  }

  Future<bool> updateLivro(Livro livro) async {
    try {
      return _updateLivroRepository(livro);
    } catch (error) {
      throw Exception('Erro ao atualizar livro');
    } finally {
      await getCategorias();
    }
  }

  Future<String> salvarImageLivro(File imagem) async {
    return _salvarImagemLivroRepository(imagem);
  }

  Future<void> getCategorias() async {
    categoriasUsuario =
        await _getCategoriasRepository(UserController.user!.uid);
    notifyListeners();
  }
}
