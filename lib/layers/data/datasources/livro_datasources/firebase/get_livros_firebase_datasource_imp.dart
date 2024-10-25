import 'package:biblioteca_pessoal/layers/data/datasources/livro_datasources/livro_datasource.dart';
import 'package:biblioteca_pessoal/layers/domain/entities/livro_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class GetLivrosFirebaseDatasourceImp implements GetLivrosDatasource {
  @override
  Future<List<Livro>> call(String uidUsuario) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final querySnapshot = await firestore
          .collection('livros')
          .where('uidUsuario', isEqualTo: uidUsuario)
          .orderBy('titulo')
          .get();

      final livros = querySnapshot.docs.map((doc) {
        final data = doc.data();
        return Livro.fromJson(data);
      }).toList();

      return livros;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return [];
    }
  }
}
