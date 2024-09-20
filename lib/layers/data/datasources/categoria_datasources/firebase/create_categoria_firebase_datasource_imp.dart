import 'package:biblioteca_pessoal/layers/data/datasources/categoria_datasources/categoria_datasource.dart';
import 'package:biblioteca_pessoal/layers/domain/entities/categoria_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateCategoriaFirebaseDatasourceImp
    implements CreateCategoriaDatasource {
  @override
  Future<bool> call(Categoria categoria) async {
    try {
      final firestore = FirebaseFirestore.instance;
      await firestore.collection('categorias').add(categoria.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }
}
