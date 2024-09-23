import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SelecionarFotoWidget extends StatefulWidget {
  final void Function(File imagem) onImagePick;
  const SelecionarFotoWidget({super.key, required this.onImagePick});

  @override
  State<SelecionarFotoWidget> createState() => _SelecionarFotoWidgetState();
}

class _SelecionarFotoWidgetState extends State<SelecionarFotoWidget> {
  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
      maxWidth: 500,
    );

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });

      widget.onImagePick(_image!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Container(
          height: 120,
          width: 80,
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(8),
            image: _image != null
                ? DecorationImage(image: FileImage(_image!), fit: BoxFit.cover)
                : null,
          ),
        ),
        TextButton.icon(
          onPressed: _pickImage,
          label: const Text('Adicionar Imagem'),
          icon: const Icon(Icons.image),
        ),
      ],
    );
  }
}
