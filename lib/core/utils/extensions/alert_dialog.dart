import 'package:flutter/material.dart';

// Define the extension on BuildContext
extension DialogExtensions on BuildContext {
  void showAlertDialog({required String title, required String contentMessage}) {
    // Set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(this).pop(); // Close the dialog
      },
    );

    // Set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title:  Text(title),
      content:  Text(contentMessage),
      actions: [
        okButton,
      ],
    );

    // Show the dialog
    showDialog(
      context: this,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
