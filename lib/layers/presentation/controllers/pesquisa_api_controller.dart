import 'package:biblioteca_pessoal/layers/domain/entities/livro_entity.dart';
import 'package:biblioteca_pessoal/layers/domain/usecases/livro_usecase/livro_usecase.dart';
import 'package:flutter/material.dart';

class PesquisaApiController extends ChangeNotifier {
  final PesquisarLivroApiUsecase _pesquisarLivroApiUsecase;

  PesquisaApiController(this._pesquisarLivroApiUsecase);

  List<Livro> livros = [];
  bool isLoading = false;

  Future<void> getLivrosApi(String titulo) async {
    isLoading = true;
    notifyListeners();
    livros = await _pesquisarLivroApiUsecase(titulo);
    notifyListeners();
    isLoading = false;
    notifyListeners();
  }

  void clearLivros() {
    livros = [];
    notifyListeners();
  }
}
