import 'package:biblioteca_pessoal/layers/domain/entities/livro_entity.dart';

abstract class CreateLivroDatasource {
  Future<bool> call(Livro livro);
}

abstract class DeleteLivroDatasource {
  Future<bool> call(String id);
}

abstract class GetLivroByIdDatasource {
  Future<Livro> call(String idLivro);
}

abstract class GetLivrosDatasource {
  Future<List<Livro>> call();
}

abstract class UpdateLivroDatasource {
  Future<bool> call(Livro livro);
}
