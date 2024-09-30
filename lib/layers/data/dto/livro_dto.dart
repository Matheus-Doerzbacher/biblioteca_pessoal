import 'package:biblioteca_pessoal/layers/domain/entities/livro_entity.dart';
import 'package:biblioteca_pessoal/layers/presentation/controllers/user_controller.dart';

class LivroDto extends Livro {
  LivroDto({
    required super.uidUsuario,
    required super.autor,
    required super.titulo,
    required super.paginas,
    required super.ano,
    super.editora,
    super.urlImage,
    super.descricao,
    super.status,
    super.isPesquisa,
  });

  factory LivroDto.fromJson(Map<String, dynamic> json) {
    return LivroDto(
      uidUsuario: UserController.user?.uid ?? '',
      autor: json['authors'] != null ? json['authors'][0] : '',
      titulo: json['title'] ?? '',
      paginas: json['pageCount'] != null
          ? int.parse(json['pageCount'].toString())
          : 0,
      ano: json['publishedDate'] != null
          ? json['publishedDate'].toString().split('-')[0]
          : '0',
      editora: json['publisher'] ?? '',
      urlImage:
          json['imageLinks'] != null ? json['imageLinks']['thumbnail'] : '',
      descricao: json['description'] ?? '',
      isPesquisa: true,
    );
  }
}
