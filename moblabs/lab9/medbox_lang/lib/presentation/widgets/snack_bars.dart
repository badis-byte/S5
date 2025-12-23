import 'package:flutter/material.dart';

import '../themes/constants.dart';

class MySnackBar extends SnackBar {
  MySnackBar({required super.content});

  static void success(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 2),
    bool clearOtherSnakBeforShow = true,
  }) {
    if (clearOtherSnakBeforShow) {
      ScaffoldMessenger.of(context).clearSnackBars();
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: greenButtonColor,
        content: Text(message),
        duration: duration ?? Duration(seconds: 2),
      ),
    );
  }

  static void error(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 6),
    bool clearOtherSnakBeforShow = true,
  }) {
    if (clearOtherSnakBeforShow) {
      ScaffoldMessenger.of(context).clearSnackBars();
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: redButtonColor,
        content: Text(message),
        duration: duration ?? Duration(seconds: 2),
      ),
    );
  }
}
