import 'dart:io';

import 'package:biblioteca_pessoal/layers/domain/entities/livro_entity.dart';

abstract class CreateLivroUsecase {
  Future<bool> call(Livro livro);
}

abstract class DeleteLivroUsecase {
  Future<bool> call(String id);
}

abstract class GetLivroByIdUsecase {
  Future<Livro> call(String id);
}

abstract class GetLivrosUsecase {
  Future<List<Livro>> call(String uidUsuario);
}

abstract class UpdateLivroUsecase {
  Future<bool> call(Livro livro);
}

abstract class SalvarImagemLivroUsecase {
  Future<String> call(File imagem);
}

abstract class PesquisarLivroApiUsecase {
  Future<List<Livro>> call(String titulo);
}
