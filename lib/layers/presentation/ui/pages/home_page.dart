import 'package:biblioteca_pessoal/layers/domain/entities/livro_entity.dart';
import 'package:biblioteca_pessoal/layers/presentation/controllers/livro_controller.dart';
import 'package:biblioteca_pessoal/layers/presentation/controllers/user_controller.dart';
import 'package:biblioteca_pessoal/layers/presentation/widgets/drawer_custom/drawer_custom.dart';
import 'package:biblioteca_pessoal/layers/presentation/widgets/livro_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pesquisarController = TextEditingController();
  final controller = GetIt.instance.get<LivroController>();
  List<Livro> _filteredLivros = [];

  @override
  void initState() {
    super.initState();
    _pesquisarController.addListener(_onSearchChanged);
    controller.getLivros(UserController.user?.uid ?? '').then((_) {
      setState(() {
        _filteredLivros = controller.livros;
      });
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
      drawer: const DrawerCustom(namePageActive: '/'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 24, 14, 24),
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
                      ),
                    ],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: TextFormField(
                      textAlignVertical: TextAlignVertical.top,
                      style: TextStyle(color: colorScheme.onSurface),
                      controller: _pesquisarController,
                      decoration: InputDecoration(
                        suffixIcon: const Icon(Icons.search),
                        isDense: true,
                        labelText: 'Pesquisar',
                        alignLabelWithHint: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0x00000000),
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0x00000000),
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: colorScheme.error,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: colorScheme.error,
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
          if (controller.isLoading)
            const Center(
              child: CircularProgressIndicator(),
            )
          else
            Expanded(
              child: livros.isNotEmpty
                  ? GridView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.58,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: livros.length,
                      itemBuilder: (context, index) {
                        final livro = livros[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/livro-detail',
                              arguments: livro,
                            );
                          },
                          child: LivroCard(livro: livro, context: context),
                        );
                      },
                    )
                  : const Center(
                      child: Text('Nenhum livro encontrado'),
                    ),
            ),
        ],
      ),
    );
  }
}
