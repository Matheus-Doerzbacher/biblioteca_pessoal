import 'dart:io';

import 'package:biblioteca_pessoal/layers/domain/entities/livro_entity.dart';
import 'package:biblioteca_pessoal/layers/domain/usecases/livro_usecase/livro_usecase.dart';

class AdicionarLivroController {
  final CreateLivroUsecase _createLivroUsecase;
  final UpdateLivroUsecase _updateLivroUsecase;
  final SalvarImagemLivroUsecase _salvarImagemLivroUsecase;

  AdicionarLivroController(
    this._createLivroUsecase,
    this._updateLivroUsecase,
    this._salvarImagemLivroUsecase,
  );

  Future<bool> createLivro(Livro livro) {
    return _createLivroUsecase(livro);
  }

  Future<bool> updateLivro(Livro livro) {
    return _updateLivroUsecase(livro);
  }

  Future<String> salvarImageLivro(File imagem) {
    return _salvarImagemLivroUsecase(imagem);
  }
}
