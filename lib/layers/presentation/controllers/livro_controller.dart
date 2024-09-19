import 'package:biblioteca_pessoal/layers/domain/entities/livro_entity.dart';
import 'package:biblioteca_pessoal/layers/domain/usecases/livro_usecase/livro_usecase.dart';

class LivroController {
  final GetLivroByIdUsecase _getLivroByIdUsecase;
  final GetLivrosUsecase _getLivrosUsecase;
  final CreateLivroUsecase _createLivroUsecase;
  final UpdateLivroUsecase _updateLivroUsecase;
  final DeleteLivroUsecase _deleteLivroUsecase;

  LivroController(
    this._getLivroByIdUsecase,
    this._getLivrosUsecase,
    this._createLivroUsecase,
    this._updateLivroUsecase,
    this._deleteLivroUsecase,
  ) {
    getLivros();
  }

  late List<Livro> livros;

  getLivroById(String idLivro) async {
    return await _getLivroByIdUsecase(idLivro);
  }

  getLivros() async {
    livros = await _getLivrosUsecase();
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
}
