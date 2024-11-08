import 'package:cloud_firestore/cloud_firestore.dart';

class DeleteCategoriaRepository {
  Future<bool> call(String idCategoria) async {
    try {
      final firestore = FirebaseFirestore.instance;
      await firestore.collection('categorias').doc(idCategoria).delete();
      return true;
    } catch (e) {
      return false;
    }
  }
}
