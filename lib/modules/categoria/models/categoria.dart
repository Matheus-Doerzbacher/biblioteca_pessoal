class Categoria {
  final String? id;
  final String uidUsuario;
  final String nome;

  const Categoria({required this.nome, required this.uidUsuario, this.id});

  factory Categoria.fromJson(Map<String, dynamic> json) {
    return Categoria(
      uidUsuario: json['uidUsuario'] as String,
      nome: json['nome'] as String,
      id: json['id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uidUsuario': uidUsuario,
      'nome': nome,
    };
  }
}
