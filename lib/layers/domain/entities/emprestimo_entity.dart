import 'package:biblioteca_pessoal/layers/domain/entities/livro_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Emprestimo {
  final String? id;
  final String uidUsuario;
  final String idLivro;
  final int quantidade;
  Livro? livro;
  final String destinatario;
  final DateTime dataEmprestimo;
  final DateTime? dataDevolucao;
  bool foiDevolvido;

  Emprestimo({
    this.id,
    required this.uidUsuario,
    required this.idLivro,
    required this.quantidade,
    this.livro,
    required this.destinatario,
    DateTime? dataEmprestimo,
    this.dataDevolucao,
    this.foiDevolvido = false,
  }) : dataEmprestimo = dataEmprestimo ?? DateTime.now();

  factory Emprestimo.fromJson(Map<String, dynamic> json) {
    return Emprestimo(
      id: json['id'],
      uidUsuario: json['uidUsuario'],
      idLivro: json['idLivro'],
      quantidade: json['quantidade'],
      livro: json['livro'] != null ? Livro.fromJson(json['livro']) : null,
      destinatario: json['destinatario'],
      dataEmprestimo: (json['dataEmprestimo'] as Timestamp).toDate(),
      dataDevolucao: (json['dataDevolucao'] as Timestamp?)?.toDate(),
      foiDevolvido: json['foiDevolvido'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uidUsuario': uidUsuario,
      'idLivro': idLivro,
      'quantidade': quantidade,
      'livro': livro?.toJson(),
      'destinatario': destinatario,
      'dataEmprestimo': dataEmprestimo,
      'dataDevolucao': dataDevolucao,
      'foiDevolvido': foiDevolvido,
    };
  }

  void fazerDevolucao() {
    foiDevolvido = !foiDevolvido;
    livro = null;
  }
}
