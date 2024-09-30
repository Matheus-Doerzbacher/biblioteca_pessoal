import 'package:biblioteca_pessoal/core/inject/categoria_inject.dart';
import 'package:biblioteca_pessoal/core/inject/emprestimo_inject.dart';
import 'package:biblioteca_pessoal/core/inject/livro_inject.dart';
import 'package:biblioteca_pessoal/core/inject/pesquisa_livro_inject.dart';
import 'package:get_it/get_it.dart';

class Inject {
  static void init() {
    final getIt = GetIt.instance;

    livroInject(getIt);
    categoriaInject(getIt);
    emprestimoInject(getIt);
    pesquisaLivroInject(getIt);
  }
}
