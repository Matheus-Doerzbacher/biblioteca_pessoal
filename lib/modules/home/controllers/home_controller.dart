import 'package:biblioteca_pessoal/modules/livro/models/livro.dart';
import 'package:biblioteca_pessoal/modules/livro/repositories/get_livros_repository.dart';
import 'package:biblioteca_pessoal/modules/livro/repositories/update_livro_repository.dart';
import 'package:biblioteca_pessoal/modules/usuario/controllers/user_controller.dart';
import 'package:flutter/foundation.dart';

class HomeController extends ChangeNotifier {
  final GetLivrosRepository _getLivrosRepository;
  final UpdateLivroRepository _updateLivroRepository;

  HomeController(this._getLivrosRepository, this._updateLivroRepository);

  late List<Livro> livros = [];
  bool isLoading = false;

  Future<void> getLivros() async {
    try {
      isLoading = true;
      notifyListeners();
      livros = await _getLivrosRepository(UserController.user!.uid);
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> favoritarLivro(Livro livro) async {
    try {
      livro.atualizarIsFavorito();
      final result = await _updateLivroRepository(livro);

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
