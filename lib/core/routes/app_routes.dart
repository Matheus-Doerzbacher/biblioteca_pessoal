class AppRoutes {
  static final livro = AdicionarLivro();
  static final emprestimo = EmprestimoRouter();

  static const String login = '/login';
  static const String categoria = '/categoria/';
}

class AdicionarLivro {
  final String _base = '';
  String home() => '$_base/';
  String adicionar() => '$_base/adicionar';
  String detail() => '$_base/detail';
  String pesquisa() => '$_base/pesquisa';
}

class EmprestimoRouter {
  final String _base = '/emprestimo';
  String base() => _base;
  String novo() => '$_base/novo';
}
