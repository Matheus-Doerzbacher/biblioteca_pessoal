import 'package:biblioteca_pessoal/modules/emprestimo/models/emprestimo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateEmprestimoRepository {
  Future<bool> call(Emprestimo emprestimo) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final emprestimoRef =
          firestore.collection('emprestimos').doc(emprestimo.id);

      await emprestimoRef.update(emprestimo.toJson());

      return true;
    } catch (e) {
      return false;
    }
  }
}
