import 'package:biblioteca_pessoal/layers/domain/entities/livro_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum StatusEmprestimo { emprestado, atrasado, devolvido }

class Emprestimo {
  final String? id;
  final String uidUsuario;
  final String idLivro;
  Livro? livro;
  final String destinatario;
  final DateTime dataEmprestimo;
  final DateTime? dataDevolucao;
  final int dias;
  StatusEmprestimo status;

  Emprestimo({
    this.id,
    required this.uidUsuario,
    required this.idLivro,
    this.livro,
    required this.destinatario,
    DateTime? dataEmprestimo,
    this.dataDevolucao,
    this.status = StatusEmprestimo.emprestado,
    required this.dias,
  }) : dataEmprestimo = dataEmprestimo ?? DateTime.now();

  factory Emprestimo.fromJson(Map<String, dynamic> json) {
    return Emprestimo(
      id: json['id'],
      uidUsuario: json['uidUsuario'],
      idLivro: json['idLivro'],
      livro: Livro.fromJson(json['livro']),
      destinatario: json['destinatario'],
      dataEmprestimo: (json['dataEmprestimo'] as Timestamp).toDate(),
      dataDevolucao: (json['dataDevolucao'] as Timestamp?)?.toDate(),
      dias: json['dias'],
      status: StatusEmprestimo.values.firstWhere(
        (e) => e.toString() == 'StatusEmprestimo.${json['status']}',
        orElse: () => StatusEmprestimo.emprestado,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uidUsuario': uidUsuario,
      'idLivro': idLivro,
      'livro': livro?.toJson(),
      'destinatario': destinatario,
      'dataEmprestimo': dataEmprestimo,
      'dataDevolucao': dataDevolucao,
      'dias': dias,
      'status': status.toString().split('.').last,
    };
  }

  bool get estaAtrasado {
    if (status == StatusEmprestimo.devolvido) return false;
    final prazo = dataEmprestimo.add(Duration(days: dias));
    return DateTime.now().isAfter(prazo);
  }

  void atualizarStatus() {
    if (dataDevolucao != null) {
      status = StatusEmprestimo.devolvido;
    } else if (estaAtrasado) {
      status = StatusEmprestimo.atrasado;
    } else {
      status = StatusEmprestimo.emprestado;
    }
  }
}
