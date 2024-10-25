import 'dart:io';

import 'package:biblioteca_pessoal/layers/domain/entities/categoria_entity.dart';
import 'package:biblioteca_pessoal/layers/domain/entities/livro_entity.dart';
import 'package:biblioteca_pessoal/layers/domain/usecases/categoria_usecase/categoria_usecase.dart';
import 'package:biblioteca_pessoal/layers/domain/usecases/livro_usecase/livro_usecase.dart';
import 'package:biblioteca_pessoal/layers/presentation/controllers/user_controller.dart';

class AdicionarLivroController {
  final CreateLivroUsecase _createLivroUsecase;
  final UpdateLivroUsecase _updateLivroUsecase;
  final SalvarImagemLivroUsecase _salvarImagemLivroUsecase;
  final GetCategoriasUsecase _getCategoriasUsecase;

  AdicionarLivroController(
    this._createLivroUsecase,
    this._updateLivroUsecase,
    this._salvarImagemLivroUsecase,
    this._getCategoriasUsecase,
  );

  List<Categoria> categoriasUsuario = [];

  Future<bool> createLivro(Livro livro) {
    return _createLivroUsecase(livro);
  }

  Future<bool> updateLivro(Livro livro) {
    return _updateLivroUsecase(livro);
  }

  Future<String> salvarImageLivro(File imagem) {
    return _salvarImagemLivroUsecase(imagem);
  }

  Future<void> getCategorias() async {
    categoriasUsuario = await _getCategoriasUsecase(UserController.user!.uid);
  }
}
