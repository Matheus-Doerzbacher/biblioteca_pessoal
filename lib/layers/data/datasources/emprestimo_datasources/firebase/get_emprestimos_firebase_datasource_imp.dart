import 'package:biblioteca_pessoal/layers/data/datasources/emprestimo_datasources/emprestimo_datasource.dart';
import 'package:biblioteca_pessoal/layers/domain/entities/emprestimo_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetEmprestimosFirebaseDatasourceImp implements GetEmprestimosDatasource {
  @override
  Future<List<Emprestimo>> call(String uidUsuario) async {
    final firestore = FirebaseFirestore.instance;
    final emprestimosRef = firestore.collection('emprestimos');

    final snapshot =
        await emprestimosRef.where('uidUsuario', isEqualTo: uidUsuario).get();

    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Emprestimo.fromJson(data);
      }).toList();
    } else {
      return [];
    }
  }
}
