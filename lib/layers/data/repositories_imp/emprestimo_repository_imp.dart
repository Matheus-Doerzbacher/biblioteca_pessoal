import 'package:biblioteca_pessoal/layers/data/datasources/emprestimo_datasources/emprestimo_datasource.dart';
import 'package:biblioteca_pessoal/layers/domain/entities/emprestimo.dart';
import 'package:biblioteca_pessoal/layers/domain/repositories/emprestimo_respository.dart';

class CreateEmprestimoRepositoryImp implements CreateEmprestimoRepository {
  final CreateEmprestimoDatasource _createEmprestimoDatasource;

  CreateEmprestimoRepositoryImp(this._createEmprestimoDatasource);

  @override
  Future<bool> call(Emprestimo emprestimo) async {
    return _createEmprestimoDatasource(emprestimo);
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////

class GetEmprestimoByIdRepositoryImp implements GetEmprestimoByIdRepository {
  final GetEmprestimoByIdDatasource _getEmprestimoByIdDatasource;

  GetEmprestimoByIdRepositoryImp(this._getEmprestimoByIdDatasource);

  @override
  Future<Emprestimo> call(String idEmprestimo) async {
    return _getEmprestimoByIdDatasource(idEmprestimo);
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////

class GetEmprestimosRepositoryImp implements GetEmprestimosRepository {
  final GetEmprestimosDatasource _getEmprestimosDatasource;

  GetEmprestimosRepositoryImp(this._getEmprestimosDatasource);

  @override
  Future<List<Emprestimo>> call(String uidUsuario) async {
    return _getEmprestimosDatasource(uidUsuario);
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////

class UpdateEmprestimoRepositoryImp implements UpdateEmprestimoRepository {
  final UpdateEmprestimoDatasource _updateEmprestimoDatasource;

  UpdateEmprestimoRepositoryImp(this._updateEmprestimoDatasource);

  @override
  Future<bool> call(Emprestimo emprestimo) async {
    return _updateEmprestimoDatasource(emprestimo);
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////

class DeleteEmprestimoRepositoryImp implements DeleteEmprestimoRepository {
  final DeleteEmprestimoDatasource _deleteEmprestimoDatasource;

  DeleteEmprestimoRepositoryImp(this._deleteEmprestimoDatasource);
  @override
  Future<bool> call(String idEmprestimo) async {
    return _deleteEmprestimoDatasource(idEmprestimo);
  }
}
