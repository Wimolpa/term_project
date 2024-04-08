import 'package:flutter/material.dart';

Future showOkDialog({
  required BuildContext context,
  required String title,
  required String status,
}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(status),
        
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      );
    },
  );
}
