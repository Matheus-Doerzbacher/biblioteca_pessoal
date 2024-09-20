import 'package:biblioteca_pessoal/layers/domain/entities/categoria_entity.dart';

abstract class CreateCategoriaRepository {
  Future<bool> call(Categoria categoria);
}

abstract class DeleteCategoriaRepository {
  Future<bool> call(String idCategoria);
}

abstract class GetCategoriasRepository {
  Future<List<Categoria>> call(String uidUsuario);
}

abstract class UpdateCategoriaRepository {
  Future<bool> call(Categoria categoria);
}
