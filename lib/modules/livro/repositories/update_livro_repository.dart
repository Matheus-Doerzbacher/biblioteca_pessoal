import 'package:biblioteca_pessoal/core/utils/db_print.dart';
import 'package:biblioteca_pessoal/modules/livro/models/livro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateLivroRepository {
  Future<bool> call(Livro livro) async {
    try {
      await FirebaseFirestore.instance
          .collection('livros')
          .doc(livro.id)
          .update(livro.toJson());
      return true;
    } catch (e) {
      dbPrint(e);
      return false;
    }
  }
}
