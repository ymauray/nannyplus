import 'package:flutter/material.dart';

extension SnackBarUtil on ScaffoldMessengerState {
  void success(String message) {
    showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Text(message),
      ),
    );
  }

  void failure(String message) {
    showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(message),
      ),
    );
  }
}
