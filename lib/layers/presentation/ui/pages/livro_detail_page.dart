import 'package:biblioteca_pessoal/layers/domain/entities/livro_entity.dart';
import 'package:biblioteca_pessoal/layers/presentation/controllers/livro_controller.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class LivroDetailPage extends StatefulWidget {
  final Livro livro;
  const LivroDetailPage({super.key, required this.livro});

  @override
  State<LivroDetailPage> createState() => _LivroDetailPageState();
}

class _LivroDetailPageState extends State<LivroDetailPage> {
  final LivroController controller = GetIt.instance<LivroController>();
  @override
  Widget build(BuildContext context) {
    final livro = widget.livro;
    return Scaffold(
      appBar: AppBar(
        title: Text(livro.titulo),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Container(
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).colorScheme.error,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.shadow,
                      offset: const Offset(0, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    livro.urlImage.isNotEmpty
                        ? livro.urlImage
                        : 'https://cdn.pixabay.com/photo/2017/08/11/09/11/books-2630076_1280.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                livro.titulo,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                livro.autor,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
              ),
              if (livro.avaliacao > 0) const SizedBox(height: 24),
              if (livro.avaliacao > 0)
                RatingBar.readOnly(
                  filledIcon: Icons.star,
                  emptyIcon: Icons.star_border,
                  initialRating: livro.avaliacao.toDouble(),
                  alignment: Alignment.center,
                ),
              const SizedBox(height: 24),
              Text(
                livro.descricao,
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),
              if (livro.isPesquisa)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          foregroundColor:
                              Theme.of(context).colorScheme.onPrimary,
                        ),
                        onPressed: () async {
                          await controller.createLivro(livro);
                          if (context.mounted) {
                            await Navigator.of(context)
                                .pushReplacementNamed('/');
                          }
                        },
                        child: const Text('Adicionar a minha biblioteca'),
                      ),
                    ),
                  ],
                )
              else
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.error,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              foregroundColor:
                                  Theme.of(context).colorScheme.onError,
                            ),
                            onPressed: () async {
                              await controller.deleteLivro(livro.id!);
                              if (context.mounted) {
                                await Navigator.of(context)
                                    .pushReplacementNamed('/');
                              }
                            },
                            child: const Text(
                              'Deletar o livro da minha biblioteca',
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.secondary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              foregroundColor:
                                  Theme.of(context).colorScheme.onError,
                            ),
                            onPressed: () async {
                              if (context.mounted) {
                                await Navigator.of(context)
                                    .pushReplacementNamed(
                                  '/adicionar-manual',
                                  arguments: livro,
                                );
                              }
                            },
                            child: const Text(
                              'Editar o livro',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}