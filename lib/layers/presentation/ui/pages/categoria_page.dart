import 'package:biblioteca_pessoal/layers/domain/entities/categoria_entity.dart';
import 'package:biblioteca_pessoal/layers/presentation/controllers/categoria_controller.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CategoriaPage extends StatefulWidget {
  const CategoriaPage({super.key});

  @override
  State<CategoriaPage> createState() => _CategoriaPageState();
}

class _CategoriaPageState extends State<CategoriaPage> {
  late CategoriaController controller;
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _editController = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller = GetIt.I.get<CategoriaController>();
  }

  @override
  void dispose() {
    _textController.dispose();
    _editController.dispose();
    super.dispose();
  }

  void _adicionarCategoria() async {
    if (_textController.text.isNotEmpty) {
      await controller.createCategoria(Categoria(nome: _textController.text));
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
        Categoria(id: categoria.id, nome: _editController.text));
    if (mounted) {
      Navigator.of(context).pop();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorias'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Nova Categoria',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _adicionarCategoria,
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<void>(
              future: controller.getCategorias(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erro: ${snapshot.error}'));
                } else {
                  return ListView.builder(
                    itemCount: controller.categorias.length,
                    itemBuilder: (context, index) {
                      final categoria = controller.categorias[index];
                      return ListTile(
                        title: Text(categoria.nome),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                _editarCategoria(categoria);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                _deleteCategoria(categoria);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
