import 'package:biblioteca_pessoal/modules/emprestimo/models/emprestimo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetEmprestimosByIdRepository {
  Future<Emprestimo> call(String idEmprestimo) async {
    final firestore = FirebaseFirestore.instance;
    final emprestimoRef = firestore.collection('emprestimos').doc(idEmprestimo);

    final snapshot = await emprestimoRef.get();

    if (snapshot.exists) {
      final data = snapshot.data()!;
      return Emprestimo.fromJson(data);
    } else {
      throw Exception('Empréstimo não encontrado');
    }
  }
}
