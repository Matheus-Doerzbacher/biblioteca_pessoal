import 'package:biblioteca_pessoal/layers/domain/entities/categoria_entity.dart';
import 'package:flutter/material.dart';
import 'package:multi_dropdown/multi_dropdown.dart';

class DropDownMultiCustom extends StatelessWidget {
  final ColorScheme colorScheme;
  final Function(List<Categoria>) alterarCategorias;
  final List<Categoria> categoriasSelecionadas;
  final List<Categoria> categorias;
  final MultiSelectController<Categoria> multiSelectController;

  const DropDownMultiCustom({
    super.key,
    required this.colorScheme,
    required this.alterarCategorias,
    required this.categoriasSelecionadas,
    required this.categorias,
    required this.multiSelectController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(14, 0, 14, 0),
      child: Container(
        decoration: const BoxDecoration(),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
          child: Container(
            width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
              color: colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  blurRadius: 4,
                  color: colorScheme.shadow,
                  offset: const Offset(
                    2,
                    2,
                  ),
                )
              ],
              borderRadius: BorderRadius.circular(8),
            ),
            child: MultiDropdown<Categoria>(
              items: categorias.map((categoria) {
                return DropdownItem(
                  label: categoria.nome,
                  value: categoria,
                );
              }).toList(),
              controller: multiSelectController,
              enabled: true,
              fieldDecoration: FieldDecoration(
                suffixIcon: const Icon(Icons.keyboard_arrow_down),
                hintText: 'Categorias',
                hintStyle: TextStyle(color: colorScheme.onSurface),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0x00000000),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0x00000000),
                  ),
                ),
              ),
              dropdownDecoration: DropdownDecoration(
                backgroundColor: colorScheme.surface,
                marginTop: 2,
                maxHeight: 300,
              ),
              dropdownItemDecoration: DropdownItemDecoration(
                selectedIcon: const Icon(Icons.check_box, color: Colors.green),
                backgroundColor: colorScheme.surfaceContainer,
                selectedBackgroundColor: colorScheme.surfaceContainer,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, selecione uma categoria';
                }

                return null;
              },
              onSelectionChange: (selectedItems) {
                alterarCategorias(selectedItems);
              },
            ),
          ),
        ),
      ),
    );
  }
}
