import 'package:biblioteca_pessoal/modules/usuario/controllers/user_controller.dart';
import 'package:biblioteca_pessoal/modules/usuario/repositories/login_with_google.dart';
import 'package:biblioteca_pessoal/modules/usuario/repositories/sign_out.dart';
import 'package:biblioteca_pessoal/modules/usuario/views/login_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class UsuarioModule extends Module {
  @override
  void binds(Injector i) {
    i
      ..add<LoginWithGoogle>(LoginWithGoogle.new)
      ..add<SignOut>(SignOut.new)

      //  CONTROLLERS
      ..addLazySingleton<UserController>(
        () => UserController(i(), i()),
      );
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child(Modular.initialRoute, child: (context) => const LoginPage());
    super.routes(r);
  }
}
