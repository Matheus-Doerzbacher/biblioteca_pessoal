import 'package:biblioteca_pessoal/layers/domain/entities/livro_entity.dart';
import 'package:flutter/material.dart';

class LivroCard extends StatelessWidget {
  final Livro livro;
  final BuildContext context;
  final bool isPesquisa;

  const LivroCard(
      {super.key,
      required this.livro,
      required this.context,
      this.isPesquisa = false});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
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
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
              color: colorScheme.surface,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                child: Image.network(
                  livro.urlImage.isNotEmpty
                      ? livro.urlImage
                      : 'https://cdn.pixabay.com/photo/2017/08/11/09/11/books-2630076_1280.jpg',
                  height: 200,
                  width: double.infinity,
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        livro.titulo.length > 20
                            ? '${livro.titulo.substring(0, 20)}...'
                            : livro.titulo,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Text(
                        livro.autor.length > 20
                            ? '${livro.autor.substring(0, 20)}...'
                            : livro.autor,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                      ),
                      if (!isPesquisa)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: colorScheme.secondaryContainer,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                child: Text(livro.statusName),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: const Icon(
                                Icons.bookmark_outlined,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
