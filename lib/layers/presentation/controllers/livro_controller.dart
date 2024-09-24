import 'dart:io';

import 'package:biblioteca_pessoal/layers/domain/entities/categoria_entity.dart';
import 'package:biblioteca_pessoal/layers/domain/entities/livro_entity.dart';
import 'package:biblioteca_pessoal/layers/domain/usecases/categoria_usecase/categoria_usecase.dart';
import 'package:biblioteca_pessoal/layers/domain/usecases/livro_usecase/livro_usecase.dart';
import 'package:biblioteca_pessoal/layers/presentation/controllers/user_controller.dart';

class LivroController {
  final GetLivroByIdUsecase _getLivroByIdUsecase;
  final GetLivrosUsecase _getLivrosUsecase;
  final CreateLivroUsecase _createLivroUsecase;
  final UpdateLivroUsecase _updateLivroUsecase;
  final DeleteLivroUsecase _deleteLivroUsecase;
  final GetCategoriasUsecase _getCategoriasUsecase;
  final SalvarImagemLivroUsecase _salvarImagemLivroUsecase;

  LivroController(
    this._getLivroByIdUsecase,
    this._getLivrosUsecase,
    this._createLivroUsecase,
    this._updateLivroUsecase,
    this._deleteLivroUsecase,
    this._getCategoriasUsecase,
    this._salvarImagemLivroUsecase,
  ) {
    getCategoriasDropDown(UserController.user?.uid ?? '');
    getLivros(UserController.user?.uid ?? '');
  }

  late List<Livro> livros;
  late List<Categoria> categoriasDropDown = [];

  getLivroById(String idLivro) async {
    return await _getLivroByIdUsecase(idLivro);
  }

  getCategoriasDropDown(String uidUsuario) async {
    categoriasDropDown = await _getCategoriasUsecase(uidUsuario);
  }

  getLivros(String uidUsuario) async {
    livros = await _getLivrosUsecase(uidUsuario);
  }

  createLivro(Livro livro) async {
    return await _createLivroUsecase(livro);
  }

  updateLivro(Livro livro) async {
    return await _updateLivroUsecase(livro);
  }

  deleteLivro(String idLivro) async {
    return await _deleteLivroUsecase(idLivro);
  }

  Future<String> salvarImageLivro(File imagem) async {
    return await _salvarImagemLivroUsecase(imagem);
  }
}
