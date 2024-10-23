class AppRoutes {
  static final livro = AdicionarLivro();
  static final emprestimo = Emprestimo();

  static const String home = '/';
  static const String login = '/login';
  static const String categoria = '/categoria';
}

class AdicionarLivro {
  final String adicionar = '/adicionar';
  final String adicionarManual = '/adicionarManual';
  final String livroDetail = '/livroDetail';
}

class Emprestimo {
  final String base = '/emprestimo';
  final String novo = '/novoEmprestimo';
}
