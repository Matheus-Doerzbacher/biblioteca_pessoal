import 'package:biblioteca_pessoal/layers/domain/entities/emprestimo_entity.dart';
import 'package:biblioteca_pessoal/layers/domain/repositories/emprestimo_respository.dart';
import 'package:biblioteca_pessoal/layers/domain/usecases/emprestimo_usecase/emprestimo_usecase.dart';

class CreateEmprestimoUsecaseImp implements CreateEmprestimoUsecase {
  final CreateEmprestimoRepository _createEmprestimoRepository;

  CreateEmprestimoUsecaseImp(this._createEmprestimoRepository);

  @override
  Future<bool> call(Emprestimo emprestimo) async {
    return await _createEmprestimoRepository(emprestimo);
  }
}

////////////////////////////////////////////////////////////

class GetEmprestimoByIdUsecaseImp implements GetEmprestimoByIdUsecase {
  final GetEmprestimoByIdRepository _getEmprestimoByIdRepository;

  GetEmprestimoByIdUsecaseImp(this._getEmprestimoByIdRepository);

  @override
  Future<Emprestimo> call(String idEmprestimo) async {
    return await _getEmprestimoByIdRepository(idEmprestimo);
  }
}

////////////////////////////////////////////////////////////

class GetEmprestimosUsecaseImp implements GetEmprestimosUsecase {
  final GetEmprestimosRepository _getEmprestimosRepository;

  GetEmprestimosUsecaseImp(this._getEmprestimosRepository);

  @override
  Future<List<Emprestimo>> call() async {
    return await _getEmprestimosRepository();
  }
}

////////////////////////////////////////////////////////////

class UpdateEmprestimoUsecaseImp implements UpdateEmprestimoUsecase {
  final UpdateEmprestimoRepository _updateEmprestimoRepository;

  UpdateEmprestimoUsecaseImp(this._updateEmprestimoRepository);

  @override
  Future<bool> call(Emprestimo emprestimo) async {
    return await _updateEmprestimoRepository(emprestimo);
  }
}

////////////////////////////////////////////////////////////

class DeleteEmprestimoUsecaseImp implements DeleteEmprestimoUsecase {
  final DeleteEmprestimoRepository _deleteEmprestimoRepository;

  DeleteEmprestimoUsecaseImp(this._deleteEmprestimoRepository);

  @override
  Future<bool> call(String idEmprestimo) async {
    return await _deleteEmprestimoRepository(idEmprestimo);
  }
}
