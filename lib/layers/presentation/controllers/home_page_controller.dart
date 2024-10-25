import 'package:biblioteca_pessoal/layers/domain/entities/livro_entity.dart';
import 'package:biblioteca_pessoal/layers/domain/usecases/livro_usecase/livro_usecase.dart';
import 'package:biblioteca_pessoal/layers/presentation/controllers/user_controller.dart';
import 'package:flutter/foundation.dart';

class HomePageController extends ChangeNotifier {
  final GetLivrosUsecase _getLivrosUsecase;
  final UpdateLivroUsecase _updateLivroUsecase;

  HomePageController(this._getLivrosUsecase, this._updateLivroUsecase);

  late List<Livro> livros = [];
  bool isLoading = false;

  Future<void> getLivros() async {
    try {
      isLoading = true;
      notifyListeners();
      livros = await _getLivrosUsecase(UserController.user!.uid);
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> favoritarLivro(Livro livro) async {
    try {
      livro.atualizarIsFavorito();
      final result = await _updateLivroUsecase(livro);

      await getLivros();
      return result;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }
}
