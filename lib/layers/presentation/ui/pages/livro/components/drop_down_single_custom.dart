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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: DropdownButton<StatusLeitura>(
                iconSize: 24,
                value: statusAtual,
                icon: const Icon(Icons.keyboard_arrow_down_rounded),
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: colorScheme.onSurface),
                underline: Container(
                  color: colorScheme.onPrimary,
                ),
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}
