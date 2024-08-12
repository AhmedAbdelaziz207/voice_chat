import 'package:flutter/material.dart';

extension DialogExtensions on BuildContext {
    void showAlertDialog({required String title, required String contentMessage}) {

         Widget okButton = TextButton(
            child: const Text("OK"),
            onPressed: () {
                Navigator.of(this).pop(); // Close the dialog
            },
        );

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
