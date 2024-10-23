import 'package:biblioteca_pessoal/core/routes/app_routes.dart';
import 'package:biblioteca_pessoal/layers/presentation/controllers/user_controller.dart';
import 'package:biblioteca_pessoal/layers/presentation/widgets/drawer_custom/drawer_item.dart';
import 'package:biblioteca_pessoal/layers/presentation/widgets/logo_app.dart';
import 'package:flutter/material.dart';

class DrawerCustom extends StatelessWidget {
  final String namePageActive;
  const DrawerCustom({super.key, required this.namePageActive});

  @override
  Widget build(BuildContext context) {
    final colorSchema = Theme.of(context).colorScheme;
    final user = UserController.user;

    return Drawer(
      backgroundColor: colorSchema.surface,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 64, 16, 16),
        child: Column(
          children: [
            Expanded(
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
                    namePage: AppRoutes.home,
                    namePageActive: namePageActive,
                    text: 'Meus Livros',
                  ),
                  DrawerItem(
                    namePage: AppRoutes.livro.adicionar,
                    namePageActive: namePageActive,
                    icon: Icons.add_circle_outline,
                    text: 'Adicionar um livro',
                  ),
                  DrawerItem(
                    namePage: AppRoutes.categoria,
                    namePageActive: namePageActive,
                    icon: Icons.category,
                    text: 'Categorias',
                  ),
                  DrawerItem(
                    namePage: AppRoutes.emprestimo.base,
                    namePageActive: namePageActive,
                    icon: Icons.book,
                    text: 'Emprestimos',
                  ),
                ],
              ),
            ),
            Column(
              children: [
                const Divider(),
                const SizedBox(height: 8),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundImage: NetworkImage(
                        user!.photoURL ?? '',
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            user.displayName ?? '',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            user.email ?? '',
                            style: const TextStyle(fontSize: 9),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        UserController.signOut(context);
                      },
                      icon: const Icon(Icons.logout),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
