import 'package:flutter/material.dart';
import 'package:sjpr/screen/lineitems/line_items_bloc.dart';
import 'package:sjpr/utils/color_utils.dart';
import 'package:sjpr/widgets/common_button.dart';
import '../common/app_theme.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  DeleteConfirmationDialog({
    super.key,
    required this.label,
    required this.onPressed,
    this.desc = "Are you sure you want to delete this item?",
  });

  final String label;
  String desc;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: listTileBgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.warning_amber_rounded, color: activeTxtColor, size: 50),
            const SizedBox(height: 24),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              desc,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            CommonButton(
                textFontSize: 16,
                content: "Continue",
                bgColor: buttonBgColor,
                textColor: buttonTextColor,
                outlinedBorderColor: buttonBgColor,
                onPressed: onPressed),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                'Cancel',
                style: TextStyle(fontSize: 16, color: activeTxtColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
