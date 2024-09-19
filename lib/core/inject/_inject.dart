import 'package:get_it/get_it.dart';
import 'package:biblioteca_pessoal/core/inject/categoria_inject.dart';
import 'package:biblioteca_pessoal/core/inject/emprestimo_inject.dart';
import 'package:biblioteca_pessoal/core/inject/livro_inject.dart';

class Inject {
  static void init() {
    GetIt getIt = GetIt.instance;

    livroInject(getIt);
    categoriaInject(getIt);
    emprestimoInject(getIt);
  }
}
