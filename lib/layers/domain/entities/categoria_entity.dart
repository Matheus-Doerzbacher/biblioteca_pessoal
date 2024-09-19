class Categoria {
  final String nome;
  final String? id;

  const Categoria({required this.nome, this.id});

  factory Categoria.fromJson(Map<String, dynamic> json) {
    return Categoria(
      nome: json['nome'] as String,
      id: json['id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'id': id,
    };
  }
}
