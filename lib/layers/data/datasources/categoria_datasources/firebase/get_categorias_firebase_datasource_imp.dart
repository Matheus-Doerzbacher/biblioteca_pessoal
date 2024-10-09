import 'package:biblioteca_pessoal/layers/data/datasources/categoria_datasources/categoria_datasource.dart';
import 'package:biblioteca_pessoal/layers/domain/entities/categoria_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetCategoriasFirebaseDatasourceImp implements GetCategoriasDatasource {
  @override
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
