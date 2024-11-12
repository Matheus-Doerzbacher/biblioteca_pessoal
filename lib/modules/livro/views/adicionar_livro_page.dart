import 'dart:io';

import 'package:biblioteca_pessoal/core/routes/app_routes.dart';
import 'package:biblioteca_pessoal/core/widgets/input_text_custom.dart';
import 'package:biblioteca_pessoal/modules/categoria/models/categoria.dart';
import 'package:biblioteca_pessoal/modules/livro/controllers/adicionar_livro_controller.dart';
import 'package:biblioteca_pessoal/modules/livro/models/livro.dart';
import 'package:biblioteca_pessoal/modules/livro/views/components/drop_down_multi_custom.dart';
import 'package:biblioteca_pessoal/modules/livro/views/components/drop_down_single_custom.dart';
import 'package:biblioteca_pessoal/modules/livro/views/components/selecionar_foto.dart';
import 'package:biblioteca_pessoal/modules/usuario/controllers/user_controller.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:multi_dropdown/multi_dropdown.dart';

class AdicionarLivroPage extends StatefulWidget {
  final Livro? livroUpdate;
  const AdicionarLivroPage({super.key, this.livroUpdate});

  @override
  State<AdicionarLivroPage> createState() => _AdicionarLivroPageState();
}

class _AdicionarLivroPageState extends State<AdicionarLivroPage> {
  final user = UserController.user;
  final controller = Modular.get<AdicionarLivroController>();

  final _tituloController = TextEditingController();
  final _autorController = TextEditingController();
  final _editoraController = TextEditingController();
  final _paginaController = TextEditingController();
  final _anoController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _quantidadeController = TextEditingController();
  StatusLeitura _statusController = StatusLeitura.queroLer;
  List<Categoria> _categoriasController = [];
  double _ratingController = 3;
  File? _imageSelected;
  String? _urlImage;

  final MultiSelectController<Categoria> _multiSelectController =
      MultiSelectController<Categoria>();

  bool isSelected(Categoria categoria) {
    var result = false;
    for (final catController in _categoriasController) {
      if (catController.nome == categoria.nome) {
        result = true;
      }
    }
    return result;
  }

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    controller.getCategorias().then((categorias) {
      _multiSelectController.setItems(
        controller.categoriasUsuario.map((categoria) {
          return DropdownItem(
            label: categoria.nome,
            value: categoria,
            selected: isSelected(categoria),
          );
        }).toList(),
      );
      if (mounted) {
        setState(() {});
      }
    });

    if (widget.livroUpdate != null) {
      _tituloController.text = widget.livroUpdate!.titulo;
      _autorController.text = widget.livroUpdate!.autor;
      _editoraController.text = widget.livroUpdate!.editora;
      _paginaController.text = widget.livroUpdate!.paginas.toString();
      _anoController.text = widget.livroUpdate!.ano;
      _descricaoController.text = widget.livroUpdate!.descricao;
      _quantidadeController.text = widget.livroUpdate!.estoque.toString();
      _statusController = widget.livroUpdate!.status;
      _categoriasController = widget.livroUpdate!.categorias;
      _ratingController = widget.livroUpdate!.avaliacao.toDouble();
      _urlImage = widget.livroUpdate!.urlImage;
    }
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
    setState(() {
      _imageSelected = image;
      _urlImage = null;
    });
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

  Future<void> _handleSubmit() async {
    try {
      setState(() {
        _isLoading = true;
      });

      var imageUrl = '';
      late int paginaInt;
      late var quantidade = 0;

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
        id: widget.livroUpdate?.id,
        uidUsuario: user!.uid,
        autor: _autorController.text,
        editora: _editoraController.text,
        titulo: _tituloController.text,
        paginas: paginaInt,
        ano: _anoController.text,
        urlImage:
            imageUrl.isEmpty ? widget.livroUpdate?.urlImage ?? '' : imageUrl,
        status: _statusController,
        categorias: _categoriasController,
        descricao: _descricaoController.text,
        estoque: quantidade,
        avaliacao: _statusController == StatusLeitura.queroLer
            ? 0
            : _ratingController.toInt(),
      );

      late bool result;

      if (widget.livroUpdate?.id != null) {
        result = await controller.updateLivro(livro);
      } else {
        result = await controller.createLivro(livro);
      }

      if (result == true) {
        if (mounted) {
          Modular.to.navigate(AppRoutes.home);
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Manualmente'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24),
            SelecionarFotoWidget(
              onImagePick: _handleImagePick,
              urlImage: _urlImage,
            ),
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
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
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
                  const SizedBox(width: 24),
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
              categorias: controller.categoriasUsuario,
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
            if (_statusController != StatusLeitura.queroLer)
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: RatingBar(
                  onRatingChanged: (newValue) => setState(() {
                    _ratingController = newValue;
                  }),
                  filledIcon: Icons.star,
                  emptyIcon: Icons.star_border,
                  initialRating: _ratingController,
                  alignment: Alignment.center,
                ),
              ),
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
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
