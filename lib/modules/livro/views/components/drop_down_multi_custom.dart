import 'package:biblioteca_pessoal/modules/categoria/models/categoria.dart';
import 'package:flutter/material.dart';
import 'package:multi_dropdown/multi_dropdown.dart';

class DropDownMultiCustom extends StatelessWidget {
  final Function(List<Categoria>) alterarCategorias;
  final List<Categoria> categoriasSelecionadas;
  final List<Categoria> categorias;
  final MultiSelectController<Categoria> multiSelectController;

  const DropDownMultiCustom({
    super.key,
    required this.alterarCategorias,
    required this.categoriasSelecionadas,
    required this.categorias,
    required this.multiSelectController,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(14, 0, 14, 0),
      child: MultiDropdown<Categoria>(
        items: categorias.map((categoria) {
          return DropdownItem(
            label: categoria.nome,
            value: categoria,
          );
        }).toList(),
        controller: multiSelectController,
        fieldDecoration: FieldDecoration(
          suffixIcon: const Icon(Icons.keyboard_arrow_down),
          hintText: 'Categorias',
          backgroundColor: colorScheme.surfaceContainer,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
        ),
        chipDecoration: ChipDecoration(
          backgroundColor: colorScheme.tertiary,
          labelStyle: TextStyle(
            color: colorScheme.onTertiary,
          ),
        ),
        dropdownDecoration: DropdownDecoration(
          backgroundColor: colorScheme.surfaceContainer,
          elevation: 10,
        ),
        dropdownItemDecoration: DropdownItemDecoration(
          selectedIcon: Icon(Icons.check_box, color: colorScheme.onTertiary),
          selectedBackgroundColor: colorScheme.tertiary,
          selectedTextColor: colorScheme.onTertiary,
        ),
        onSelectionChange: alterarCategorias,
      ),
    );
  }
}
