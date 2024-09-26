import 'package:biblioteca_pessoal/layers/domain/entities/categoria_entity.dart';
import 'package:biblioteca_pessoal/layers/presentation/controllers/categoria_controller.dart';
import 'package:biblioteca_pessoal/layers/presentation/controllers/user_controller.dart';
import 'package:biblioteca_pessoal/layers/presentation/ui/pages/categoria/components/categoria_item.dart';
import 'package:biblioteca_pessoal/layers/presentation/widgets/drawer_custom/drawer_custom.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CategoriaPage extends StatefulWidget {
  const CategoriaPage({super.key});

  @override
  State<CategoriaPage> createState() => _CategoriaPageState();
}

class _CategoriaPageState extends State<CategoriaPage> {
  final user = UserController.user;
  final CategoriaController controller = GetIt.instance<CategoriaController>();
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _editController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Não é mais necessário usar o Provider aqui
  }

  @override
  void dispose() {
    _textController.dispose();
    _editController.dispose();
    super.dispose();
  }

  void _adicionarCategoria() async {
    if (_textController.text.isNotEmpty) {
      await controller.createCategoria(
        Categoria(nome: _textController.text, uidUsuario: user!.uid),
      );
      _textController.clear();
      setState(() {});
    }
  }

  void _deleteCategoria(Categoria categoria) async {
    if (categoria.nome.isNotEmpty && categoria.id != null) {
      await controller.deleteCategoria(categoria.id!);
      setState(() {});
    }
  }

  void _editarCategoria(Categoria categoria) {
    _editController.text = categoria.nome;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editar Categoria'),
          content: TextField(
            controller: _editController,
            decoration:
                const InputDecoration(hintText: "Novo nome da categoria"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Salvar'),
              onPressed: () {
                if (_editController.text.isNotEmpty) {
                  _salvarCategoria(categoria);
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _salvarCategoria(Categoria categoria) async {
    await controller.updateCategoria(
      Categoria(
        id: categoria.id,
        nome: _editController.text,
        uidUsuario: user!.uid,
      ),
    );
    if (mounted) {
      Navigator.of(context).pop();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorias'),
        centerTitle: true,
      ),
      drawer: const DrawerCustom(namePageActive: '/categoria'),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(14, 24, 24, 0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 6),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainer,
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
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          controller: _textController,
                          style: TextStyle(
                            color: colorScheme.onSurface,
                          ), // Alteração para mudar a cor do texto
                          decoration: InputDecoration(
                            isDense: true,
                            labelText: 'Nome da Categoria',
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
                            filled: true,
                            fillColor: colorScheme.surfaceContainer,
                          ),
                          cursorColor: colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    color: colorScheme.primary,
                    style: IconButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    icon: Icon(
                      Icons.add,
                      color: colorScheme.onPrimary,
                      size: 24,
                    ),
                    onPressed: _adicionarCategoria,
                  ),
                ],
              ),
            ),
            if (!controller.isLoading)
              Expanded(
                child: ListView.builder(
                  itemCount: controller.categorias.length,
                  itemBuilder: (context, index) {
                    final categoria = controller.categorias[index];
                    return CategoriaItem(
                      text: categoria.nome,
                      deleteCategoria: () => _deleteCategoria(categoria),
                      updateCategoria: () => _editarCategoria(categoria),
                    );
                  },
                ),
              ),
            if (controller.isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
