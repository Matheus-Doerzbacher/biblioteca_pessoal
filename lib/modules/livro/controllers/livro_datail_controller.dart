import 'package:biblioteca_pessoal/modules/livro/repositories/delete_livro_repository.dart';

class LivroDatailController {
  final DeleteLivroRepository _deleteLivroRepository;

  LivroDatailController(this._deleteLivroRepository);

  Future<bool> deleteLivro(String idLivro) async {
    return _deleteLivroRepository(idLivro);
  }
}
