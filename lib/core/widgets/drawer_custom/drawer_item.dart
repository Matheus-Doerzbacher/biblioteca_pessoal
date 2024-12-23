import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DrawerItem extends StatelessWidget {
  final String namePage;
  final String namePageActive;
  final IconData icon;
  final String text;
  const DrawerItem({
    super.key,
    required this.namePage,
    required this.namePageActive,
    required this.icon,
    required this.text,
  });

  bool isActive() {
    return (namePage == namePageActive);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () => Modular.to.navigate(namePage),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: isActive() ? colorScheme.surfaceContainer : null,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Icon(
                icon,
                color: isActive()
                    ? colorScheme.primary
                    : colorScheme.onSurfaceVariant,
                size: 28,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                child: Text(
                  text,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
