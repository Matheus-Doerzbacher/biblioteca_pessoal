import 'package:biblioteca_pessoal/layers/domain/entities/emprestimo_entity.dart';
import 'package:biblioteca_pessoal/layers/domain/usecases/emprestimo_usecase/emprestimo_usecase.dart';

class EmprestimoController {
  final CreateEmprestimoUsecase _createEmprestimoUsecase;
  final GetEmprestimoByIdUsecase _getEmprestimoByIdUsecase;
  final GetEmprestimosUsecase _getEmprestimosUsecase;
  final UpdateEmprestimoUsecase _updateEmprestimoUsecase;
  final DeleteEmprestimoUsecase _deleteEmprestimoUsecase;

  EmprestimoController(
    this._createEmprestimoUsecase,
    this._getEmprestimoByIdUsecase,
    this._getEmprestimosUsecase,
    this._updateEmprestimoUsecase,
    this._deleteEmprestimoUsecase,
  ) {
    getEmprestimos();
  }

  late List<Emprestimo> emprestimos;

  getEmprestimoById(String idLivro) async {
    return await _getEmprestimoByIdUsecase(idLivro);
  }

  getEmprestimos() async {
    emprestimos = await _getEmprestimosUsecase();
  }

  Future<bool> createEmprestimo(Emprestimo emprestimo) async {
    return await _createEmprestimoUsecase(emprestimo);
  }

  updateEmprestimo(Emprestimo emprestimo) async {
    return await _updateEmprestimoUsecase(emprestimo);
  }

  deleteEmprestimo(String idEmprestimo) async {
    return await _deleteEmprestimoUsecase(idEmprestimo);
  }
}
