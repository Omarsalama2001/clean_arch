import 'package:flutter/material.dart';

class SnackBarMessage {
  static void showSnackBar(SnackBarTypes snackBarTypes, String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: snackBarTypes == SnackBarTypes.SUCCESS ? Colors.greenAccent : Colors.redAccent,
    ));
  }
}

enum SnackBarTypes {
  // ignore: constant_identifier_names
  SUCCESS,
  ERORR;
}
