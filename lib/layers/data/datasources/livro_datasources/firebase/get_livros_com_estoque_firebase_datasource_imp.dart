import 'package:biblioteca_pessoal/layers/data/datasources/livro_datasources/livro_datasource.dart';
import 'package:biblioteca_pessoal/layers/domain/entities/livro_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetLivrosComEstoqueFirebaseDatasourceImp
    implements GetLivrosComEstoqueDatasource {
  @override
  Future<List<Livro>> call(String uidUsuario) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final livroSnapShot = await firestore
          .collection('livros')
          .where('uidUsuario', isEqualTo: uidUsuario)
          .where('estoque', isGreaterThan: 0)
          .orderBy('titulo')
          .get();

      return livroSnapShot.docs.map((doc) {
        final data = doc.data();
        return Livro.fromJson(data);
      }).toList();
    } catch (error) {
      return [];
    }
  }
}
