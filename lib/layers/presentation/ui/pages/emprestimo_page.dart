import 'package:biblioteca_pessoal/core/routes/app_routes.dart';
import 'package:biblioteca_pessoal/layers/presentation/widgets/drawer_custom/drawer_custom.dart';
import 'package:flutter/material.dart';

class EmprestimosPage extends StatelessWidget {
  const EmprestimosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const DrawerCustom(namePageActive: AppRoutes.emprestimo),
      body: const Center(
        child: Text('Emprestimos Page'),
      ),
    );
  }
}
