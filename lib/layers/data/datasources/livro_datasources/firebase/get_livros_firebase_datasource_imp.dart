import 'package:biblioteca_pessoal/layers/data/datasources/livro_datasources/livro_datasource.dart';
import 'package:biblioteca_pessoal/layers/domain/entities/livro_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetLivrosFirebaseDatasourceImp implements GetLivrosDatasource {
  @override
  Future<List<Livro>> call(String uidUsuario) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final querySnapshot = await firestore
          .collection('livros')
          .where('uidUsuario', isEqualTo: uidUsuario)
          .get();

      final livros = querySnapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return Livro.fromJson(data);
      }).toList();

      return livros;
    } catch (e) {
      return [];
    }
  }
}
