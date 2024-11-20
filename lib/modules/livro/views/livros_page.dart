import 'package:biblioteca_pessoal/core/routes/app_routes.dart';
import 'package:biblioteca_pessoal/core/widgets/drawer_custom/drawer_custom.dart';
import 'package:biblioteca_pessoal/core/widgets/livro_card_widget.dart';
import 'package:biblioteca_pessoal/modules/categoria/models/categoria.dart';
import 'package:biblioteca_pessoal/modules/livro/controllers/livro_controller.dart';
import 'package:biblioteca_pessoal/modules/livro/models/livro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LivrosPage extends StatefulWidget {
  const LivrosPage({super.key});

  @override
  State<LivrosPage> createState() => _LivrosPageState();
}

class _LivrosPageState extends State<LivrosPage> {
  bool _openFilter = false;
  final _pesquisarController = TextEditingController();
  final _selectController = TextEditingController();
  final controller = Modular.get<LivroController>();
  List<Categoria> _categorias = [];

  @override
  void initState() {
    super.initState();
    _pesquisarController.addListener(_onSearchChanged);
    controller.getCategorias().then((_) {
      if (mounted) {
        setState(() {
          _categorias = controller.categoriasUsuario;
        });
      }
    });
    _selectController.text = 'todos';
  }

  @override
  void dispose() {
    _pesquisarController
      ..removeListener(_onSearchChanged)
      ..dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    context.read<LivroController>().setFiltro(_pesquisarController.text);
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<LivroController>();

    Future<void> _favoritarLivro(Livro livro) async {
      await controller.favoritarLivro(livro);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Livros'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _openFilter = !_openFilter;
              });
            },
            icon: _openFilter
                ? const Icon(Icons.close)
                : const Icon(Icons.filter_list),
          ),
        ],
      ),
      drawer: DrawerCustom(namePageActive: AppRoutes.livro.home()),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              if (_openFilter) _buildFilter(context),
              const SizedBox(height: 16),
              if (controller.isLoading)
                const Center(
                  child: CircularProgressIndicator(),
                )
              else
                Expanded(
                  child: controller.livrosFiltrados.isNotEmpty
                      ? GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.59,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                          ),
                          itemCount: controller.livrosFiltrados.length,
                          itemBuilder: (context, index) {
                            final livro = controller.livrosFiltrados[index];
                            return GestureDetector(
                              onTap: () {
                                Modular.to.pushNamed(
                                  AppRoutes.livro.detail(),
                                  arguments: livro,
                                );
                              },
                              child: LivroCard(
                                livro: livro,
                                context: context,
                                favoritarLivro: () => _favoritarLivro(livro),
                              ),
                            );
                          },
                        )
                      : const Center(
                          child: Text('Nenhum livro encontrado'),
                        ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilter(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: _selectController.text,
                  items: [
                    const DropdownMenuItem<String>(
                      value: 'todos',
                      child: Text('Todos'),
                    ),
                    ..._categorias.map((categoria) {
                      return DropdownMenuItem<String>(
                        value: categoria.nome,
                        child: Text(
                          categoria.nome,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }).toList(),
                  ],
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      _selectController.text = newValue;
                      controller.setCategoriaFiltro(newValue);
                    }
                  },
                  hint: const Text('Categoria'),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Row(
              children: [
                const Text('Favoritos'),
                Switch(
                  value: controller.somenteFavoritos,
                  onChanged: (bool value) {
                    controller.setSomenteFavoritos(
                      somenteFavoritos: value,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        TextFormField(
          textAlignVertical: TextAlignVertical.top,
          controller: _pesquisarController,
          decoration: InputDecoration(
            suffixIcon: const Icon(Icons.search, size: 24),
            isDense: true,
            hintText: 'Pesquisar',
            fillColor: colorScheme.surfaceContainer,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}
