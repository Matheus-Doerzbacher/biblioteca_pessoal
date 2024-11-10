import 'package:biblioteca_pessoal/modules/home/home_module.dart';
import 'package:biblioteca_pessoal/modules/livro/livro_module.dart';
import 'package:biblioteca_pessoal/modules/usuario/usuario_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  void routes(RouteManager r) {
    r
      ..module('/', module: HomeModule())
      ..module('/livro', module: LivroModule())
      ..module('/login', module: UsuarioModule());
    super.routes(r);
  }
}
