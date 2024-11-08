import 'dart:convert';

import 'package:biblioteca_pessoal/modules/livro/models/livro.dart';
import 'package:biblioteca_pessoal/modules/livro/models/livro_dto.dart';
import 'package:biblioteca_pessoal/modules/livro/repositories/get_livro_by_name_repository.dart';
import 'package:http/http.dart' as http;

class PesquisarLivroApiRepository {
  final GetLivroByNameRepository _getLivroByNameRepository;

  PesquisarLivroApiRepository(this._getLivroByNameRepository);
  Future<List<Livro>> call(String titulo) async {
    // try {
    final response = await http.get(
      Uri.parse(
        'https://www.googleapis.com/books/v1/volumes?q=[$titulo]&key=AIzaSyCU8yALKVrT1ojPrd3s0rA3EJVP612NE4Y&maxResults=30',
      ),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final livros = <Livro>[];

      if (data['items'] == null) {
        return [];
      }

      for (final item in data['items']) {
        final volumeInfo = item['volumeInfo'];
        final livro = LivroDto.fromJson(volumeInfo);
        final existeLivro = await _getLivroByNameRepository(livro.titulo);
        final livroComPesquisa =
            livro.copyWith(isPesquisa: existeLivro == null);
        livros.add(livroComPesquisa);
      }

      return livros;
    } else {
      throw Exception('Falha ao carregar livros');
    }
    // } catch (e) {
    //   return [];
    // }
  }
}
