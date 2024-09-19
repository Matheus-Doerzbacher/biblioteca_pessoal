import 'package:biblioteca_pessoal/layers/data/datasources/emprestimo_datasources/emprestimo_datasource.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DeleteEmprestimoFirebaseDatasourceImp
    implements DeleteEmprestimoDatasource {
  @override
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
