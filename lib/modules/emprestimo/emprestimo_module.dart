import 'package:biblioteca_pessoal/modules/emprestimo/controllers/emprestimo_controller.dart';
import 'package:biblioteca_pessoal/modules/emprestimo/repositories/create_emprestimo_repository.dart';
import 'package:biblioteca_pessoal/modules/emprestimo/repositories/delete_emprestimo_repository.dart';
import 'package:biblioteca_pessoal/modules/emprestimo/repositories/get_emprestimos_by_id_repository.dart';
import 'package:biblioteca_pessoal/modules/emprestimo/repositories/get_emprestimos_repository.dart';
import 'package:biblioteca_pessoal/modules/emprestimo/repositories/update_emprestimo_repository.dart';
import 'package:biblioteca_pessoal/modules/emprestimo/views/emprestimo_page.dart';
import 'package:biblioteca_pessoal/modules/emprestimo/views/novo_emprestimo_page.dart';
import 'package:biblioteca_pessoal/modules/livro/livro_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class EmprestimoModule extends Module {
  @override
  List<Module> get imports => [
        LivroModule(),
      ];

  @override
  void binds(Injector i) {
    i
      ..add<CreateEmprestimoRepository>(CreateEmprestimoRepository.new)
      ..add<DeleteEmprestimoRepository>(DeleteEmprestimoRepository.new)
      ..add<GetEmprestimosByIdRepository>(GetEmprestimosByIdRepository.new)
      ..add<GetEmprestimosRepository>(GetEmprestimosRepository.new)
      ..add<UpdateEmprestimoRepository>(UpdateEmprestimoRepository.new)

      // CONTROLLERS
      ..addLazySingleton<EmprestimoController>(
        () => EmprestimoController(
          i(),
          i(),
          i(),
          i(),
          i(),
          i(),
          i(),
        ),
      );
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r
      ..child(Modular.initialRoute, child: (_) => const EmprestimosPage())
      ..child('/novo', child: (_) => const NovoEmprestimoPage());
    super.routes(r);
  }
}
