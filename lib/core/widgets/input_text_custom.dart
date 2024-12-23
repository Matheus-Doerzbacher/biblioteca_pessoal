import 'package:flutter/material.dart';

class InputTextCustom extends StatelessWidget {
  final TextEditingController controller;
  final ColorScheme colorScheme;
  final String text;
  final bool? isMeiaLinha;
  final bool? isNumber;
  final int? numeroLinhas;
  final FormFieldValidator? validator;

  const InputTextCustom({
    super.key,
    required this.controller,
    required this.colorScheme,
    required this.text,
    this.isMeiaLinha = false,
    this.isNumber = false,
    this.numeroLinhas = 1,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isMeiaLinha == true
          ? EdgeInsetsDirectional.zero
          : const EdgeInsetsDirectional.fromSTEB(14, 24, 14, 0),
      child: TextFormField(
        validator: validator,
        textAlignVertical: TextAlignVertical.top,
        minLines: numeroLinhas,
        maxLines: numeroLinhas,
        keyboardType:
            isNumber == true ? TextInputType.number : TextInputType.text,
        controller: controller,
        decoration: InputDecoration(
          isDense: true,
          labelText: text,
          filled: true,
          fillColor: colorScheme.surfaceContainer,
          alignLabelWithHint: true,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        cursorColor: colorScheme.primary,
      ),
    );
  }
}
