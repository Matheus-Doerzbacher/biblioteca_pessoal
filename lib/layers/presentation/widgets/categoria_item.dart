import 'package:flutter/material.dart';

class CategoriaItem extends StatelessWidget {
  final String text;
  final void Function() deleteCategoria;
  final void Function() updateCategoria;
  const CategoriaItem({
    super.key,
    required this.text,
    required this.deleteCategoria,
    required this.updateCategoria,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Container(
              width: 100,
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainer,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4,
                    color: colorScheme.shadow,
                    offset: const Offset(
                      0,
                      2,
                    ),
                  )
                ],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(8, 4, 4, 4),
                child: Container(
                  decoration: const BoxDecoration(),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(text),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: colorScheme.inversePrimary,
                              size: 24,
                            ),
                            onPressed: () {
                              updateCategoria();
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.delete_forever,
                              color: colorScheme.error,
                              size: 24,
                            ),
                            onPressed: () {
                              deleteCategoria();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
