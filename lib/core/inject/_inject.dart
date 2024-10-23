import 'package:biblioteca_pessoal/core/inject/controllers_inject.dart';
import 'package:biblioteca_pessoal/core/inject/datasources_inject.dart';
import 'package:biblioteca_pessoal/core/inject/repositories_inject.dart';
import 'package:biblioteca_pessoal/core/inject/usecases_inject.dart';
import 'package:get_it/get_it.dart';

class Inject {
  static void init() {
    final getIt = GetIt.instance;

    datasourcesInject(getIt);
    repositoriesInject(getIt);
    usecasesInject(getIt);
    controllersInject(getIt);
  }
}
