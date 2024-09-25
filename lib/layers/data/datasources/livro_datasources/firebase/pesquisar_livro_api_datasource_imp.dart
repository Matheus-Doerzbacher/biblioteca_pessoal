import 'dart:convert';

import 'package:biblioteca_pessoal/layers/data/datasources/livro_datasources/livro_datasource.dart';
import 'package:biblioteca_pessoal/layers/data/dto/livro_dto.dart';
import 'package:biblioteca_pessoal/layers/domain/entities/livro_entity.dart';
import 'package:http/http.dart' as http;

class PesquisarLivroApiDatasourceImp implements PesquisarLivroApiDatasource {
  @override
  Future<List<Livro>> call(String titulo) async {
    final response = await http.get(
      Uri.parse(
        'https://www.googleapis.com/books/v1/volumes?q=[$titulo]&key=AIzaSyCU8yALKVrT1ojPrd3s0rA3EJVP612NE4Y',
      ),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<Livro> livros = [];

      for (var item in data['items']) {
        final volumeInfo = item['volumeInfo'];
        final livro = LivroDto.fromJson(volumeInfo);
        livros.add(livro);
      }

      return livros;
    } else {
      throw Exception('Falha ao carregar livros');
    }
  }
}
