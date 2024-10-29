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
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: TextStyle(color: colorScheme.onSurfaceVariant),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.edit,
                color: colorScheme.inversePrimary,
                size: 24,
              ),
              onPressed: updateCategoria,
            ),
            IconButton(
              icon: Icon(
                Icons.delete_forever,
                color: colorScheme.error,
                size: 24,
              ),
              onPressed: deleteCategoria,
            ),
          ],
        ),
      ),
    );
  }
}
