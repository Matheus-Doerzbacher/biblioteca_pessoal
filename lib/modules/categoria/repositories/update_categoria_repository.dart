import 'package:biblioteca_pessoal/modules/categoria/models/categoria.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateCategoriaRepository {
  Future<bool> call(Categoria categoria) async {
    try {
      final firestore = FirebaseFirestore.instance;
      await firestore.collection('categorias').doc(categoria.id).update({
        'nome': categoria.nome,
      });
      return true;
    } catch (e) {
      return false;
    }
  }
}
