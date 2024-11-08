import 'package:biblioteca_pessoal/modules/categoria/models/categoria.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetCategoriasRepository {
  Future<List<Categoria>> call(String uidUsuario) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final querySnapshot = await firestore
          .collection('categorias')
          .where('uidUsuario', isEqualTo: uidUsuario)
          .get(); // Força a busca no servidor

      final categorias = querySnapshot.docs.map((doc) {
        final data = doc.data();
        final teste = Categoria.fromJson({...data, 'id': doc.id});
        return teste;
      }).toList();

      return categorias;
    } catch (e) {
      return [];
    }
  }
}
