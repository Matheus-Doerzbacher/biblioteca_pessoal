import 'package:biblioteca_pessoal/core/routes/app_routes.dart';
import 'package:biblioteca_pessoal/layers/presentation/controllers/pesquisa_api_controller.dart';
import 'package:biblioteca_pessoal/layers/presentation/widgets/drawer_custom/drawer_custom.dart';
import 'package:biblioteca_pessoal/layers/presentation/widgets/livro_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class PesquisaApiPage extends StatefulWidget {
  const PesquisaApiPage({super.key});

  @override
  State<PesquisaApiPage> createState() => _PesquisaApiPageState();
}

class _PesquisaApiPageState extends State<PesquisaApiPage> {
  final controller = GetIt.instance.get<PesquisaApiController>();
  final _pesquisarController = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.addListener(_updateState);
  }

  @override
  void dispose() {
    _pesquisarController.dispose();
    controller.removeListener(_updateState);
    Future.microtask(
      controller.clearLivros,
    );
    super.dispose();
  }

  void _updateState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Livro'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.livro.adicionarManual);
            },
            icon: const Icon(Icons.add_circle_outline),
          ),
        ],
      ),
      drawer: DrawerCustom(namePageActive: AppRoutes.livro.adicionar),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 24, 14, 24),
            child: Container(
              decoration: const BoxDecoration(),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
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
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      onFieldSubmitted: (_) {
                        if (_pesquisarController.text != '') {
                          controller.getLivrosApi(_pesquisarController.text);
                        }
                      },
                      textAlignVertical: TextAlignVertical.top,
                      controller: _pesquisarController,
                      decoration: InputDecoration(
                        suffixIcon: ValueListenableBuilder<TextEditingValue>(
                          valueListenable: _pesquisarController,
                          builder: (context, value, child) {
                            return value.text.isNotEmpty
                                ? IconButton(
                                    onPressed: () {
                                      _pesquisarController.clear();
                                      controller.clearLivros();
                                    },
                                    icon: const Icon(Icons.close),
                                  )
                                : const Icon(Icons.search);
                          },
                        ),
                        isDense: true,
                        labelText: 'Pesquisar Livro',
                        alignLabelWithHint: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (controller.isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
          if (controller.livros.isNotEmpty && !controller.isLoading)
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.70,
                  mainAxisSpacing: 16,
                ),
                itemCount: controller.livros.length,
                itemBuilder: (context, index) {
                  final livro = controller.livros[index];
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
                      isPesquisa: true,
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
