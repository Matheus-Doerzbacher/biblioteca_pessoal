import 'package:biblioteca_pessoal/layers/data/datasources/livro_datasources/livro_datasource.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DeleteLivroFirebaseDatasourceImp implements DeleteLivroDatasource {
  @override
  Future<bool> call(String id) async {
    try {
      await FirebaseFirestore.instance.collection('livros').doc(id).delete();
      return true;
    } catch (e) {
      return false;
    }
  }
}
