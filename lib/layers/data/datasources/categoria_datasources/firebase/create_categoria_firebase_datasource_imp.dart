import 'package:biblioteca_pessoal/layers/data/datasources/categoria_datasources/categoria_datasource.dart';
import 'package:biblioteca_pessoal/layers/domain/entities/categoria.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateCategoriaFirebaseDatasourceImp
    implements CreateCategoriaDatasource {
  @override
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
