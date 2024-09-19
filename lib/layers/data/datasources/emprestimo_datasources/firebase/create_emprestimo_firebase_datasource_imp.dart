import 'package:biblioteca_pessoal/layers/data/datasources/emprestimo_datasources/emprestimo_datasource.dart';
import 'package:biblioteca_pessoal/layers/domain/entities/emprestimo_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateEmprestimoFirebaseDatasourceImp
    implements CreateEmprestimoDatasource {
  @override
  Future<bool> call(Emprestimo emprestimo) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final emprestimoRef = firestore.collection('emprestimos').doc();

      await emprestimoRef.set(emprestimo.toJson());

      return true;
    } catch (e) {
      return false;
    }
  }
}
