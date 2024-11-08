import 'package:biblioteca_pessoal/modules/livro/models/livro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetLivroByNameRepository {
  Future<Livro?> call(String titulo) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('livros')
          .where('titulo', isEqualTo: titulo)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final data = querySnapshot.docs.first.data();
        return Livro.fromJson(data);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Erro ao buscar livro: $e');
    }
  }
}
