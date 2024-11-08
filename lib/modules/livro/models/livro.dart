import 'package:biblioteca_pessoal/modules/categoria/models/categoria.dart';

enum StatusLeitura {
  lendo,
  lido,
  queroLer,
}

class Livro {
  String? id;
  final String uidUsuario;
  final String autor;
  final String titulo;
  final int paginas;
  int estoque;
  final int avaliacao;
  final String editora;
  final String ano;
  final List<Categoria> categorias;
  final String descricao;
  final StatusLeitura status;
  final String urlImage;
  final bool isPesquisa;
  bool isFavorito;

  Livro({
    this.id,
    required this.uidUsuario,
    required this.autor,
    required this.titulo,
    required this.paginas,
    this.estoque = 0,
    this.avaliacao = 0,
    this.editora = '',
    required this.ano,
    this.categorias = const [],
    this.descricao = '',
    this.status = StatusLeitura.queroLer,
    this.urlImage = '',
    this.isPesquisa = false,
    this.isFavorito = false,
  });

  String get statusName {
    if (status == StatusLeitura.lendo) {
      return 'Lendo';
    } else if (status == StatusLeitura.lido) {
      return 'Lido';
    } else {
      return 'Quero ler';
    }
  }

  void emprestimo(int quantidade) {
    estoque -= quantidade;
  }

  void devolverEmprestimo(int quantidade) {
    estoque += quantidade;
  }

  void atualizarIsFavorito() {
    isFavorito = !isFavorito;
  }

  factory Livro.fromJson(Map<String, dynamic> json) {
    return Livro(
      id: json['id'],
      uidUsuario: json['uidUsuario'],
      autor: json['autor'],
      titulo: json['titulo'],
      paginas: json['paginas'],
      estoque: json['estoque'] ?? 0,
      avaliacao: json['avaliacao'] ?? 0,
      editora: json['editora'] ?? '',
      ano: json['ano'],
      isPesquisa: json['isPesquisa'] ?? false,
      isFavorito: json['isFavorito'] ?? false,
      categorias: (json['categorias'] as List<dynamic>?)
              ?.map((e) => Categoria.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      descricao: json['descricao'] ?? '',
      status: StatusLeitura.values.firstWhere(
        (e) => e.toString() == 'StatusLeitura.${json['status']}',
        orElse: () => StatusLeitura.queroLer,
      ),
      urlImage: json['urlImage'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uidUsuario': uidUsuario,
      'autor': autor,
      'titulo': titulo,
      'paginas': paginas,
      'estoque': estoque,
      'avaliacao': avaliacao,
      'editora': editora,
      'ano': ano,
      'categorias': categorias.map((e) => e.toJson()).toList(),
      'descricao': descricao,
      'status': status.name,
      'urlImage': urlImage,
      'isPesquisa': false,
      'isFavorito': isFavorito,
    };
  }
}
