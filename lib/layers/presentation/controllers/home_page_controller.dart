import 'package:biblioteca_pessoal/layers/domain/entities/livro_entity.dart';
import 'package:biblioteca_pessoal/layers/domain/usecases/livro_usecase/livro_usecase.dart';
import 'package:flutter/material.dart';

class HomePageController extends ChangeNotifier {
  final GetLivrosUsecase _getLivrosUsecase;

  HomePageController(this._getLivrosUsecase);

  late List<Livro> livros = [];
  bool isLoading = false;

  Future<void> getLivros(String uidUsuario) async {
    try {
      isLoading = true;
      notifyListeners();
      livros = await _getLivrosUsecase(uidUsuario);
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
