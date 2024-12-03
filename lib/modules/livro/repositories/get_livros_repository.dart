import 'package:biblioteca_pessoal/core/utils/db_print.dart';
import 'package:biblioteca_pessoal/modules/livro/models/livro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetLivrosRepository {
  Future<List<Livro>> call(String uidUsuario) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final querySnapshot = await firestore
          .collection('livros')
          .where('uidUsuario', isEqualTo: uidUsuario)
          .orderBy('titulo')
          .get();

      final livros = querySnapshot.docs.map((doc) {
        final data = doc.data();
        return Livro.fromJson(data);
      }).toList();

      return livros;
    } catch (e) {
      dbPrint(e);
      return [];
    }
  }
}
