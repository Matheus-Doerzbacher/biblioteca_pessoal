import 'package:biblioteca_pessoal/core/routes/app_routes.dart';
import 'package:biblioteca_pessoal/layers/domain/entities/emprestimo_entity.dart';
import 'package:biblioteca_pessoal/layers/presentation/controllers/emprestimo_controller.dart';
import 'package:biblioteca_pessoal/layers/presentation/widgets/drawer_custom/drawer_custom.dart';
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

  @override
  Widget build(BuildContext context) {
    final emprestimos = controller.emprestimos;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Emprestimos'),
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'Todos',
              ),
              Tab(
                text: 'Atrasados',
              ),
              Tab(
                text: 'Sem Prazo',
              ),
            ],
          ),
          actions: [
            TextButton.icon(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.emprestimo.novo);
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
          return EmprestimoItemComponents(emprestimo);
        },
      ),
    );
  }

  Widget _listAtrasados(BuildContext context, List<Emprestimo> emprestimos) {
    final atrasados = emprestimos.where((emprestimo) {
      if (emprestimo.dataDevolucao != null) {
        final result =
            emprestimo.dataDevolucao!.compareTo(emprestimo.dataEmprestimo);
        if (result < 0) {
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
          return EmprestimoItemComponents(emprestimo);
        },
      ),
    );
  }

  Widget _listSemPrazo(BuildContext context, List<Emprestimo> emprestimos) {
    final semPrazo = emprestimos.where((emprestimo) {
      return emprestimo.dataDevolucao == null;
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: semPrazo.length,
        itemBuilder: (context, index) {
          final emprestimo = semPrazo[index];
          return EmprestimoItemComponents(emprestimo);
        },
      ),
    );
  }
}

class EmprestimoItemComponents extends StatelessWidget {
  final Emprestimo emprestimo;
  const EmprestimoItemComponents(this.emprestimo, {super.key});

  @override
  Widget build(BuildContext context) {
    final livro = emprestimo.livro;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        tileColor: Theme.of(context).colorScheme.surfaceContainer,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(16),
          ),
          side: BorderSide(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        leading: Image.network(livro?.urlImage ?? ''),
        title: Text(
          livro?.titulo ?? '',
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(emprestimo.destinatario),
            Text('Quantidade: ${emprestimo.quantidade}'),
          ],
        ),
      ),
    );
  }
}
