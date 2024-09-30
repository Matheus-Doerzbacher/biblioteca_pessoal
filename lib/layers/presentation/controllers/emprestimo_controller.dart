import 'package:biblioteca_pessoal/layers/domain/entities/emprestimo_entity.dart';
import 'package:biblioteca_pessoal/layers/domain/usecases/emprestimo_usecase/emprestimo_usecase.dart';
import 'package:biblioteca_pessoal/layers/presentation/controllers/user_controller.dart';
import 'package:flutter/material.dart';

class EmprestimoController extends ChangeNotifier {
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
    getEmprestimos(userId);
  }

  final userId = UserController.user?.uid ?? '';

  late List<Emprestimo> emprestimos;

  Future<Emprestimo> getEmprestimoById(String idLivro) async {
    return _getEmprestimoByIdUsecase(idLivro);
  }

  Future<void> getEmprestimos(String uidUsuario) async {
    emprestimos = await _getEmprestimosUsecase(uidUsuario);
    notifyListeners();
  }

  Future<bool> createEmprestimo(Emprestimo emprestimo) async {
    final result = await _createEmprestimoUsecase(emprestimo);
    await getEmprestimos(userId);
    return result;
  }

  Future<bool> updateEmprestimo(Emprestimo emprestimo) async {
    final result = await _updateEmprestimoUsecase(emprestimo);
    await getEmprestimos(userId);
    return result;
  }

  Future<bool> deleteEmprestimo(String idEmprestimo) async {
    final result = await _deleteEmprestimoUsecase(idEmprestimo);
    await getEmprestimos(userId);
    return result;
  }
}
