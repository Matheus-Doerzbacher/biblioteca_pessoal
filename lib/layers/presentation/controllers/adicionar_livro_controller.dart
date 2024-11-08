import 'dart:io';

import 'package:biblioteca_pessoal/layers/domain/entities/livro.dart';
import 'package:biblioteca_pessoal/layers/domain/usecases/livro_usecase/livro_usecase.dart';
import 'package:biblioteca_pessoal/layers/presentation/controllers/user_controller.dart';
import 'package:biblioteca_pessoal/modules/categoria/models/categoria.dart';
import 'package:biblioteca_pessoal/modules/categoria/repositories/get_categorias_repository.dart';

class AdicionarLivroController {
  final CreateLivroUsecase _createLivroUsecase;
  final UpdateLivroUsecase _updateLivroUsecase;
  final SalvarImagemLivroUsecase _salvarImagemLivroUsecase;
  final GetCategoriasRepository _categoriasRepository;

  AdicionarLivroController(
    this._createLivroUsecase,
    this._updateLivroUsecase,
    this._salvarImagemLivroUsecase,
    this._categoriasRepository,
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
    categoriasUsuario = await _categoriasRepository(UserController.user!.uid);
  }
}
