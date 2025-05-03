import 'package:flutter/material.dart';
import 'package:sippy_ca/main.dart';

class DialogServices {
  void showMessage(message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.green,
      duration: const Duration(seconds: 2),
    );
    rootScaffoldMessengerKey.currentState?.showSnackBar(snackBar);
  }

  void showMessageError(message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 2),
    );
    rootScaffoldMessengerKey.currentState?.showSnackBar(snackBar);
  }

  void showMessageWithDuration(message, int seconds, Color color) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      backgroundColor: color,
      duration: Duration(seconds: seconds),
    );
    rootScaffoldMessengerKey.currentState?.showSnackBar(snackBar);
  }

  void showMessageWithActionAndDuration(String message, Function action,
      String label, Color color, int duration) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: color,
      duration: Duration(seconds: duration),
      action: SnackBarAction(
          textColor: Colors.white, label: label, onPressed: () => action()),
    );
    rootScaffoldMessengerKey.currentState?.showSnackBar(snackBar);
  }

  void showMessageWithButton(message, action) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 4),
      action: SnackBarAction(
        textColor: Colors.white,
        label: 'Verify',
        onPressed: () {
          action();
        },
      ),
    );
    rootScaffoldMessengerKey.currentState?.showSnackBar(snackBar);
  }
}
