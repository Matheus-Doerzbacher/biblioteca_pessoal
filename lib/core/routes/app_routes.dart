class AppRoutes {
  static final livro = AdicionarLivro();

  static const String home = '/';
  static const String login = '/login';
  static const String categoria = '/categoria';
  static const String emprestimo = '/emprestimo';
}

class AdicionarLivro {
  final String adicionar = '/adicionar';
  final String adicionarManual = '/adicionarManual';
  final String livroDetail = '/livroDetail';
}
