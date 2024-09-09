import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sjpr/utils/color_utils.dart';

import '../common/app_theme.dart';

class CommonNumberField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool? isPassword;
  final String? Function(String?)? validation;
  const CommonNumberField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.isPassword,
      this.validation});

  @override
  State<CommonNumberField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonNumberField> {
  late bool _passwordVisible;
  @override
  void initState() {
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: appTheme.textFieldBgColor),
      child: TextFormField(
        validator: widget.validation,
        keyboardType: TextInputType.number, // Numeric keyboard
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly, // Only allows digits
        ],
        cursorColor: appTheme.textColor,
        controller: widget.controller,
        style: TextStyle(color: appTheme.textColor),
        obscureText: widget.isPassword == true ? !_passwordVisible : false,
        enableSuggestions: !(widget.isPassword ?? false),
        autocorrect: !(widget.isPassword ?? false),
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(color: appTheme.textColor),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          suffixIcon: widget.isPassword == true
              ? IconButton(
                  icon: Icon(
                    // Based on passwordVisible state choose the icon
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: buttonBgColor,
                  ),
                  onPressed: () {
                    // Update the state i.e. toggle the state of passwordVisible variable
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }
}
