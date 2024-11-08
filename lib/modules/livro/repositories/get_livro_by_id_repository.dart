import 'package:biblioteca_pessoal/modules/livro/models/livro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetLivroByIdRepository {
  Future<Livro> call(String idLivro) async {
    try {
      final docRef =
          FirebaseFirestore.instance.collection('livros').doc(idLivro);
      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data()!;
        return Livro.fromJson(data);
      } else {
        throw Exception('Livro não encontrado');
      }
    } catch (e) {
      throw Exception('Erro ao buscar livro: $e');
    }
  }
}
