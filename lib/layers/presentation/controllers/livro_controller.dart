import 'dart:io';
import 'package:flutter/material.dart';
import 'package:biblioteca_pessoal/layers/domain/entities/livro_entity.dart';
import 'package:biblioteca_pessoal/layers/domain/usecases/livro_usecase/livro_usecase.dart';
import 'package:biblioteca_pessoal/layers/presentation/controllers/user_controller.dart';

class LivroController extends ChangeNotifier {
  final GetLivroByIdUsecase _getLivroByIdUsecase;
  final GetLivrosUsecase _getLivrosUsecase;
  final CreateLivroUsecase _createLivroUsecase;
  final UpdateLivroUsecase _updateLivroUsecase;
  final DeleteLivroUsecase _deleteLivroUsecase;
  final SalvarImagemLivroUsecase _salvarImagemLivroUsecase;

  LivroController(
    this._getLivroByIdUsecase,
    this._getLivrosUsecase,
    this._createLivroUsecase,
    this._updateLivroUsecase,
    this._deleteLivroUsecase,
    this._salvarImagemLivroUsecase,
  ) {
    getLivros(userId);
  }

  final userId = UserController.user?.uid ?? '';

  late List<Livro> livros = [];

  Future<Livro> getLivroById(String idLivro) async {
    return await _getLivroByIdUsecase(idLivro);
  }

  Future<void> getLivros(String uidUsuario) async {
    livros = await _getLivrosUsecase(uidUsuario);
    notifyListeners();
  }

  Future<bool> createLivro(Livro livro) async {
    final result = await _createLivroUsecase(livro);
    await getLivros(userId);
    return result;
  }

  Future<bool> updateLivro(Livro livro) async {
    final result = await _updateLivroUsecase(livro);
    await getLivros(userId);
    return result;
  }

  Future<bool> deleteLivro(String idLivro) async {
    final result = await _deleteLivroUsecase(idLivro);
    await getLivros(userId);
    return result;
  }

  Future<String> salvarImageLivro(File imagem) async {
    return await _salvarImagemLivroUsecase(imagem);
  }
}
