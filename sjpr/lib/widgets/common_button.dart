import 'package:flutter/material.dart';
import '../common/app_theme.dart';

class CommonButton extends StatelessWidget {
  final String content;
  final Color bgColor;
  final Color textColor;
  final Color outlinedBorderColor;
  final VoidCallback onPressed;
  final double? borderRadius;
  final double? height;
  final double? textFontSize;
  const CommonButton(
      {super.key,
      required this.content,
      required this.bgColor,
      required this.textColor,
      required this.outlinedBorderColor,
      required this.onPressed,
      this.borderRadius,
      this.textFontSize,
      this.height});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        height: height ?? 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius ?? 8),
            color: bgColor,
            border: Border.all(color: outlinedBorderColor)),
        child: Center(
          child: Text(
            content,
            style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: textFontSize ?? 18),
          ),
        ),
      ),
    );
  }
}

class PinkBorderButton extends StatefulWidget {
  const PinkBorderButton({
    super.key,
    required this.isEnabled,
    required this.content,
    required this.onPressed,
  });

  final String content;
  final bool isEnabled;
  final VoidCallback? onPressed;

  @override
  PinkBorderButtonState createState() => PinkBorderButtonState();
}

class PinkBorderButtonState extends State<PinkBorderButton> {
  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return OutlinedButton(
        onPressed: widget.onPressed,
        style: OutlinedButton.styleFrom(
            side: BorderSide(color: appTheme.primaryColor, width: 1),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            (widget.content),
            textAlign: TextAlign.center,
            style: TextStyle(color: appTheme.primaryColor),
          ),
        ));
  }
}
