import 'package:biblioteca_pessoal/layers/domain/entities/livro_entity.dart';
import 'package:biblioteca_pessoal/layers/presentation/controllers/emprestimo_controller.dart';
import 'package:biblioteca_pessoal/layers/presentation/ui/pages/emprestimos/components/selecionar_data_emprestimo_component.dart';
import 'package:biblioteca_pessoal/layers/presentation/widgets/input_text_custom.dart';
import 'package:flutter/foundation.dart';
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
  final _quantidadeController = TextEditingController();
  bool _switchDataController = false;
  final _dataDevolucao =
      TextEditingController(text: DateTime.now().toIso8601String());
  Livro? _livroController;

  final _formKey = GlobalKey<FormState>();

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
    if (kDebugMode) {
      print(_livroController?.titulo);
    }
  }

  void _handleData(DateTime dateTime) {
    setState(() {
      _dataDevolucao.text = dateTime.toIso8601String();
    });
  }

  void _submitForm() {
    // Valida todos os campos do formulário
    if (_formKey.currentState?.validate() ?? false) {
      // Se o formulário for válido, continue com o processo de empréstimo
      if (kDebugMode) {
        print('Formulário válido!');
      }
    } else {
      if (kDebugMode) {
        print('Formulário inválido!');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Emprestimo'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            InputTextCustom(
              controller: _nomeController,
              colorScheme: colorScheme,
              text: 'Nome da Pessoa',
            ),
            const SizedBox(height: 24),
            // Select Livro
            _selectLivro(context, colorScheme),
            InputTextCustom(
              controller: _quantidadeController,
              colorScheme: colorScheme,
              text: 'Quantidade',
              isNumber: true,
              validator: (value) {
                if (_livroController != null) {
                  final estoque = _livroController!.estoque;
                  if (int.parse(value) < 1) {
                    return 'Você deve informar pelo menos 1';
                  }
                  if (int.parse(value) > estoque) {
                    return 'A quantidade deve ser no máximo $estoque';
                  }
                }
                return null;
              },
            ),
            // Switch Data Devolução
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Adicionar data de devolução',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(width: 16),
                  Switch(
                    value: _switchDataController,
                    onChanged: (bool value) {
                      setState(() {
                        _switchDataController = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            if (_switchDataController)
              SelecionarDataEmprestimoComponent(
                handleDate: _handleData,
              ),
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: FilledButton(
                onPressed: _submitForm, // Chama a validação do formulário
                child: const Text('Confirmar Empréstimo'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _selectLivro(BuildContext context, ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(14, 0, 14, 0),
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
          child: Container(
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
              textStyle: Theme.of(context).textTheme.bodyMedium,
              expandedInsets: EdgeInsets.zero,
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
