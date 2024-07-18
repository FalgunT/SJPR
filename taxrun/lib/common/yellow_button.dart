import 'package:flutter/material.dart';

/*
class YellowButton extends StatefulWidget {
  const YellowButton({
    Key? key,
    required this.isEnabled,
    required this.content,
    required this.onPressed,
  }) : super(key: key);

  final String content;
  final bool isEnabled;
  final VoidCallback? onPressed;

  @override
  _YellowButtonState createState() => _YellowButtonState();
}

class _YellowButtonState extends State<YellowButton> {
  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return OutlinedButton(
        onPressed: widget.onPressed,
        style: OutlinedButton.styleFrom(
            side: const BorderSide(
                color: Color.fromRGBO(235, 191, 90, 1), width: 1),
            backgroundColor: const Color.fromRGBO(235, 191, 90, 1),
            shadowColor: const Color.fromRGBO(0, 0, 0, 0.25),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            )),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            (widget.content),
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Color.fromRGBO(12, 0, 0, 1),
                fontFamily: 'Inter',
                fontSize: 20,
                letterSpacing:
                    0 */ /*percentages not used in flutter. defaulting to zero*/ /*,
                fontWeight: FontWeight.normal),
          ),
        ));
  }
}*/

class YellowButton extends StatefulWidget {
  const YellowButton({
    Key? key,
    required this.isEnabled,
    required this.content,
    required this.onPressed,
  }) : super(key: key);

  final String content;
  final bool isEnabled;
  final VoidCallback onPressed;

  @override
  _YellowButtonState createState() => _YellowButtonState();
}

class _YellowButtonState extends State<YellowButton> {
  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator DriverWidget - GROUP

    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
          //margin: const EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          color: Colors.transparent,
          //height: 50,
          child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.25),
                      offset: Offset(0, 4),
                      blurRadius: 4)
                ],
                color: Color.fromRGBO(235, 191, 90, 1),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Text(
                  (widget.content),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Color.fromRGBO(12, 0, 0, 1),
                      fontFamily: 'Inter',
                      fontSize: 20,
                      letterSpacing:
                          0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.normal),
                ),
              ))),
    );
  }
}
