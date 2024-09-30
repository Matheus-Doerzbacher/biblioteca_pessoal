import 'dart:io';

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

abstract class GetLivroByNameDatasource {
  Future<Livro?> call(String titulo);
}

abstract class GetLivrosDatasource {
  Future<List<Livro>> call(String uidUsuario);
}

abstract class UpdateLivroDatasource {
  Future<bool> call(Livro livro);
}

abstract class SalvarImagemLivroDatasource {
  Future<String> call(File imagem);
}

abstract class PesquisarLivroApiDatasource {
  Future<List<Livro>> call(String titulo);
}
