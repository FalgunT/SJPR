import 'dart:io';
import 'dart:typed_data';
import 'package:cunning_document_scanner/cunning_document_scanner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
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

  final List<String> instructions = [
    'When photographing your invoices, follow these best practices to ensure more accurate and precise scanning:',
    'Ensure the invoice is clean and readable.',
    'Maintain a distance of 20-30 cm between the camera and the document.',
    'Position the lens parallel to the plane of the document and point it toward the center of the text.',
    'Prevent the phone from shaking.',
    'Shoot in ambient light (preferably daylight) to maximize contrast between the text and the background.',
    'Place the document against a whiteboard or plain surface to set the white balance.',
    'Use appropriate filters on the selected or captured image.'
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
          body: getBody(),
          persistentFooterButtons: getPersistanceButton()),
    );
  }

  getBody() {
    return Column(children: [
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
                icon: const Icon(
                  Icons.info_outline_rounded,
                  color: Colors.white70,
                  size: 24,
                )),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
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
                    color: buttonTextColor, fontWeight: FontWeight.bold),
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
      Expanded(child: cModels.isNotEmpty ? getGrid() : getInstruction()),
    ]);
  }

  getGrid() {
    return GridView.builder(
      padding: EdgeInsets.zero,
      itemCount: cModels.length,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: listTileBgColor,
          child: GridTile(
              header: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.delete_forever),
                  color: buttonBgColor,
                  onPressed: () {
                    _removeselected(cModels[index]);
                  },
                ),
              ),
              child: cModels[index].widget),
        );
      },
    );
  }

  getPersistanceButton() {
    return [
      Stack(children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width / 7,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
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
                    color: mode == 1 ? buttonBgColor : Colors.transparent,
                  ),
                  child: Text(
                    StringUtils.mode1,
                    style: TextStyle(
                        color: mode == 1 ? buttonTextColor : textColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 14),
                  ),
                ),
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
                    color: mode == 2 ? buttonBgColor : Colors.transparent,
                  ),
                  child: Text(
                    StringUtils.mode2,
                    style: TextStyle(
                        color: mode == 2 ? buttonTextColor : textColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 14),
                  ),
                ),
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
                    color: mode == 3 ? buttonBgColor : Colors.transparent,
                  ),
                  child: Text(
                    StringUtils.mode3,
                    style: TextStyle(
                        color: mode == 3 ? buttonTextColor : textColor,
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
              height: MediaQuery.of(context).size.width / 7,
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
        padding: const EdgeInsets.only(left: 8.0, right: 8, top: 4),
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
                  if (Platform.isAndroid) {
                    performAction();
                  } else if (Platform.isIOS) {
                    // iOS-specific code
                    //for ios we need to give gallry option seperately...
                    bottomSheetDialog();
                  }
                },
                icon: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: backGroundColor,
                        border: Border.all(color: activeTxtColor, width: 3),
                        shape: BoxShape.circle),
                    child: SvgPicture.asset(
                      SvgImages.capture,
                      height: 28,
                    )),
              ),
            ),
            IconButton(
              onPressed: () async {
                if (cModels.isEmpty) {
                  Fluttertoast.showToast(msg: "No item is selected!");
                  return;
                }
                if (mode == 1 && cModels.length > 1) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Only one file can be uploaded in single mode. You can either change the mode or remove the other files.'),
                      duration: Duration(days: 1),
                      // Effectively infinite duration
                      behavior: SnackBarBehavior.floating,
                      action: SnackBarAction(
                        label: 'Ok',
                        onPressed: () {
                          // Code to execute when the action is pressed
                        },
                      ),
                    ),
                  );
                  return;
                }
                CamaraResponse response =
                    CamaraResponse(models: cModels, mode: mode);
                Navigator.pop(context, response);
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
    ];
  }

  bottomSheet(BuildContext context) {
    final appTheme = AppTheme.of(context);
    showModalBottomSheet(
        backgroundColor: appTheme.textFieldBgColor,
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return const Padding(
            padding: EdgeInsets.all(0),
            child: CustomCameraModes(),
          );
        });
  }

  Future<void> _removeselected(CaptureModel model) async {
    //delete the file from storage..
    bool? res = await AppSession.getInstance()?.deleteFile(model.capturePath);
    if (res!) {
      cModels.remove(model);
      setState(() {});
    }
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
      setInstructionStatus();
      status = true;
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
                  color: buttonBgColor,
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
                  leading: Text(
                    '\u2022',
                    style: TextStyle(color: Colors.white70, fontSize: 32),
                  ),
                  title: Text(
                    instructions[index],
                    style: TextStyle(color: Colors.white),
                  ),
                );
        },
      );
    } else {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.image_outlined,
              size: 140,
              color: Colors.white70,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16),
              child: Text(
                textAlign: TextAlign.center,
                "No image found. Please select a mode and start capturing the invoice(s).",
                style: TextStyle(color: Colors.white70),
              ),
            ),
          ],
        ),
      );
    }
  }

  Future<void> bottomSheetDialog() {
    return showModalBottomSheet(
        backgroundColor: textFieldBgColor,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 10, left: 8, right: 8),
              height: MediaQuery.of(context).size.height / 2.8,
              child: SingleChildScrollView(
                child: Column(
                  children: [
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
                    const SizedBox(height: 24),
                    Text(
                      "Capture or Select Image",
                      style: TextStyle(fontSize: 20, color: activeTxtColor),
                    ),
                    const SizedBox(height: 16),
                    ListTile(
                      onTap: () {
                        performAction();
                      },
                      title: Text(
                        "Camera",
                        style: TextStyle(color: activeTxtColor),
                      ),
                      subtitle: const Text(
                        "Capture an invoice with the device’s camera and upload to the server.",
                        style: TextStyle(color: Colors.white70, fontSize: 10),
                      ),
                      leading: Icon(
                        Icons.camera_alt_outlined,
                        color: activeTxtColor,
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Colors.white70,
                        size: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    ListTile(
                      onTap: () {
                        pickImage(ImageSource.gallery);
                      },
                      title: Text(
                        "Gallery",
                        style: TextStyle(color: activeTxtColor),
                      ),
                      subtitle: Text(
                        "Select an existing invoice image from the gallery to upload to the server.",
                        style: TextStyle(color: Colors.white70, fontSize: 10),
                      ),
                      leading: Icon(
                        Icons.image_outlined,
                        color: activeTxtColor,
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Colors.white70,
                        size: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                  ],
                ),
              ),
            );
          });
        });
  }

  pickImage(ImageSource source) async {
    //for single image...
    List<XFile> xfilePick = [];
    if (mode == 1) {
      XFile? xf = await ImagePicker().pickImage(
        source: source,
        imageQuality: 100,
      );
      if (xf != null) {
        xfilePick.add(xf);
      }
    } else {
      xfilePick = await ImagePicker().pickMultiImage(imageQuality: 100);
    }

    if (!mounted) return;

    if (xfilePick.isNotEmpty) {
      for (var picture in xfilePick) {
        cModels.add(CaptureModel(
            widget: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.file(File(picture.path)),
            ),
            isSelect: false,
            capturePath: picture.path));
      }

      setState(() {
        debugPrint('--->W len ${cModels.length}');
        setInstructionStatus();
        status = true;
      });
    } else {
      // If no image is selected it will show a
      // snackbar saying nothing is selected
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Nothing is selected')));
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
