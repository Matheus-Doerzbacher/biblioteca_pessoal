import 'package:biblioteca_pessoal/core/widgets/input_text_custom.dart';
import 'package:biblioteca_pessoal/modules/emprestimo/controllers/emprestimo_controller.dart';
import 'package:biblioteca_pessoal/modules/emprestimo/models/emprestimo.dart';
import 'package:biblioteca_pessoal/modules/emprestimo/views/components/selecionar_data_emprestimo_component.dart';
import 'package:biblioteca_pessoal/modules/livro/models/livro.dart';
import 'package:biblioteca_pessoal/modules/usuario/controllers/user_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class NovoEmprestimoPage extends StatefulWidget {
  const NovoEmprestimoPage({super.key});

  @override
  State<NovoEmprestimoPage> createState() => _NovoEmprestimoPageState();
}

class _NovoEmprestimoPageState extends State<NovoEmprestimoPage> {
  final controller = Modular.get<EmprestimoController>();

  // Controllers Inputs
  final _nomeController = TextEditingController();
  final _quantidadeController = TextEditingController(text: '1');
  bool _switchDataController = false;
  final _dataDevolucao =
      TextEditingController(text: DateTime.now().toIso8601String());
  final _dataEmprestimo =
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
    _quantidadeController.dispose();
    _dataDevolucao.dispose();
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

  void _handleDataDevolucao(DateTime dateTime) {
    setState(() {
      _dataDevolucao.text = dateTime.toIso8601String();
    });
  }

  void _handleDataEmprestimo(DateTime dateTime) {
    setState(() {
      _dataEmprestimo.text = dateTime.toIso8601String();
    });
  }

  void _bottomErrorMesage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(message),
      ),
    );
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (_livroController == null) {
        _bottomErrorMesage('Por favor selecione um livro');
      }

      DateTime? dataDevolucao;

      if (_switchDataController) {
        dataDevolucao = DateTime.parse(_dataDevolucao.text);
      }

      final emprestimo = Emprestimo(
        uidUsuario: UserController.user!.uid,
        idLivro: _livroController!.id ?? '',
        destinatario: _nomeController.text,
        quantidade: int.parse(_quantidadeController.text),
        dataDevolucao: dataDevolucao,
        dataEmprestimo: DateTime.parse(_dataEmprestimo.text),
      );

      final result = await controller.createEmprestimo(emprestimo);

      if (result) {
        _nomeController.clear();
        _dataDevolucao.clear();
        _quantidadeController.clear();
        _switchDataController = false;
        _livroController = null;

        if (mounted) {
          Modular.to.pop(true);
        }
      } else {
        _bottomErrorMesage('Ouve um problema ao fazer o Emprestimo');
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
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              InputTextCustom(
                controller: _nomeController,
                colorScheme: colorScheme,
                text: 'Nome da Pessoa',
                validator: (value) {
                  if (value == '') {
                    return 'Informe o nome da Pessoa';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              // Select Livro
              _selectLivro(context, colorScheme),
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: InputTextCustom(
                        controller: _quantidadeController,
                        colorScheme: colorScheme,
                        text: 'Quantidade',
                        isNumber: true,
                        validator: (value) {
                          if (_livroController != null) {
                            final estoque = _livroController!.estoque;

                            final quantidade = int.tryParse(value);

                            if (quantidade == null) {
                              return 'Informe um numero válido';
                            }

                            if (int.parse(value) < 1) {
                              return 'Você deve informar pelo menos 1';
                            }

                            if (int.parse(value) > estoque) {
                              return 'Quantidade máxima: $estoque';
                            }
                          }
                          return null;
                        },
                      ),
                    ),
                    IconButton.filled(
                      onPressed: () {
                        setState(() {
                          _quantidadeController.text =
                              (int.parse(_quantidadeController.text) + 1)
                                  .toString();
                        });
                      },
                      icon: const Icon(Icons.add),
                    ),
                    IconButton.filled(
                      onPressed: () {
                        setState(() {
                          _quantidadeController.text =
                              (int.parse(_quantidadeController.text) - 1)
                                  .toString();
                        });
                      },
                      icon: const Icon(Icons.remove),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SelecionarDataEmprestimoComponent(
                handleDate: _handleDataEmprestimo,
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
                  handleDate: _handleDataDevolucao,
                  isDevolucao: true,
                ),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: FilledButton(
                  onPressed: _submitForm, // Chama a validação do formulário
                  child: controller.isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Confirmar Empréstimo'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _selectLivro(BuildContext context, ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(14, 0, 14, 0),
      child: DropdownMenu<Livro>(
        textStyle: Theme.of(context).textTheme.bodyMedium,
        expandedInsets: EdgeInsets.zero,
        label: const Text('Selecione um livro'),
        leadingIcon: const Icon(Icons.search),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Theme.of(context).colorScheme.surfaceContainer,
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
        onSelected: (Livro? livro) {
          if (livro != null) {
            _handleLivro(livro);
          }
        },
        dropdownMenuEntries:
            controller.meusLivros.map<DropdownMenuEntry<Livro>>((Livro livro) {
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
    );
  }
}
