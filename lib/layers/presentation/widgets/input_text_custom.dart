import 'package:flutter/material.dart';

class InputTextCustom extends StatelessWidget {
  final TextEditingController controller;
  final ColorScheme colorScheme;
  final String text;
  final bool? isMeiaLinha;
  final bool? isNumber;
  final int? numeroLinhas;

  const InputTextCustom({
    super.key,
    required this.controller,
    required this.colorScheme,
    required this.text,
    this.isMeiaLinha = false,
    this.isNumber = false,
    this.numeroLinhas = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isMeiaLinha == true
          ? const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0)
          : const EdgeInsetsDirectional.fromSTEB(14, 24, 14, 0),
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
            child: SizedBox(
              width: 200,
              child: TextFormField(
                textAlignVertical: TextAlignVertical.top,
                minLines: numeroLinhas,
                maxLines: numeroLinhas,
                style: TextStyle(color: colorScheme.onSurface),
                keyboardType: isNumber == true
                    ? TextInputType.number
                    : TextInputType.text,
                controller: controller,
                autofocus: false,
                obscureText: false,
                decoration: InputDecoration(
                  isDense: true,
                  labelText: text,
                  alignLabelWithHint: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0x00000000),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0x00000000),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: colorScheme.error,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: colorScheme.error,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                cursorColor: colorScheme.primary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
