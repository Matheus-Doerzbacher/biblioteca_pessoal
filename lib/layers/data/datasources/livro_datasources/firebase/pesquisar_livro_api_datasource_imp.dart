import 'dart:convert';

import 'package:biblioteca_pessoal/layers/data/datasources/livro_datasources/firebase/get_livro_by_name_firebase_datasource_imp.dart';
import 'package:biblioteca_pessoal/layers/data/datasources/livro_datasources/livro_datasource.dart';
import 'package:biblioteca_pessoal/layers/data/dto/livro_dto.dart';
import 'package:biblioteca_pessoal/layers/domain/entities/livro.dart';
import 'package:http/http.dart' as http;

class PesquisarLivroApiDatasourceImp implements PesquisarLivroApiDatasource {
  @override
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
        final existeLivro =
            await GetLivroByNameFirebaseDatasourceImp().call(livro.titulo);
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
