import 'dart:io';

import 'package:biblioteca_pessoal/layers/data/datasources/livro_datasources/livro_datasource.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class SalvarImagemLivroFirabaseDatasourceImp
    implements SalvarImagemLivroDatasource {
  @override
  Future<String> call(File imagem) async {
    try {
      final storage = FirebaseStorage.instance;
      final Reference ref = storage.ref().child("livros");
      final UploadTask uploadTask = ref.putFile(imagem);
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
