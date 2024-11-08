import 'package:cloud_firestore/cloud_firestore.dart';

class DeleteLivroRepository {
  Future<bool> call(String id) async {
    try {
      await FirebaseFirestore.instance.collection('livros').doc(id).delete();
      return true;
    } catch (e) {
      return false;
    }
  }
}
