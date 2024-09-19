import 'package:biblioteca_pessoal/layers/domain/entities/livro_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum StatusEmprestimo { emprestado, atrasado, devolvido }

class Emprestimo {
  final Livro livro;
  final String destinatario;
  final DateTime dataEmprestimo;
  final DateTime? dataDevolucao;
  final int dias;
  StatusEmprestimo status;

  factory Emprestimo.fromJson(Map<String, dynamic> json) {
    return Emprestimo(
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
      'livro': livro.toJson(),
      'destinatario': destinatario,
      'dataEmprestimo': dataEmprestimo,
      'dataDevolucao': dataDevolucao,
      'dias': dias,
      'status': status.toString().split('.').last,
    };
  }

  Emprestimo({
    required this.livro,
    required this.destinatario,
    DateTime? dataEmprestimo,
    this.dataDevolucao,
    this.status = StatusEmprestimo.emprestado,
    required this.dias,
  }) : dataEmprestimo = dataEmprestimo ?? DateTime.now();

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
