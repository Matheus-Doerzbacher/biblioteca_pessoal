import 'package:biblioteca_pessoal/layers/domain/entities/categoria_entity.dart';

abstract class CreateCategoriaDatasource {
  Future<bool> call(Categoria categoria);
}

abstract class DeleteCategoriaDatasource {
  Future<bool> call(String idCategoria);
}

abstract class GetCategoriasDatasource {
  Future<List<Categoria>> call(String uidUsuario);
}

abstract class UpdateCategoriaDatasource {
  Future<bool> call(Categoria categoria);
}
