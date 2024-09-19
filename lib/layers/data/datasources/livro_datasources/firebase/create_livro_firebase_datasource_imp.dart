import 'package:biblioteca_pessoal/layers/data/datasources/livro_datasources/livro_datasource.dart';
import 'package:biblioteca_pessoal/layers/domain/entities/livro_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateLivroFirebaseDatasourceImp implements CreateLivroDatasource {
  @override
  Future<bool> call(Livro livro) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final livroJson = livro.toJson();

      await firestore.collection('livros').add(livroJson);

      return true;
    } catch (e) {
      return false;
    }
  }
}
