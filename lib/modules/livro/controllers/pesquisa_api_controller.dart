import 'package:biblioteca_pessoal/modules/livro/models/livro.dart';
import 'package:biblioteca_pessoal/modules/livro/repositories/pesquisar_livro_api_repository.dart';
import 'package:flutter/material.dart';

class PesquisaApiController extends ChangeNotifier {
  final PesquisarLivroApiRepository _pesquisarLivroApiRepository;

  PesquisaApiController(this._pesquisarLivroApiRepository);

  List<Livro> livros = [];
  bool isLoading = false;

  Future<void> getLivrosApi(String titulo) async {
    isLoading = true;
    notifyListeners();
    livros = await _pesquisarLivroApiRepository(titulo);
    notifyListeners();
    isLoading = false;
    notifyListeners();
  }

  void clearLivros() {
    livros = [];
    notifyListeners();
  }
}
