import 'package:biblioteca_pessoal/layers/data/datasources/categoria_datasources/categoria_datasource.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DeleteCategoriaFirebaseDatasourceImp
    implements DeleteCategoriaDatasource {
  @override
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
