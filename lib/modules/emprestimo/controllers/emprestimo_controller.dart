import 'package:biblioteca_pessoal/modules/emprestimo/models/emprestimo.dart';
import 'package:biblioteca_pessoal/modules/emprestimo/repositories/create_emprestimo_repository.dart';
import 'package:biblioteca_pessoal/modules/emprestimo/repositories/delete_emprestimo_repository.dart';
import 'package:biblioteca_pessoal/modules/emprestimo/repositories/get_emprestimos_repository.dart';
import 'package:biblioteca_pessoal/modules/emprestimo/repositories/update_emprestimo_repository.dart';
import 'package:biblioteca_pessoal/modules/livro/models/livro.dart';
import 'package:biblioteca_pessoal/modules/livro/repositories/get_livro_by_id_repository.dart';
import 'package:biblioteca_pessoal/modules/livro/repositories/get_livros_com_estoque_repository.dart';
import 'package:biblioteca_pessoal/modules/livro/repositories/update_livro_repository.dart';
import 'package:biblioteca_pessoal/modules/usuario/controllers/user_controller.dart';
import 'package:flutter/foundation.dart';

class EmprestimoController extends ChangeNotifier {
  final CreateEmprestimoRepository _createEmprestimoRepository;
  final GetEmprestimosRepository _emprestimosRepository;
  final GetLivrosComEstoqueRepository _getLivrosComEstoqueRepository;
  final GetLivroByIdRepository _getLivroByIdRepository;
  final UpdateLivroRepository _updateLivroRepository;
  final UpdateEmprestimoRepository _updateEmprestimoRepository;
  final DeleteEmprestimoRepository _deleteEmprestimoRepository;

  EmprestimoController(
    this._createEmprestimoRepository,
    this._emprestimosRepository,
    this._getLivrosComEstoqueRepository,
    this._getLivroByIdRepository,
    this._updateLivroRepository,
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
      final livro = await _getLivroByIdRepository(emprestimo.idLivro);
      livro.emprestimo(emprestimo.quantidade);
      await _updateLivroRepository(livro);
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

      meusLivros =
          await _getLivrosComEstoqueRepository(UserController.user!.uid);
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

      final livro = await _getLivroByIdRepository(emprestimo.idLivro);
      livro.devolverEmprestimo(emprestimo.quantidade);

      await _updateLivroRepository(livro);

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
