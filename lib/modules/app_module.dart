import 'package:biblioteca_pessoal/modules/categoria/categoria_module.dart';
import 'package:biblioteca_pessoal/modules/emprestimo/emprestimo_module.dart';
import 'package:biblioteca_pessoal/modules/livro/livro_module.dart';
import 'package:biblioteca_pessoal/modules/usuario/controllers/user_controller.dart';
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
      ..module(
        Modular.initialRoute,
        module: LivroModule(),
        guards: [AuthGuard()],
      )
      ..module('/login', module: UsuarioModule())
      ..module('/categoria', module: CategoriaModule())
      ..module('/emprestimo', module: EmprestimoModule());
    super.routes(r);
  }
}

class AuthGuard extends RouteGuard {
  AuthGuard() : super(redirectTo: '/login/');

  @override
  Future<bool> canActivate(String path, ModularRoute route) async {
    // final controller = Modular.get<UserController>();

    if (UserController.user == null) {
      return false;
    }

    return true;
  }
}
