import 'package:biblioteca_pessoal/layers/domain/entities/livro.dart';
import 'package:biblioteca_pessoal/layers/domain/usecases/livro_usecase/livro_usecase.dart';
import 'package:biblioteca_pessoal/layers/presentation/controllers/user_controller.dart';
import 'package:biblioteca_pessoal/modules/emprestimo/models/emprestimo.dart';
import 'package:biblioteca_pessoal/modules/emprestimo/repositories/create_emprestimo_repository.dart';
import 'package:biblioteca_pessoal/modules/emprestimo/repositories/delete_emprestimo_repository.dart';
import 'package:biblioteca_pessoal/modules/emprestimo/repositories/get_emprestimos_repository.dart';
import 'package:biblioteca_pessoal/modules/emprestimo/repositories/update_emprestimo_repository.dart';
import 'package:flutter/foundation.dart';

class EmprestimoController extends ChangeNotifier {
  final CreateEmprestimoRepository _createEmprestimoRepository;
  final GetEmprestimosRepository _emprestimosRepository;
  final GetLivrosComEstoqueUsecase _getLivrosComEstoqueUsecase;
  final GetLivroByIdUsecase _getLivroByIdUsecase;
  final UpdateLivroUsecase _updateLivroUsecase;
  final UpdateEmprestimoRepository _updateEmprestimoRepository;
  final DeleteEmprestimoRepository _deleteEmprestimoRepository;

  EmprestimoController(
    this._createEmprestimoRepository,
    this._emprestimosRepository,
    this._getLivrosComEstoqueUsecase,
    this._getLivroByIdUsecase,
    this._updateLivroUsecase,
    this._updateEmprestimoRepository,
    this._deleteEmprestimoRepository,
  );

  List<Emprestimo> emprestimos = [];
  List<Livro> meusLivros = [];

  bool isLoading = false;

  Future<bool> createEmprestimo(Emprestimo emprestimo) async {
    try {
      isLoading = true;
      notifyListeners();
      await _createEmprestimoRepository(emprestimo);

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
      emprestimos = await _emprestimosRepository(UserController.user!.uid);
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
      await _updateEmprestimoRepository(emprestimo);

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
      await _deleteEmprestimoRepository(emprestimo.id!);
      emprestimos.remove(emprestimo);
      notifyListeners();
      return true;
    } catch (error) {
      return false;
    }
  }
}
