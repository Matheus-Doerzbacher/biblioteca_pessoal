import 'dart:io';

import 'package:biblioteca_pessoal/layers/domain/entities/livro_entity.dart';
import 'package:biblioteca_pessoal/layers/presentation/controllers/livro_controller.dart';
import 'package:biblioteca_pessoal/layers/presentation/controllers/user_controller.dart';
import 'package:biblioteca_pessoal/layers/presentation/widgets/drawer_custom/drawer_custom.dart';
import 'package:biblioteca_pessoal/layers/presentation/widgets/selecionar_foto.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class AdicionarLivroPage extends StatefulWidget {
  const AdicionarLivroPage({super.key});

  @override
  State<AdicionarLivroPage> createState() => _AdicionarLivroPageState();
}

class _AdicionarLivroPageState extends State<AdicionarLivroPage> {
  final user = UserController.user;
  late LivroController controller;
  final _tituloController = TextEditingController();
  File? _imageSelected;

  @override
  void initState() {
    controller = GetIt.I.get<LivroController>();
    super.initState();
  }

  void _handleImagePick(File image) {
    _imageSelected = image;
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }

  void _handleSubmit() async {
    if (_tituloController.text.isEmpty) {
      _showError('Informe um titulo');
    }

    if (_imageSelected == null) {
      _showError('Selecione uma imagem para o Livro');
    }

    final imageUrl = await controller.salvarImageFirebase(_imageSelected!);

    if (imageUrl.isEmpty) {
      _showError('Houve um problema ao salvar o livro');
    }

    final livro = Livro(
      uidUsuario: user!.uid,
      autor: '',
      titulo: _tituloController.text,
      paginas: 0,
      ano: 2024,
      urlImage: imageUrl,
    );

    await controller.createLivro(livro);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Livro'),
      ),
      drawer: const DrawerCustom(namePageActive: '/adicionar'),
      body: SingleChildScrollView(
        primary: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            SelecionarFotoWidget(onImagePick: _handleImagePick),
            const SizedBox(height: 24),
            Padding(
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
                          offset: const Offset(
                            2,
                            2,
                          ),
                        )
                      ],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: SizedBox(
                      width: 200,
                      child: TextFormField(
                        controller: _tituloController,
                        autofocus: false,
                        obscureText: false,
                        decoration: InputDecoration(
                          isDense: true,
                          labelText: 'Titulo',
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: colorScheme.error,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: colorScheme.error,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        cursorColor: colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                      ),
                      onPressed: _handleSubmit,
                      child: Text(
                        'Salvar',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: colorScheme.onPrimary),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
