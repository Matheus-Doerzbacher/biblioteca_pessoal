import 'package:cloud_firestore/cloud_firestore.dart';

class DeleteCategoriaRepository {
  Future<bool> call(String idCategoria) async {
    try {
      final firestore = FirebaseFirestore.instance;
      await firestore.collection('categorias').doc(idCategoria).delete();
      final livrosQuery = firestore
          .collection('livros')
          .where('categorias.id', isEqualTo: idCategoria);
      final livrosSnapshot = await livrosQuery.get();
      for (final doc in livrosSnapshot.docs) {
        await doc.reference.update(
          {
            'categorias': FieldValue.arrayRemove([idCategoria]),
          },
        );
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}
