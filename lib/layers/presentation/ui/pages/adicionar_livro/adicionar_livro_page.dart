import 'dart:io';

import 'package:biblioteca_pessoal/layers/domain/entities/categoria_entity.dart';
import 'package:biblioteca_pessoal/layers/domain/entities/livro_entity.dart';
import 'package:biblioteca_pessoal/layers/presentation/controllers/livro_controller.dart';
import 'package:biblioteca_pessoal/layers/presentation/controllers/user_controller.dart';
import 'package:biblioteca_pessoal/layers/presentation/ui/pages/adicionar_livro/components/drop_down_multi_custom.dart';
import 'package:biblioteca_pessoal/layers/presentation/widgets/drawer_custom/drawer_custom.dart';
import 'package:biblioteca_pessoal/layers/presentation/ui/pages/adicionar_livro/components/selecionar_foto.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:multi_dropdown/multi_dropdown.dart';

class AdicionarLivroPage extends StatefulWidget {
  const AdicionarLivroPage({super.key});

  @override
  State<AdicionarLivroPage> createState() => _AdicionarLivroPageState();
}

class _AdicionarLivroPageState extends State<AdicionarLivroPage> {
  final user = UserController.user;
  late LivroController controller;

  final _tituloController = TextEditingController();
  final _autorController = TextEditingController();
  final _editoraController = TextEditingController();
  final _paginaController = TextEditingController();
  final _anoController = TextEditingController();
  StatusLeitura _statusController = StatusLeitura.queroLer;
  List<Categoria> _categoriasController = [];
  File? _imageSelected;

  final MultiSelectController<Categoria> _multiSelectController =
      MultiSelectController<Categoria>();

  @override
  void initState() {
    controller = GetIt.I.get<LivroController>();
    _inicializarCategorias();
    super.initState();
  }

  void _inicializarCategorias() async {
    await controller.getCategoriasDropDown(UserController.user?.uid ?? '');
    setState(() {});
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

  void _handleStatus(StatusLeitura value) {
    setState(() {
      _statusController = value;
    });
  }

  void _alterarCategoria(List<Categoria> categorias) {
    setState(() {
      _categoriasController = categorias;
    });
  }

  void _handleSubmit() async {
    String imageUrl = '';
    late int paginaInt;
    late int anoInt;

    if (_tituloController.text.isEmpty) {
      _showError('Informe um Titulo');
      return;
    }

    if (_autorController.text.isEmpty) {
      _showError('Informe o Autor');
      return;
    }

    if (_paginaController.text.isEmpty) {
      _showError('Informe a Página');
      return;
    }

    try {
      paginaInt = int.parse(_paginaController.text);
    } catch (e) {
      _showError('Informe um número válido na página');
      return;
    }

    try {
      anoInt = int.parse(_anoController.text);
    } catch (e) {
      _showError('Informe um número válido para o Ano');
      return;
    }

    if (_imageSelected != null) {
      imageUrl = await controller.salvarImageLivro(_imageSelected!);

      if (imageUrl.isEmpty) {
        _showError('Houve um problema ao salvar o livro');
        return;
      }
    }

    final livro = Livro(
      uidUsuario: user!.uid,
      autor: _autorController.text,
      editora: _editoraController.text,
      titulo: _tituloController.text,
      paginas: paginaInt,
      ano: anoInt,
      urlImage: imageUrl,
      status: _statusController,
      categorias: _categoriasController,
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
            InputTextCustom(
              controller: _tituloController,
              colorScheme: colorScheme,
              text: 'Titulo',
            ),
            InputTextCustom(
              controller: _autorController,
              colorScheme: colorScheme,
              text: 'Autor',
            ),
            InputTextCustom(
              controller: _editoraController,
              colorScheme: colorScheme,
              text: 'Editora',
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 24, 14, 0),
              child: Row(
                children: [
                  Expanded(
                    child: InputTextCustom(
                      controller: _paginaController,
                      colorScheme: colorScheme,
                      text: 'Páginas',
                      isMeiaLinha: true,
                      isNumber: true,
                    ),
                  ),
                  Expanded(
                    child: InputTextCustom(
                      controller: _anoController,
                      colorScheme: colorScheme,
                      text: 'Ano',
                      isMeiaLinha: true,
                      isNumber: true,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            DropDownMultiCustom(
              alterarCategorias: _alterarCategoria,
              categoriasSelecionadas: _categoriasController,
              categorias: controller.categoriasDropDown,
              colorScheme: colorScheme,
              multiSelectController: _multiSelectController,
            ),
            const SizedBox(height: 24),
            DropDownSingleCustom(
              alterarStatus: (teste) => {
                _handleStatus(teste),
              },
              colorScheme: colorScheme,
              statusAtual: _statusController,
            ),
            const SizedBox(height: 24),
            // RatingBar(
            //   onRatingChanged: (newValue) => setState(() {
            //     if (_ratingController == newValue) {
            //       _ratingController = 0.0;
            //     } else {
            //       _ratingController = newValue;
            //     }
            //   }),
            //   filledIcon: Icons.star,
            //   emptyIcon: Icons.star_border,
            //   direction: Axis.horizontal,
            //   initialRating: _ratingController,
            //   maxRating: 5,
            //   alignment: Alignment.center,
            // ),
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

class InputTextCustom extends StatelessWidget {
  final TextEditingController controller;
  final ColorScheme colorScheme;
  final String text;
  final bool? isMeiaLinha;
  final bool? isNumber;

  const InputTextCustom({
    super.key,
    required this.controller,
    required this.colorScheme,
    required this.text,
    this.isMeiaLinha = false,
    this.isNumber = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isMeiaLinha == true
          ? const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0)
          : const EdgeInsetsDirectional.fromSTEB(14, 24, 14, 0),
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
                style: TextStyle(color: colorScheme.onSurface),
                keyboardType: isNumber == true
                    ? TextInputType.number
                    : TextInputType.text,
                controller: controller,
                autofocus: false,
                obscureText: false,
                decoration: InputDecoration(
                  isDense: true,
                  labelText: text,
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
    );
  }
}

class DropDownSingleCustom extends StatelessWidget {
  final ColorScheme colorScheme;
  final Function(StatusLeitura) alterarStatus;
  final StatusLeitura statusAtual;

  const DropDownSingleCustom({
    super.key,
    required this.colorScheme,
    required this.alterarStatus,
    required this.statusAtual,
  });

  @override
  Widget build(BuildContext context) {
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
                  offset: const Offset(
                    2,
                    2,
                  ),
                )
              ],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: DropdownButton<StatusLeitura>(
                iconSize: 24,
                value: statusAtual,
                icon: const Icon(Icons.keyboard_arrow_down_rounded),
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: colorScheme.onSurface),
                underline: Container(
                  color: colorScheme.onPrimary,
                ),
                onChanged: (StatusLeitura? newValue) {
                  if (newValue != null) {
                    alterarStatus(newValue);
                  }
                },
                items: const <DropdownMenuItem<StatusLeitura>>[
                  DropdownMenuItem<StatusLeitura>(
                    value: StatusLeitura.lendo,
                    child: Text('Lendo'),
                  ),
                  DropdownMenuItem<StatusLeitura>(
                    value: StatusLeitura.lido,
                    child: Text('Lido'),
                  ),
                  DropdownMenuItem<StatusLeitura>(
                    value: StatusLeitura.queroLer,
                    child: Text('Quero ler'),
                  ),
                ],
                isExpanded: true,
              ),
            ),
          ),
        ),
      ),
    );
  }
}