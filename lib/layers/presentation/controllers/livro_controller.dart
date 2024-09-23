import 'dart:io';

import 'package:biblioteca_pessoal/layers/domain/entities/livro_entity.dart';
import 'package:biblioteca_pessoal/layers/domain/usecases/livro_usecase/livro_usecase.dart';
import 'package:biblioteca_pessoal/layers/presentation/controllers/user_controller.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class LivroController {
  final GetLivroByIdUsecase _getLivroByIdUsecase;
  final GetLivrosUsecase _getLivrosUsecase;
  final CreateLivroUsecase _createLivroUsecase;
  final UpdateLivroUsecase _updateLivroUsecase;
  final DeleteLivroUsecase _deleteLivroUsecase;

  LivroController(
    this._getLivroByIdUsecase,
    this._getLivrosUsecase,
    this._createLivroUsecase,
    this._updateLivroUsecase,
    this._deleteLivroUsecase,
  ) {
    getLivros(UserController.user?.uid ?? '');
  }

  late List<Livro> livros;

  getLivroById(String idLivro) async {
    return await _getLivroByIdUsecase(idLivro);
  }

  getLivros(String uidUsuario) async {
    livros = await _getLivrosUsecase(uidUsuario);
  }

  createLivro(Livro livro) async {
    return await _createLivroUsecase(livro);
  }

  updateLivro(Livro livro) async {
    return await _updateLivroUsecase(livro);
  }

  deleteLivro(String idLivro) async {
    return await _deleteLivroUsecase(idLivro);
  }

  Future<String> salvarImageFirebase(File image) async {
    try {
      final storage = FirebaseStorage.instance;
      final Reference ref = storage.ref().child("livros");
      final UploadTask uploadTask = ref.putFile(image);
      final TaskSnapshot downloadUrl = (await uploadTask);
      final String url = (await downloadUrl.ref.getDownloadURL());
      return url;
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao salvar imagem no storage $e');
      }
      return '';
    }
  }
}
