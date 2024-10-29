import 'package:biblioteca_pessoal/layers/domain/entities/emprestimo_entity.dart';
import 'package:biblioteca_pessoal/layers/domain/entities/livro_entity.dart';
import 'package:biblioteca_pessoal/layers/domain/usecases/emprestimo_usecase/emprestimo_usecase.dart';
import 'package:biblioteca_pessoal/layers/domain/usecases/livro_usecase/livro_usecase.dart';
import 'package:biblioteca_pessoal/layers/presentation/controllers/user_controller.dart';
import 'package:flutter/foundation.dart';

class EmprestimoController extends ChangeNotifier {
  final CreateEmprestimoUsecase _createEmprestimoUsecase;
  final GetEmprestimosUsecase _getEmprestimosUsecase;
  final GetLivrosComEstoqueUsecase _getLivrosComEstoqueUsecase;
  final GetLivroByIdUsecase _getLivroByIdUsecase;
  final UpdateLivroUsecase _updateLivroUsecase;
  final UpdateEmprestimoUsecase _updateEmprestimoUsecase;
  final DeleteEmprestimoUsecase _deleteEmprestimoUsecase;

  EmprestimoController(
    this._createEmprestimoUsecase,
    this._getEmprestimosUsecase,
    this._getLivrosComEstoqueUsecase,
    this._getLivroByIdUsecase,
    this._updateLivroUsecase,
    this._updateEmprestimoUsecase,
    this._deleteEmprestimoUsecase,
  );

  List<Emprestimo> emprestimos = [];
  List<Livro> meusLivros = [];

  bool isLoading = false;

  Future<bool> createEmprestimo(Emprestimo emprestimo) async {
    try {
      isLoading = true;
      notifyListeners();
      await _createEmprestimoUsecase(emprestimo);

      // Fas os ajuste na quantidade de estoque do livro emprestado
      final livro = await _getLivroByIdUsecase(emprestimo.idLivro);
      livro.emprestimo(emprestimo.quantidade);
      await _updateLivroUsecase(livro);
      return true;
    } catch (error) {
      isLoading = false;
      notifyListeners();

      if (kDebugMode) {
        print(error);
      }

      return false;
    } finally {
      await getEmprestimos();
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

  Future<bool> updateEmprestimo(Emprestimo emprestimo) async {
    try {
      isLoading = true;
      notifyListeners();

      emprestimo.fazerDevolucao();
      await _updateEmprestimoUsecase(emprestimo);

      final livro = await _getLivroByIdUsecase(emprestimo.idLivro);
      livro.devolverEmprestimo(emprestimo.quantidade);

      await _updateLivroUsecase(livro);

      return true;
    } catch (error) {
      isLoading = false;
      notifyListeners();

      if (kDebugMode) {
        print(error);
      }
      return false;
    } finally {
      await getEmprestimos();
    }
  }

  Future<bool> deleteEmprestimo(Emprestimo emprestimo) async {
    try {
      await _deleteEmprestimoUsecase(emprestimo.id!);
      emprestimos.remove(emprestimo);
      notifyListeners();
      return true;
    } catch (error) {
      return false;
    }
  }
}
