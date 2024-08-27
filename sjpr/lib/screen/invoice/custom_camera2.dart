import 'dart:io';
import 'dart:typed_data';

import 'package:cunning_document_scanner/cunning_document_scanner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sjpr/utils/color_utils.dart';
import 'package:sjpr/utils/image_utils.dart';
import 'package:sjpr/utils/string_utils.dart';
import 'package:sjpr/widgets/image_stack.dart';
import 'package:sjpr/widgets/picture_instruction_dialog.dart';

import '../../common/app_session.dart';
import '../../common/app_theme.dart';
import '../../di/app_component_base.dart';
import '../../widgets/common_button.dart';
import '../../widgets/custom_camera_modes.dart';

class PictureCapture extends StatefulWidget {
  const PictureCapture({super.key});

  @override
  State<PictureCapture> createState() => _PictureCaptureState();
}

class _PictureCaptureState extends State<PictureCapture> {
  int mode = 1;
  List<CaptureModel> cModels = [];

  List<String> instructions = [
    'When photographing your invoices, follow these best practices to ensure more accurate and precise scanning:',
    '1. Ensure the invoice is clean and readable.',
    '2. Maintain a distance of 20-30 cm between the camera and the document.',
    '3. Position the lens parallel to the plane of the document and point it toward the center of the text.',
    '4. Prevent the phone from shaking.',
    '5. Shoot in ambient light (preferably daylight) to maximize contrast between the text and the background.',
    '6. Place the document against a whiteboard or plain surface to set the white balance.',
    '7. Use appropriate filters on the selected or captured image.'
  ];
  bool status = false;

  @override
  initState() {
    super.initState();
    getInstructionStatus();
  }

  Future<void> getInstructionStatus() async {
    status = await AppComponentBase.getInstance()
        ?.getSharedPreference()
        .getPictureInstructionStatus();
    if (mounted) setState(() {});
  }

  void setInstructionStatus() {
    AppComponentBase.getInstance()
        ?.getSharedPreference()
        .setPictureInstructionStatus(value: true);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppTheme.of(context).backGroundColor,
        body: Stack(
          children: [
            Column(children: [
              Container(
                padding: EdgeInsets.only(top: 8, bottom: 8),
                color: const Color.fromRGBO(30, 34, 38, 33),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return PictureInstructionDialog(
                                  ListChild: getInstruction(asDialog: true),
                                );
                              });
                        },
                        icon: Icon(
                          Icons.info_outline_rounded,
                          color: Colors.white70,
                          size: 24,
                        )),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(21),
                        color: buttonBgColor,
                      ),
                      child: Text(
                        mode == 1
                            ? "${StringUtils.mode1} mode"
                            : mode == 2
                                ? "${StringUtils.mode2} mode"
                                : "${StringUtils.mode3} mode",
                        style: TextStyle(
                            color: buttonTextColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.close,
                          color: Colors.white70,
                          size: 32,
                        )),
                  ],
                ),
              ),
              Expanded(
                  flex: 5,
                  child: cModels.length > 0
                      ? GridView.builder(
                          itemCount: cModels.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              child: GridTile(
                                  header: Align(
                                    alignment: Alignment.topRight,
                                    child: IconButton(
                                      icon: Icon(Icons.delete_forever),
                                      color: Colors.yellowAccent,
                                      onPressed: () {
                                        _removeselected(cModels[index]);
                                      },
                                    ),
                                  ),
                                  child: cModels[index].widget),
                            );
                          },
                        )
                      : getInstruction()),
            ]),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: MediaQuery.of(context).size.height / 5,
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(30, 34, 38, 0.6),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Stack(children: [
                        Container(
                          height: MediaQuery.of(context).size.width / 6,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    mode = 1;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 16, right: 16, top: 2, bottom: 2),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(21),
                                    color: mode == 1
                                        ? buttonBgColor
                                        : Colors.transparent,
                                  ),
                                  child: Text(
                                    StringUtils.mode1,
                                    style: TextStyle(
                                        color: mode == 1
                                            ? buttonTextColor
                                            : textColor,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    mode = 2;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 16, right: 16, top: 2, bottom: 2),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(21),
                                    color: mode == 2
                                        ? buttonBgColor
                                        : Colors.transparent,
                                  ),
                                  child: Text(
                                    StringUtils.mode2,
                                    style: TextStyle(
                                        color: mode == 2
                                            ? buttonTextColor
                                            : textColor,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    mode = 3;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 16, right: 16, top: 2, bottom: 2),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(21),
                                    color: mode == 3
                                        ? buttonBgColor
                                        : Colors.transparent,
                                  ),
                                  child: Text(
                                    StringUtils.mode3,
                                    style: TextStyle(
                                        color: mode == 3
                                            ? buttonTextColor
                                            : textColor,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: SizedBox(
                              height: MediaQuery.of(context).size.width / 6,
                              child: IconButton(
                                  onPressed: () {
                                    bottomSheet(context);
                                  },
                                  icon: const Icon(
                                    Icons.help_outline,
                                    color: Colors.white70,
                                    size: 20,
                                  ))),
                        )
                      ]),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 12.0, right: 8, top: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Count: ${cModels.length}',
                              style: TextStyle(color: Colors.white),
                            ),
                            Expanded(
                              flex: 1,
                              child: IconButton(
                                onPressed: () async {
                                  performAction();
                                },
                                icon: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: backGroundColor,
                                        border: Border.all(
                                            color: activeTxtColor, width: 3),
                                        shape: BoxShape.circle),
                                    child: SvgPicture.asset(
                                      SvgImages.capture,
                                      height: 28,
                                    )),
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                if (cModels.isNotEmpty) {
                                  CamaraResponse response = CamaraResponse(
                                      models: cModels, mode: mode);
                                  Navigator.pop(context, response);
                                  setInstructionStatus();
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "No item is selected!");
                                }
                              },
                              icon: const Icon(
                                Icons.check,
                                color: Colors.grey,
                                size: 32,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  bottomSheet(BuildContext context) {
    final appTheme = AppTheme.of(context);
    showModalBottomSheet(
        backgroundColor: appTheme.listTileBgColor,
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return const CustomCameraModes();
        });
  }

  void _removeselected(CaptureModel model) {
    cModels.remove(model);
    setState(() {});
  }

  Future<void> performAction() async {
    List<String> _pictures = [];
    if (mode == 1) {
      try {
        _pictures = await CunningDocumentScanner.getPictures(
                noOfPages: 1, isGalleryImportAllowed: true) ??
            [];
      } catch (exception) {
        // Handle exception here
      }
    } else {
      try {
        _pictures = await CunningDocumentScanner.getPictures(
                isGalleryImportAllowed: true) ??
            [];
      } catch (exception) {
        // Handle exception here
      }
    }

    if (!mounted) return;

    for (var picture in _pictures) {
      cModels.add(CaptureModel(
          widget: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.file(File(picture)),
          ),
          isSelect: false,
          capturePath: picture));
    }

    setState(() {
      debugPrint('--->W len ${cModels.length}');
    });
  }

  getInstruction({bool asDialog = false}) {
    if (!status || asDialog) {
      return ListView.builder(
        itemCount: instructions.length, // Number of items in the list
        itemBuilder: (context, index) {
          return index == 0
              ? Container(
                  padding: EdgeInsets.all(8.0),
                  color: Colors.blue,
                  child: Text(
                    instructions[index],
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              : ListTile(
                  leading: Icon(Icons.star),
                  title: Text(
                    instructions[index],
                    style: TextStyle(color: Colors.white),
                  ),
                );
        },
      );
    } else {
      return const Center(
        child: Text(
          "No Image",
          style: TextStyle(color: Colors.white70),
        ),
      );
    }
  }
}

class CaptureModel {
  String capturePath;
  Widget widget;
  bool isSelect;

  CaptureModel(
      {required this.capturePath,
      required this.widget,
      required this.isSelect});
}

class CamaraResponse {
  List<CaptureModel> models;
  int mode;

  CamaraResponse({required this.models, required this.mode});
}
