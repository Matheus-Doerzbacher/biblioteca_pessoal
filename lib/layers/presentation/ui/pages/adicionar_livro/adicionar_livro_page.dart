import 'dart:io';

import 'package:biblioteca_pessoal/layers/domain/entities/categoria_entity.dart';
import 'package:biblioteca_pessoal/layers/domain/entities/livro_entity.dart';
import 'package:biblioteca_pessoal/layers/presentation/controllers/categoria_controller.dart';
import 'package:biblioteca_pessoal/layers/presentation/controllers/livro_controller.dart';
import 'package:biblioteca_pessoal/layers/presentation/controllers/user_controller.dart';
import 'package:biblioteca_pessoal/layers/presentation/ui/pages/adicionar_livro/components/drop_down_multi_custom.dart';
import 'package:biblioteca_pessoal/layers/presentation/ui/pages/adicionar_livro/components/drop_down_single_custom.dart';
import 'package:biblioteca_pessoal/layers/presentation/ui/pages/adicionar_livro/components/selecionar_foto.dart';
import 'package:biblioteca_pessoal/layers/presentation/widgets/drawer_custom/drawer_custom.dart';
import 'package:biblioteca_pessoal/layers/presentation/widgets/input_text_custom.dart';
import 'package:flutter/material.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:provider/provider.dart';

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
  final _descricaoController = TextEditingController();
  final _quantidadeController = TextEditingController();
  StatusLeitura _statusController = StatusLeitura.queroLer;
  List<Categoria> _categoriasController = [];
  File? _imageSelected;

  final MultiSelectController<Categoria> _multiSelectController =
      MultiSelectController<Categoria>();

  bool _isLoading = false;

  // void _limparControladores() {
  //   _tituloController.clear();
  //   _autorController.clear();
  //   _editoraController.clear();
  //   _paginaController.clear();
  //   _anoController.clear();
  //   _descricaoController.clear();
  //   _quantidadeController.clear();
  //   _statusController = StatusLeitura.queroLer;
  //   _categoriasController = [];
  //   _imageSelected = null;
  // }

  @override
  void initState() {
    controller = Provider.of<LivroController>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _autorController.dispose();
    _editoraController.dispose();
    _paginaController.dispose();
    _anoController.dispose();
    _descricaoController.dispose();
    _quantidadeController.dispose();
    super.dispose();
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
    try {
      setState(() {
        _isLoading = true;
      });

      String imageUrl = '';
      late int paginaInt;
      late int anoInt;
      late int quantidade = 0;

      if (_tituloController.text.isEmpty) {
        throw Exception('Informe um Titulo');
      }

      if (_autorController.text.isEmpty) {
        throw Exception('Informe o Autor');
      }

      if (_paginaController.text.isEmpty) {
        throw Exception('Informe a Página');
      }

      try {
        paginaInt = int.parse(_paginaController.text);
      } catch (e) {
        throw Exception('Informe um número válido na página');
      }

      try {
        anoInt = int.parse(_anoController.text);
      } catch (e) {
        throw Exception('Informe um número válido para o Ano');
      }

      if (_quantidadeController.text.isNotEmpty) {
        try {
          quantidade = int.parse(_quantidadeController.text);
        } catch (e) {
          throw Exception('Informe um número válido para a quantidade');
        }
      }

      if (_imageSelected != null) {
        imageUrl = await controller.salvarImageLivro(_imageSelected!);

        if (imageUrl.isEmpty) {
          throw Exception('Houve um problema ao salvar o livro');
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
        descricao: _descricaoController.text,
        estoque: quantidade,
      );

      bool result = await controller.createLivro(livro);

      if (result == true) {
        if (mounted) {
          Navigator.of(context).pushNamed('/');
        }
      } else {
        throw Exception('Houve um problema ao salvar o livro');
      }
    } catch (e) {
      _showError(
        e.toString().isEmpty
            ? 'Houve um problema ao salvar o livro'
            : e.toString().replaceAll('Exception: ', ''),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final categorias = Provider.of<CategoriaController>(context).categorias;

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
              categorias: categorias,
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

            // const SizedBox(height: 24),
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

            InputTextCustom(
              controller: _descricaoController,
              colorScheme: colorScheme,
              text: 'Descrição',
              numeroLinhas: 5,
            ),
            InputTextCustom(
              controller: _quantidadeController,
              colorScheme: colorScheme,
              text: 'Quantidade de Exemplares',
              isNumber: true,
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
                      child: _isLoading
                          ? CircularProgressIndicator(
                              color: colorScheme.onPrimary,
                            )
                          : Text(
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