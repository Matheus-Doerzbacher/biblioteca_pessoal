import 'package:biblioteca_pessoal/modules/categoria/categoria_module.dart';
import 'package:biblioteca_pessoal/modules/emprestimo/emprestimo_module.dart';
import 'package:biblioteca_pessoal/modules/home/home_module.dart';
import 'package:biblioteca_pessoal/modules/livro/livro_module.dart';
import 'package:biblioteca_pessoal/modules/usuario/usuario_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    UsuarioModule().binds(i);
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r
      ..module('/', module: HomeModule())
      ..module('/livro', module: LivroModule())
      ..module('/login', module: UsuarioModule())
      ..module('/categoria', module: CategoriaModule())
      ..module('/emprestimo', module: EmprestimoModule());
    super.routes(r);
  }
}
