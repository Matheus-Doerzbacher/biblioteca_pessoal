import 'package:biblioteca_pessoal/core/routes/app_routes.dart';
import 'package:biblioteca_pessoal/core/widgets/drawer_custom/drawer_custom.dart';
import 'package:biblioteca_pessoal/core/widgets/livro_card_widget.dart';
import 'package:biblioteca_pessoal/modules/home/controllers/home_controller.dart';
import 'package:biblioteca_pessoal/modules/livro/models/livro.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pesquisarController = TextEditingController();
  final controller = GetIt.instance.get<HomeController>();
  List<Livro> _filteredLivros = [];

  @override
  void initState() {
    super.initState();
    _pesquisarController.addListener(_onSearchChanged);
    controller.getLivros().then((_) {
      if (mounted) {
        setState(() {
          _filteredLivros = controller.livros;
        });
      }
    });
  }

  @override
  void dispose() {
    _pesquisarController
      ..removeListener(_onSearchChanged)
      ..dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      final query = _pesquisarController.text.toLowerCase();
      _filteredLivros = controller.livros.where((livro) {
        return livro.titulo.toLowerCase().contains(query) ||
            livro.autor.toLowerCase().contains(query);
      }).toList();
    });
  }

  Future<void> _favoritarLivro(Livro livro) async {
    final result = await controller.favoritarLivro(livro);

    if (result) {
      setState(() {
        for (final liv in _filteredLivros) {
          if (liv.id! == livro.id!) {
            liv.isFavorito = livro.isFavorito;
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final livros = _filteredLivros;

    // final livros =
    //  Provider.of<LivroController>(context).livros.where((livro) {
    //   final query = _pesquisarController.text.toLowerCase();
    //   return livro.titulo.toLowerCase().contains(query) ||
    //       livro.autor.toLowerCase().contains(query);
    // }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Livros'),
        centerTitle: true,
      ),
      drawer: const DrawerCustom(namePageActive: AppRoutes.home),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
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
              const SizedBox(height: 16),
              if (controller.isLoading)
                const Center(
                  child: CircularProgressIndicator(),
                )
              else
                Expanded(
                  child: livros.isNotEmpty
                      ? GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.59,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                          ),
                          itemCount: livros.length,
                          itemBuilder: (context, index) {
                            final livro = livros[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.livro.livroDetail,
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
}
