import 'package:flutter/material.dart';

class FormSubmitBtn extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final void Function() onPressed;
  final bool isUpdate;
  // ignore: prefer_typing_uninitialized_variables

  const FormSubmitBtn({
    super.key,
    required this.onPressed,
    required this.isUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: isUpdate ? const Icon(Icons.edit) : const Icon(Icons.add),
      label: isUpdate ? const Text("Update") : const Text("Add"),
    );
  }
}
