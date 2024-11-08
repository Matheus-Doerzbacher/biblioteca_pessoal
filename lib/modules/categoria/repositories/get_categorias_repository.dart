import 'package:biblioteca_pessoal/modules/categoria/models/categoria.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetCategoriasRepository {
  Future<List<Categoria>> call(String uidUsuario) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final querySnapshot = await firestore
          .collection('categorias')
          .where('uidUsuario', isEqualTo: uidUsuario)
          .get(
            const GetOptions(
              source: Source.server,
            ),
          ); // Força a busca no servidor

      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        return Categoria.fromJson({...data, 'id': doc.id});
      }).toList();
    } catch (e) {
      return [];
    }
  }
}
