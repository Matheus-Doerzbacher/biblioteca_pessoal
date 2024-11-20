import 'package:cloud_firestore/cloud_firestore.dart';

class DeleteCategoriaRepository {
  Future<bool> call(String idCategoria) async {
    try {
      final firestore = FirebaseFirestore.instance;
      await firestore.collection('categorias').doc(idCategoria).delete();

      final livrosQuery = firestore.collection('livros');
      final livrosSnapshot = await livrosQuery.get();

      for (final doc in livrosSnapshot.docs) {
        final categorias = doc['categorias'] as List<dynamic>;

        // Filtra as categorias para remover a que tem o idCategoria
        final categoriasAtualizadas = categorias.where((categoria) {
          return categoria['id'] != idCategoria;
        }).toList();

        // Atualiza o documento com a lista de categorias filtrada
        await doc.reference.update(
          {
            'categorias': categoriasAtualizadas,
          },
        );
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}
