import 'package:biblioteca_pessoal/core/routes/app_routes.dart';
import 'package:biblioteca_pessoal/core/widgets/drawer_custom/drawer_custom.dart';
import 'package:biblioteca_pessoal/modules/categoria/controllers/categoria_controller.dart';
import 'package:biblioteca_pessoal/modules/categoria/models/categoria.dart';
import 'package:biblioteca_pessoal/modules/categoria/views/components/categoria_item.dart';
import 'package:biblioteca_pessoal/modules/usuario/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CategoriaPage extends StatefulWidget {
  const CategoriaPage({super.key});

  @override
  State<CategoriaPage> createState() => _CategoriaPageState();
}

class _CategoriaPageState extends State<CategoriaPage> {
  final user = UserController.user;
  final CategoriaController controller = Modular.get<CategoriaController>();
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _editController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getCategorias(UserController.user?.uid ?? '').then((_) {
        if (mounted) setState(() {});
      });
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _editController.dispose();
    super.dispose();
  }

  Future<void> _adicionarCategoria() async {
    if (_textController.text.isNotEmpty) {
      await controller.createCategoria(
        Categoria(nome: _textController.text, uidUsuario: user!.uid),
      );
      _textController.clear();
      setState(() {});
    }
  }

  Future<void> _deleteCategoria(Categoria categoria) async {
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
                const InputDecoration(hintText: 'Novo nome da categoria'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Modular.to.pop();
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
      Modular.to.pop();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final controllerWatch = context.watch<CategoriaController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorias'),
        centerTitle: true,
      ),
      drawer: const DrawerCustom(namePageActive: AppRoutes.categoria),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 24, 24, 0),
        child: Column(
          children: [
            // Input adicionar Tarefas
            _inputAdicionarTarefa(context, colorScheme),
            if (controllerWatch.isLoading)
              const Center(
                child: CircularProgressIndicator(),
              )
            else
              // Lista de Tarefas
              Expanded(
                child: controllerWatch.categorias.isNotEmpty
                    ? ListView.builder(
                        padding: const EdgeInsets.only(top: 8),
                        itemCount: controllerWatch.categorias.length,
                        itemBuilder: (context, index) {
                          final categoria = controllerWatch.categorias[index];
                          return CategoriaItem(
                            text: categoria.nome,
                            deleteCategoria: () => _deleteCategoria(categoria),
                            updateCategoria: () => _editarCategoria(categoria),
                          );
                        },
                      )
                    : const Center(child: Text('Insira algumas categorias')),
              ),
          ],
        ),
      ),
    );
  }

  Widget _inputAdicionarTarefa(BuildContext context, ColorScheme colorScheme) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: _textController,
            decoration: InputDecoration(
              isDense: true,
              hintText: 'Nome da Categoria',
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
              filled: true,
              fillColor: colorScheme.surfaceContainer,
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
    );
  }
}
