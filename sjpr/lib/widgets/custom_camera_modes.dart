import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sjpr/utils/color_utils.dart';
import 'package:sjpr/utils/image_utils.dart';

class CustomCameraModes extends StatelessWidget {
  const CustomCameraModes({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Container(
        width: constraints.maxWidth,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(0),
          ),
          color: textFieldBgColor, //Color.fromRGBO(0, 0, 0, 0.5),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
                width: 86,
                height: 4,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4),
                      topRight: Radius.circular(4),
                      bottomLeft: Radius.circular(4),
                      bottomRight: Radius.circular(4),
                    ),
                    color: Colors.black //Color.fromRGBO(44, 45, 51, 1),
                    )),
            const SizedBox(height: 32),
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(100),
                  topRight: Radius.circular(100),
                  bottomLeft: Radius.circular(100),
                  bottomRight: Radius.circular(100),
                ),
                color: activeTxtColor,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Camera modes ',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: 'Inter',
                        fontSize: 14,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.w700,
                        height: 1),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Container(
              decoration: const BoxDecoration(),
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    decoration: const BoxDecoration(),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SvgPicture.asset(
                          SvgImages.single,
                          color: activeTxtColor,
                        ),
                        const SizedBox(width: 16),
                        Container(
                          decoration: const BoxDecoration(),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Single mode',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: activeTxtColor,
                                    fontFamily: 'Inter',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'A single receipt or invoice',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color.fromRGBO(212, 212, 212, 1),
                                  fontFamily: 'Inter',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    decoration: const BoxDecoration(),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SvgPicture.asset(
                          SvgImages.multiple,
                          color: activeTxtColor,
                        ),
                        const SizedBox(width: 16),
                        Container(
                          decoration: const BoxDecoration(),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Multiple mode',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: activeTxtColor,
                                    fontFamily: 'Inter',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'Multiple receipts or invoices',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color.fromRGBO(212, 212, 212, 1),
                                    fontFamily: 'Inter',
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    decoration: const BoxDecoration(),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        SvgPicture.asset(SvgImages.combine,
                            color: activeTxtColor),
                        const SizedBox(width: 16),
                        Container(
                          decoration: const BoxDecoration(),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Combine mode',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: activeTxtColor,
                                    fontFamily: 'Inter',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(height: 4),
                              SizedBox(
                                width: constraints.maxWidth - 90,
                                child: const Text(
                                  'A single receipt or invoice with more than one page',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: Color.fromRGBO(212, 212, 212, 1),
                                      fontFamily: 'Inter',
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400),
                                  maxLines: 3,
                                  softWrap: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
