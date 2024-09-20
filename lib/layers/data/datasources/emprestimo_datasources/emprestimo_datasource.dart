import 'package:biblioteca_pessoal/layers/domain/entities/emprestimo_entity.dart';

abstract class CreateEmprestimoDatasource {
  Future<bool> call(Emprestimo emprestimo);
}

abstract class GetEmprestimoByIdDatasource {
  Future<Emprestimo> call(String idEmprestimo);
}

abstract class GetEmprestimosDatasource {
  Future<List<Emprestimo>> call(String uidUsuario);
}

abstract class UpdateEmprestimoDatasource {
  Future<bool> call(Emprestimo emprestimo);
}

abstract class DeleteEmprestimoDatasource {
  Future<bool> call(String idEmprestimo);
}
