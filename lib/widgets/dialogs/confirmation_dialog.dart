import 'package:flutter/material.dart';

Future<bool> showConfirmationDialog(
    BuildContext context, String message) async {
  return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(message),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text('No')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text('Yes')),
          ],
        );
      }).then((value) => value ?? false);
}
