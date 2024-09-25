import 'package:biblioteca_pessoal/layers/domain/entities/emprestimo_entity.dart';
import 'package:biblioteca_pessoal/layers/domain/entities/livro_entity.dart';
import 'package:biblioteca_pessoal/layers/presentation/controllers/emprestimo_controller.dart';
import 'package:biblioteca_pessoal/layers/presentation/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class EmprestimoPage extends StatefulWidget {
  const EmprestimoPage({super.key});

  @override
  State<EmprestimoPage> createState() => _EmprestimoPageState();
}

class _EmprestimoPageState extends State<EmprestimoPage> {
  final user = UserController.user;
  late EmprestimoController controller;
  final TextEditingController _destinatarioController = TextEditingController();
  final TextEditingController _dataEmprestimoController =
      TextEditingController();
  final TextEditingController _diasController = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller = GetIt.I.get<EmprestimoController>();
  }

  @override
  void dispose() {
    _destinatarioController.dispose();
    _dataEmprestimoController.dispose();
    _diasController.dispose();
    super.dispose();
  }

  void _salvarEmprestimo() async {
    final livro = Livro(
      uidUsuario: user!.uid,
      autor: 'autor',
      titulo: 'titulo',
      paginas: 10,
      ano: '2023',
    );

    final emprestimo = Emprestimo(
      uidUsuario: user!.uid,
      livro: livro,
      destinatario: _destinatarioController.text,
      dataEmprestimo: _dataEmprestimoController.text.isNotEmpty
          ? DateTime.parse(
              _dataEmprestimoController.text.split('/').reversed.join('-'))
          : DateTime.now(),
      dias: int.parse(_diasController.text), // Convertendo a string para int
    );

    final response = await controller.createEmprestimo(emprestimo);

    if (response) {
      _dataEmprestimoController.clear();
      _destinatarioController.clear();
      _diasController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emprestimos Teste'),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: _destinatarioController,
                decoration: const InputDecoration(labelText: 'Destinatário'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o destinatário';
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _dataEmprestimoController,
                      decoration: const InputDecoration(
                          labelText: 'Data do Empréstimo'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira a data do empréstimo';
                        }
                        return null;
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        // Formata a data para o padrão brasileiro (dd/MM/yyyy)
                        String formattedDate =
                            "${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year}";
                        _dataEmprestimoController.text = formattedDate;
                      }
                    },
                  ),
                ],
              ),
              TextFormField(
                controller: _diasController,
                decoration: const InputDecoration(labelText: 'Dias'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a quantidade de dias';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _salvarEmprestimo,
                child: const Text('Enviar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
