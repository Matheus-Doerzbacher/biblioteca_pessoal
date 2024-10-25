import 'package:biblioteca_pessoal/layers/domain/entities/livro_entity.dart';
import 'package:flutter/material.dart';

class DropDownSingleCustom extends StatelessWidget {
  final ColorScheme colorScheme;
  final Function(StatusLeitura) alterarStatus;
  final StatusLeitura statusAtual;

  const DropDownSingleCustom({
    super.key,
    required this.colorScheme,
    required this.alterarStatus,
    required this.statusAtual,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return DropdownButtonFormField<StatusLeitura>(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: colorScheme.surfaceContainer,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      borderRadius: BorderRadius.circular(24),
      dropdownColor: colorScheme.surfaceContainer,
      value: statusAtual,
      icon: const Icon(Icons.keyboard_arrow_down_rounded),
      onChanged: (StatusLeitura? newValue) {
        if (newValue != null) {
          alterarStatus(newValue);
        }
      },
      items: const <DropdownMenuItem<StatusLeitura>>[
        DropdownMenuItem<StatusLeitura>(
          value: StatusLeitura.lendo,
          child: Text('Lendo'),
        ),
        DropdownMenuItem<StatusLeitura>(
          value: StatusLeitura.lido,
          child: Text('Lido'),
        ),
        DropdownMenuItem<StatusLeitura>(
          value: StatusLeitura.queroLer,
          child: Text('Quero ler'),
        ),
      ],
      isExpanded: true,
    );
  }
}
