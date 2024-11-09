import 'package:biblioteca_pessoal/modules/home/controllers/home_controller.dart';
import 'package:biblioteca_pessoal/modules/home/views/home_page.dart';
import 'package:biblioteca_pessoal/modules/livro/livro_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  @override
  List<Module> get imports => [
        LivroModule(),
      ];

  @override
  void binds(Injector i) {
    i.addLazySingleton<HomeController>(() => HomeController(i(), i()));
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      Modular.initialRoute,
      child: (context) => const HomePage(),
    );
    super.routes(r);
  }
}
