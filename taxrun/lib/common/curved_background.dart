import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:taxrun/common/image_utils.dart';

class CurvedBackground extends StatefulWidget {
  const CurvedBackground({
    Key? key,
    required this.title,
    required this.body,
  }) : super(key: key);

  final String title;
  final Widget body;

  @override
  _CurvedBackgroundState createState() => _CurvedBackgroundState();
}

class _CurvedBackgroundState extends State<CurvedBackground> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: HexColor("0DC5AF"),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //transform: Matrix4.translationValues(0.0, -50.0, 0.0),
              Transform.translate(
                offset: const Offset(-10, 0),
                child: CustomPaint(
                  size: const Size(453, 363.9530029296875),
                  painter: RPSCustomPainter(),
                ),
              ),

              Transform.translate(
                offset: const Offset(10, 24),
                child: Transform.rotate(
                  angle: 180 * pi / 180,
                  child: CustomPaint(
                    size: const Size(453, 363.9530029296875),
                    painter: RPSCustomPainter(),
                  ),
                ),
              )
            ],
          ),
          Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              leadingWidth: 48,
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: SvgPicture.asset(
                    SvgImages.imageBack,
                  ),
                ),
              ),
              title: Text(
                widget.title,
                style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Inter',
                    fontSize: 24,
                    letterSpacing:
                        0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.w600),
              ),
              centerTitle: true,
            ),
            backgroundColor: Colors.transparent,
            body: widget.body,
          ),
        ],
      ),
    );
  }
}

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(0, 276);
    path_0.cubicTo(12, 283, -27, 463, 64, 287);
    path_0.cubicTo(155, 111, 352, 307.99999237060547, 453, 100.99999237060547);
    path_0.lineTo(453, 0);
    path_0.cubicTo(441, 0, 224, 0, 224, 0);
    path_0.lineTo(12, 0);
    path_0.lineTo(12, 125.9999771118164);
    path_0.lineTo(6.000000476837158, 226.99996948242188);
    path_0.lineTo(0, 276);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = HexColor("FF02B49F");

    canvas.drawPath(path_0, paint0Fill);
    /*   canvas.save();
    canvas.translate(500.0, 500.0);
    canvas.restore();*/
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
