import 'package:biblioteca_pessoal/core/routes/app_routes.dart';
import 'package:biblioteca_pessoal/layers/domain/entities/emprestimo_entity.dart';
import 'package:biblioteca_pessoal/layers/presentation/controllers/emprestimo_controller.dart';
import 'package:biblioteca_pessoal/layers/presentation/ui/pages/emprestimos/components/emprestimo_item_component.dart';
import 'package:biblioteca_pessoal/layers/presentation/widgets/drawer_custom/drawer_custom.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class EmprestimosPage extends StatefulWidget {
  const EmprestimosPage({super.key});

  @override
  State<EmprestimosPage> createState() => _EmprestimosPageState();
}

class _EmprestimosPageState extends State<EmprestimosPage> {
  final controller = GetIt.I<EmprestimoController>();

  @override
  void initState() {
    controller.getEmprestimos().then((_) {
      if (mounted) setState(() {});
    });
    super.initState();
  }

  Future<void> fazerDevolucao(Emprestimo emprestimo) async {
    await controller.updateEmprestimo(emprestimo);
    setState(() {});
  }

  void excluirDevolucao(Emprestimo emprestimo) {
    if (kDebugMode) {
      print(
        'excluio emprestimo com o livro: ${emprestimo.livro?.titulo ?? ''}',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final emprestimos = controller.emprestimos;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Emprestimos'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(
                text: 'Todos',
              ),
              Tab(
                text: 'Atrassados',
              ),
              Tab(
                text: 'Sem prazo',
              ),
              Tab(
                text: 'Entregues',
              ),
            ],
          ),
          actions: [
            TextButton.icon(
              onPressed: () async {
                final result = await Navigator.of(context).pushNamed(
                  AppRoutes.emprestimo.novo,
                );

                // Após retornar, atualiza os dados da página
                if (result != null) {
                  await controller.getEmprestimos();
                  setState(() {});
                }
              },
              label: const Text('Novo'),
              icon: const Icon(Icons.add),
              iconAlignment: IconAlignment.end,
            ),
          ],
        ),
        drawer: DrawerCustom(namePageActive: AppRoutes.emprestimo.base),
        body: TabBarView(
          children: [
            _listTodos(context, emprestimos),
            _listAtrasados(context, emprestimos),
            _listSemPrazo(context, emprestimos),
            _listDevolvidos(context, emprestimos),
          ],
        ),
      ),
    );
  }

  Widget _listTodos(BuildContext context, List<Emprestimo> emprestimos) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: emprestimos.length,
        itemBuilder: (context, index) {
          final emprestimo = emprestimos[index];

          return EmprestimoItemComponents(
            emprestimo: emprestimo,
            excluirDevolucao: () => excluirDevolucao(emprestimo),
            fazerDevolucao: () => fazerDevolucao(emprestimo),
          );
        },
      ),
    );
  }

  Widget _listAtrasados(BuildContext context, List<Emprestimo> emprestimos) {
    final agora = DateTime.now();
    final hoje = DateTime.parse('${agora.year}-${agora.month}-${agora.day}');
    final atrasados = emprestimos.where((emprestimo) {
      if (emprestimo.dataDevolucao != null) {
        final result = emprestimo.dataDevolucao!.compareTo(hoje);
        if (result < 0 && emprestimo.foiDevolvido == false) {
          return true;
        }
      }
      return false;
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: atrasados.length,
        itemBuilder: (context, index) {
          final emprestimo = atrasados[index];
          return EmprestimoItemComponents(
            emprestimo: emprestimo,
            excluirDevolucao: () => excluirDevolucao(emprestimo),
            fazerDevolucao: () => fazerDevolucao(emprestimo),
          );
        },
      ),
    );
  }

  Widget _listSemPrazo(BuildContext context, List<Emprestimo> emprestimos) {
    final semPrazo = emprestimos.where((emprestimo) {
      return emprestimo.dataDevolucao == null &&
          emprestimo.foiDevolvido == false;
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: semPrazo.length,
        itemBuilder: (context, index) {
          final emprestimo = semPrazo[index];
          return EmprestimoItemComponents(
            emprestimo: emprestimo,
            excluirDevolucao: () => excluirDevolucao(emprestimo),
            fazerDevolucao: () => fazerDevolucao(emprestimo),
          );
        },
      ),
    );
  }

  Widget _listDevolvidos(BuildContext context, List<Emprestimo> emprestimos) {
    final semPrazo = emprestimos.where((emprestimo) {
      return emprestimo.foiDevolvido == true;
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: semPrazo.length,
        itemBuilder: (context, index) {
          final emprestimo = semPrazo[index];
          return EmprestimoItemComponents(
            emprestimo: emprestimo,
            excluirDevolucao: () => excluirDevolucao(emprestimo),
            fazerDevolucao: () => fazerDevolucao(emprestimo),
          );
        },
      ),
    );
  }
}
