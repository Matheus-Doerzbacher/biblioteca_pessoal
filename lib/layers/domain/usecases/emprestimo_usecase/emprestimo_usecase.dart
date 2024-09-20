import 'package:biblioteca_pessoal/layers/domain/entities/emprestimo_entity.dart';

abstract class CreateEmprestimoUsecase {
  Future<bool> call(Emprestimo emprestimo);
}

abstract class GetEmprestimoByIdUsecase {
  Future<Emprestimo> call(String idEmprestimo);
}

abstract class GetEmprestimosUsecase {
  Future<List<Emprestimo>> call(String uidUsuario);
}

abstract class DeleteEmprestimoUsecase {
  Future<bool> call(String idEmprestimo);
}

abstract class UpdateEmprestimoUsecase {
  Future<bool> call(Emprestimo emprestimo);
}
