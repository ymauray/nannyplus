import 'package:flutter/material.dart';

extension SnackBarUtil on ScaffoldMessengerState {
  void success(String message) {
    hideCurrentSnackBar();
    showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Text(message),
      ),
    );
  }

  void failure(String message) {
    hideCurrentSnackBar();
    showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(message),
      ),
    );
  }
}
