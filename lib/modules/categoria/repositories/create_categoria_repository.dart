import 'package:biblioteca_pessoal/modules/categoria/models/categoria.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateCategoriaRepository {
  Future<bool> call(Categoria categoria) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final docRef =
          await firestore.collection('categorias').add(categoria.toJson());
      await docRef.update({'id': docRef.id});
      return true;
    } catch (e) {
      return false;
    }
  }
}
