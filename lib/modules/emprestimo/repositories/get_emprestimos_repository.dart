import 'package:biblioteca_pessoal/core/utils/db_print.dart';
import 'package:biblioteca_pessoal/modules/emprestimo/models/emprestimo.dart';
import 'package:biblioteca_pessoal/modules/livro/models/livro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetEmprestimosRepository {
  Future<List<Emprestimo>> call(String uidUsuario) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final emprestimosRef = firestore.collection('emprestimos');
      final livrosRef = firestore.collection('livros');

      // Consulta inicial para buscar os empréstimos do usuário
      final snapshot = await emprestimosRef
          .where('uidUsuario', isEqualTo: uidUsuario)
          .orderBy('dataEmprestimo')
          .get();

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
              final emprestimo = Emprestimo.fromJson(data);
              // ignore: cascade_invocations
              emprestimo.livro = Livro.fromJson(livroData);

              return emprestimo;
            } else {
              throw Exception('Livro com id $idLivro não encontrado');
            }
          }).toList(),
        );
      } else {
        return [];
      }
    } catch (e) {
      dbPrint(e);
      throw Exception('Hove um erro ao buscar os emprestimos');
    }
  }
}
