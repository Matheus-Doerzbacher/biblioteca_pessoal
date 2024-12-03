import 'dart:io';

import 'package:biblioteca_pessoal/core/utils/db_print.dart';
import 'package:biblioteca_pessoal/modules/usuario/controllers/user_controller.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SalvarImagemLivroRepository {
  Future<String> call(File imagem) async {
    try {
      final storage = FirebaseStorage.instance;
      final ref = storage
          .ref()
          .child('livros')
          .child(UserController.user?.uid ?? '')
          .child(DateTime.now().toIso8601String());
      final uploadTask = ref.putFile(imagem);
      final downloadUrl = await uploadTask;
      final url = await downloadUrl.ref.getDownloadURL();
      return url;
    } catch (e) {
      dbPrint('Erro ao salvar imagem no storage $e');
      return '';
    }
  }
}
