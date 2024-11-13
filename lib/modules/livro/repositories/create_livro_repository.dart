import 'package:biblioteca_pessoal/modules/livro/models/livro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class CreateLivroRepository {
  Future<Livro?> call(Livro livro) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final livroJson = livro.toJson();

      final docRef = await firestore.collection('livros').add(livroJson);

      await docRef.update({'id': docRef.id});
      final snapshot = await docRef.get();
      final json = snapshot.data()!;
      return Livro.fromJson(json);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }
}
