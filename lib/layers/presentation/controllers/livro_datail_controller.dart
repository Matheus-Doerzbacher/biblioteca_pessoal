import 'package:biblioteca_pessoal/layers/domain/usecases/livro_usecase/livro_usecase.dart';

class LivroDatailController {
  final DeleteLivroUsecase _deleteLivroUsecase;

  LivroDatailController(this._deleteLivroUsecase);

  Future<bool> deleteLivro(String idLivro) async {
    return _deleteLivroUsecase(idLivro);
  }
}
