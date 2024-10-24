import 'package:biblioteca_pessoal/core/routes/app_routes.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emprestimos'),
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: emprestimos.length,
          itemBuilder: (context, index) {
            final emprestimo = emprestimos[index];
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
          },
        ),
      ),
    );
  }
}
