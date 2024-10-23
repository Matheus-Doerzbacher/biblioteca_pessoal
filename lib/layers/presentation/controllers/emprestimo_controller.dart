import 'package:biblioteca_pessoal/layers/domain/entities/emprestimo_entity.dart';
import 'package:biblioteca_pessoal/layers/domain/entities/livro_entity.dart';
import 'package:biblioteca_pessoal/layers/domain/usecases/emprestimo_usecase/emprestimo_usecase.dart';
import 'package:biblioteca_pessoal/layers/domain/usecases/livro_usecase/livro_usecase.dart';
import 'package:biblioteca_pessoal/layers/presentation/controllers/user_controller.dart';
import 'package:flutter/material.dart';

class EmprestimoController extends ChangeNotifier {
  final CreateEmprestimoUsecase _createEmprestimoUsecase;
  final GetEmprestimosUsecase _getEmprestimosUsecase;
  final GetLivrosComEstoqueUsecase _getLivrosComEstoqueUsecase;

  EmprestimoController(
    this._createEmprestimoUsecase,
    this._getEmprestimosUsecase,
    this._getLivrosComEstoqueUsecase,
  );

  List<Emprestimo> emprestimos = [];
  List<Livro> meusLivros = [];

  bool isLoading = false;

  Future<bool> createEmprestimo(Emprestimo emprestimo) async {
    try {
      isLoading = true;
      notifyListeners();
      await _createEmprestimoUsecase(emprestimo);
      await getEmprestimos();
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<void> getEmprestimos() async {
    try {
      isLoading = true;
      notifyListeners();

      emprestimos = await _getEmprestimosUsecase(UserController.user!.uid);
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getLivros() async {
    try {
      isLoading = true;
      notifyListeners();

      meusLivros = await _getLivrosComEstoqueUsecase(UserController.user!.uid);
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
