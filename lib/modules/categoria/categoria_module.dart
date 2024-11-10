import 'package:biblioteca_pessoal/modules/categoria/controllers/categoria_controller.dart';
import 'package:biblioteca_pessoal/modules/categoria/repositories/create_categoria_repository.dart';
import 'package:biblioteca_pessoal/modules/categoria/repositories/delete_categoria_repository.dart';
import 'package:biblioteca_pessoal/modules/categoria/repositories/get_categorias_repository.dart';
import 'package:biblioteca_pessoal/modules/categoria/repositories/update_categoria_repository.dart';
import 'package:biblioteca_pessoal/modules/categoria/views/categoria_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CategoriaModule extends Module {
  @override
  void binds(Injector i) {
    i
      ..add<CreateCategoriaRepository>(CreateCategoriaRepository.new)
      ..add<DeleteCategoriaRepository>(DeleteCategoriaRepository.new)
      ..add<GetCategoriasRepository>(GetCategoriasRepository.new)
      ..add<UpdateCategoriaRepository>(UpdateCategoriaRepository.new)

      // CONTROLLERS
      ..addLazySingleton<CategoriaController>(
        () => CategoriaController(i(), i(), i(), i()),
      );
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child(Modular.initialRoute, child: (_) => const CategoriaPage());
    super.routes(r);
  }
}
