import 'package:flutter/material.dart';

class TextFormWidget extends StatelessWidget {
  final String name;
  final int maxLines;
  final TextEditingController controller;
  const TextFormWidget({Key? key, required this.name, required this.maxLines, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) => value!.isEmpty ? "please fill the $name" : null,
      decoration: InputDecoration(
        hintText: name,
      ),
      maxLines: maxLines,
    );
  }
}
