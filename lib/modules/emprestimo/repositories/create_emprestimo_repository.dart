import 'package:biblioteca_pessoal/modules/emprestimo/models/emprestimo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateEmprestimoRepository {
  Future<bool> call(Emprestimo emprestimo) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final emprestimoRef =
          await firestore.collection('emprestimos').add(emprestimo.toJson());

      await emprestimoRef.update({'id': emprestimoRef.id});

      return true;
    } catch (e) {
      return false;
    }
  }
}
