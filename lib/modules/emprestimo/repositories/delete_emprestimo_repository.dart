import 'package:cloud_firestore/cloud_firestore.dart';

class DeleteEmprestimoRepository {
  Future<bool> call(String idEmprestimo) async {
    final firestore = FirebaseFirestore.instance;
    final emprestimoRef = firestore.collection('emprestimos').doc(idEmprestimo);

    try {
      await emprestimoRef.delete();
      return true;
    } catch (e) {
      return false;
    }
  }
}
