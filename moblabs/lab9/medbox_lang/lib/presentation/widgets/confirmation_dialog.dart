import 'package:flutter/material.dart';
import 'package:medbox/presentation/widgets/progress_button.dart';

import '../themes/constants.dart';

enum DialogBoxType { confirm, delete, danger, info }

class MyConfirmationDialog extends StatelessWidget {
  final String labelConfirm = 'Confirm';
  final String labelClose = 'Close';
  final DialogBoxType dialogType;

  final String title;
  final String message;

  final Function() onConfirm;
  final Function() onClose;

  const MyConfirmationDialog({
    this.dialogType = DialogBoxType.confirm,
    required this.title,
    required this.message,
    required this.onConfirm,
    required this.onClose,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDanger =
        dialogType == DialogBoxType.delete ||
        dialogType == DialogBoxType.danger;
    final Color accentColor = isDanger ? Colors.red : Colors.blue;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Title Bar with colored background
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: accentColor.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  isDanger ? Icons.warning_amber_rounded : Icons.info_outline,
                  color: accentColor,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: isDanger ? redBigTextStyle : blueBigTextStyle,
                  ),
                ),
              ],
            ),
          ),

          // Message Content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              message,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
          ),

          // Action Buttons
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Close/Cancel Button
                TextButton(
                  onPressed: () async {
                    await onClose();
                    if (Navigator.of(context).canPop()) {
                      Navigator.of(context).pop();
                    }
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                  child: Text(
                    labelClose,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),

                const SizedBox(width: 12),

                // Confirm Button
                if (dialogType == DialogBoxType.confirm || isDanger)
                  MyProgressButton(
                    onPressed: () async {
                      var result = await onConfirm();
                      if (Navigator.of(context).canPop()) {
                        Navigator.of(context).pop();
                      }
                      return result;
                    },
                    label: labelConfirm,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
