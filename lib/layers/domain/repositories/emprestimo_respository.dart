import 'package:biblioteca_pessoal/layers/domain/entities/emprestimo.dart';

abstract class CreateEmprestimoRepository {
  Future<bool> call(Emprestimo emprestimo);
}

abstract class GetEmprestimoByIdRepository {
  Future<Emprestimo> call(String idEmprestimo);
}

abstract class GetEmprestimosRepository {
  Future<List<Emprestimo>> call(String uidUsuario);
}

abstract class DeleteEmprestimoRepository {
  Future<bool> call(String idEmprestimo);
}

abstract class UpdateEmprestimoRepository {
  Future<bool> call(Emprestimo emprestimo);
}
