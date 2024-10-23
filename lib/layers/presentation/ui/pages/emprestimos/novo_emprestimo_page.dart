import 'package:biblioteca_pessoal/layers/domain/entities/livro_entity.dart';
import 'package:biblioteca_pessoal/layers/presentation/controllers/emprestimo_controller.dart';
import 'package:biblioteca_pessoal/layers/presentation/widgets/input_text_custom.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class NovoEmprestimoPage extends StatefulWidget {
  const NovoEmprestimoPage({super.key});

  @override
  State<NovoEmprestimoPage> createState() => _NovoEmprestimoPageState();
}

class _NovoEmprestimoPageState extends State<NovoEmprestimoPage> {
  final controller = GetIt.I<EmprestimoController>();

  // Controllers Inputs
  final _nomeController = TextEditingController();
  final _livroController2 = TextEditingController();
  Livro? _livroController;

  @override
  void initState() {
    controller.getLivros().then((_) {
      if (mounted) setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _nomeController.dispose();
    super.dispose();
  }

  void _handleLivro(Livro livro) {
    setState(() {
      _livroController = livro;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Emprestimo'),
      ),
      body: Column(
        children: [
          InputTextCustom(
            controller: _nomeController,
            colorScheme: colorScheme,
            text: 'Nome da Pessoa',
          ),
          const SizedBox(height: 16),
          // Select Livro
          _selectLivro(context, colorScheme),
        ],
      ),
    );
  }

  Widget _selectLivro(BuildContext context, ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(14, 0, 14, 0),
      child: Container(
        decoration: const BoxDecoration(),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
          child: Container(
            width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
              color: colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  blurRadius: 4,
                  color: colorScheme.shadow,
                  offset: const Offset(2, 2),
                ),
              ],
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownMenu<Livro>(
              controller: _livroController2,
              enableFilter: true,
              label: const Text('Selecione um livro'),
              leadingIcon: const Icon(Icons.search),
              inputDecorationTheme: const InputDecorationTheme(
                border: OutlineInputBorder(
                  borderSide: BorderSide.none, // Remove a borda
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide
                      .none, // Remove a borda quando o campo está habilitado
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide
                      .none, // Remove a borda quando o campo está focado
                ),
              ),
              onSelected: (Livro? livro) {
                if (livro != null) {
                  _handleLivro(livro);
                }
              },
              dropdownMenuEntries: controller.meusLivros
                  .map<DropdownMenuEntry<Livro>>((Livro livro) {
                return DropdownMenuEntry<Livro>(
                  value: livro,
                  label: livro.titulo,
                  leadingIcon: Image.network(
                    livro.urlImage,
                    height: 30,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
