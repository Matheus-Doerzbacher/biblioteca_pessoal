import 'package:biblioteca_pessoal/layers/data/datasources/livro_datasources/livro_datasource.dart';
import 'package:biblioteca_pessoal/layers/domain/entities/livro_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateLivroFirebaseDatasourceImp implements UpdateLivroDatasource {
  @override
  Future<bool> call(Livro livro) async {
    try {
      await FirebaseFirestore.instance
          .collection('livros')
          .doc(livro.id)
          .update(livro.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }
}
