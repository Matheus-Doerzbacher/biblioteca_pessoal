import 'package:biblioteca_pessoal/modules/livro/models/livro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetLivrosComEstoqueRepository {
  Future<List<Livro>> call(String uidUsuario) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final livroSnapShot = await firestore
          .collection('livros')
          .where('uidUsuario', isEqualTo: uidUsuario)
          .where('estoque', isGreaterThan: 0)
          .orderBy('titulo')
          .get();

      return livroSnapShot.docs.map((doc) {
        final data = doc.data();
        return Livro.fromJson(data);
      }).toList();
    } catch (error) {
      return [];
    }
  }
}
