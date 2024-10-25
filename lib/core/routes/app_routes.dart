class AppRoutes {
  static final livro = AdicionarLivro();
  static final emprestimo = EmprestimoRouter();

  static const String home = '/';
  static const String login = '/login';
  static const String categoria = '/categoria';
}

class AdicionarLivro {
  final String adicionar = '/adicionar';
  final String adicionarManual = '/adicionarManual';
  final String livroDetail = '/livroDetail';
}

class EmprestimoRouter {
  final String base = '/emprestimo';
  final String novo = '/novoEmprestimo';
}
