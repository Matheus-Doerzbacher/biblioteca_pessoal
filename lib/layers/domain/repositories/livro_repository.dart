import 'dart:io';

import 'package:biblioteca_pessoal/layers/domain/entities/livro_entity.dart';

abstract class CreateLivroRepository {
  Future<bool> call(Livro livro);
}

abstract class DeleteLivroRepository {
  Future<bool> call(String id);
}

abstract class GetLivroByIdRepository {
  Future<Livro> call(String idLivro);
}

abstract class GetLivrosRepository {
  Future<List<Livro>> call(String uidUsuario);
}

abstract class UpdateLivroRepository {
  Future<bool> call(Livro livro);
}

abstract class SalvarImagemLivroRepository {
  Future<String> call(File imagem);
}

abstract class PesquisarLivroApiRepository {
  Future<List<Livro>> call(String titulo);
}
