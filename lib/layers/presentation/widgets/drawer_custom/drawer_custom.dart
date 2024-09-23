import 'package:biblioteca_pessoal/layers/presentation/widgets/drawer_custom/drawer_item.dart';
import 'package:biblioteca_pessoal/layers/presentation/widgets/logo_app.dart';
import 'package:flutter/material.dart';

class DrawerCustom extends StatelessWidget {
  final String namePageActive;
  const DrawerCustom({super.key, required this.namePageActive});

  @override
  Widget build(BuildContext context) {
    final colorSchema = Theme.of(context).colorScheme;

    return Drawer(
      backgroundColor: colorSchema.surface,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 64, 16, 16),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.menu_book,
                  size: 32,
                  color: colorSchema.primary,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: LogoApp(size: 24),
                ),
              ],
            ),
            const SizedBox(height: 12),
            DrawerItem(
              icon: Icons.dashboard_rounded,
              namePage: '/',
              namePageActive: namePageActive,
              text: 'Meus Livros',
            ),
            DrawerItem(
              namePage: '/adicionar',
              namePageActive: namePageActive,
              icon: Icons.add_circle_outline,
              text: 'Adicionar um livro',
            ),
            DrawerItem(
              namePage: '/categoria',
              namePageActive: namePageActive,
              icon: Icons.category,
              text: 'Categorias',
            ),
          ],
        ),
      ),
    );
  }
}
