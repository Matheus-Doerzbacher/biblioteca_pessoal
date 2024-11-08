import 'package:biblioteca_pessoal/layers/domain/entities/categoria.dart';

abstract class CreateCategoriaUsecase {
  Future<bool> call(Categoria categoria);
}

abstract class DeleteCategoriaUsecase {
  Future<bool> call(String idCategoria);
}

abstract class GetCategoriasUsecase {
  Future<List<Categoria>> call(String uidUsuario);
}

abstract class UpdateCategoriaUsecase {
  Future<bool> call(Categoria categoria);
}
