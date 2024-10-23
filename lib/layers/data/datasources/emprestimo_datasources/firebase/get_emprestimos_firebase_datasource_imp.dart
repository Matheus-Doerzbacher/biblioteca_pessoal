import 'package:biblioteca_pessoal/layers/data/datasources/emprestimo_datasources/emprestimo_datasource.dart';
import 'package:biblioteca_pessoal/layers/domain/entities/emprestimo_entity.dart';
import 'package:biblioteca_pessoal/layers/domain/entities/livro_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetEmprestimosFirebaseDatasourceImp implements GetEmprestimosDatasource {
  @override
  Future<List<Emprestimo>> call(String uidUsuario) async {
    final firestore = FirebaseFirestore.instance;
    final emprestimosRef = firestore.collection('emprestimos');
    final livrosRef = firestore.collection('livros');

    // Consulta inicial para buscar os empréstimos do usuário
    final snapshot =
        await emprestimosRef.where('uidUsuario', isEqualTo: uidUsuario).get();

    if (snapshot.docs.isNotEmpty) {
      // Mapear os empréstimos e buscar os dados do livro para cada um
      return Future.wait(
        snapshot.docs.map((doc) async {
          final data = doc.data();

          final idLivro = data['idLivro'];
          // Consulta ao documento do livro usando o idLivro
          final livroSnapshot = await livrosRef.doc(idLivro).get();

          if (livroSnapshot.exists) {
            // Adicionando os dados do livro ao objeto Emprestimo
            final livroData = livroSnapshot.data()!;
            final emprestimo = Emprestimo.fromJson(data)
              ..livro = Livro.fromJson(livroData);

            return emprestimo;
          } else {
            throw Exception('Livro com id $idLivro não encontrado');
          }
        }).toList(),
      );
    } else {
      return [];
    }
  }
}
