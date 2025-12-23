import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:medbox/presentation/widgets/snack_bars.dart';

import '../../data/models/Result.dart';

class MyProgressButton extends StatefulWidget {
  final String label;
  final String buttonType;
  final Function() onPressed;
  const MyProgressButton({
    this.buttonType = 'action',
    required this.label,
    required this.onPressed,
    super.key,
  });

  @override
  State<MyProgressButton> createState() => _MyProgressButtonState();
}

class _MyProgressButtonState extends State<MyProgressButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final Color accentColor =
        widget.buttonType == 'danger' ? Colors.red : Colors.blue;

    return FilledButton(
      onPressed: handleButtonPress,
      style: ElevatedButton.styleFrom(
        backgroundColor: accentColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 0,
      ),
      child:
          isLoading
              ? CircularProgressIndicator(
                color: Colors.white,
                constraints: BoxConstraints(minHeight: 20, minWidth: 20),
                strokeWidth: 2,
              )
              : Text(
                widget.label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
    );
  }

  Future<bool> handleButtonPress() async {
    if (!isLoading) {
      try {
        setState(() {
          isLoading = true;
        });
        ReturnResult result = await widget.onPressed();

        if (widget.buttonType != 'silent' && result.message.length > 0)
          if (result.state)
            MySnackBar.success(context, result.message);
          else
            MySnackBar.error(context, result.message);
      } catch (e, trace) {
        print('$trace');
        MySnackBar.error(context, 'Operation Failed.. ${e.toString()}');
      }
      setState(() {
        isLoading = false;
      });
    }
    return true;
  }
}
