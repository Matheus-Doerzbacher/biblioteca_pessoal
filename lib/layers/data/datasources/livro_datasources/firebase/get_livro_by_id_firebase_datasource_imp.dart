import 'package:biblioteca_pessoal/layers/data/datasources/livro_datasources/livro_datasource.dart';
import 'package:biblioteca_pessoal/layers/domain/entities/livro_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetLivroByIdFirebaseDatasourceImp implements GetLivroByIdDatasource {
  @override
  Future<Livro> call(String idLivro) async {
    try {
      final docRef =
          FirebaseFirestore.instance.collection('livros').doc(idLivro);
      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data()!;
        return Livro.fromJson(data);
      } else {
        throw Exception('Livro não encontrado');
      }
    } catch (e) {
      throw Exception('Erro ao buscar livro: $e');
    }
  }
}
