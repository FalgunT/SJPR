import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sjpr/main.dart';
import 'package:sjpr/utils/color_utils.dart';
import 'package:sjpr/utils/image_utils.dart';
import 'package:sjpr/utils/string_utils.dart';
import 'package:sjpr/widgets/image_stack.dart';

import '../../widgets/common_button.dart';

class CustomCamera extends StatefulWidget {
  const CustomCamera({super.key});

  @override
  State<CustomCamera> createState() => _CustomCameraState();
}

class _CustomCameraState extends State<CustomCamera> {
  late CameraController controller;
  int mode = 1;
  List<CaptureModel> cModels = [];

  // List<XFile> captures = [];
  // List<Widget> widgets = [];

  @override
  initState() {
    super.initState();

    controller = CameraController(cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  Future<Image> xFileToImage(XFile xFile) async {
    Uint8List bytes = (await xFile.readAsBytes());
    return Image.memory(
      bytes,
      fit: BoxFit.fitWidth,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(children: [
        SizedBox(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            child: CameraPreview(controller)),
        Container(
          //width: MediaQuery.sizeOf(context).width * 0.9,
          height: MediaQuery.sizeOf(context).width * 0.15,
          color: const Color.fromRGBO(30, 34, 38, 33),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {}, icon: SvgPicture.asset(SvgImages.flash)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                  icon: SvgPicture.asset(SvgImages.close)),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            //margin: const EdgeInsets.only(left: 5, right: 5),
            height: 160,
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Color.fromRGBO(30, 34, 38, 33),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          mode = 1;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(21),
                          color: mode == 1 ? buttonBgColor : Colors.transparent,
                        ),
                        child: Text(
                          StringUtils.mode1,
                          style: TextStyle(
                              color: mode == 1 ? buttonTextColor : textColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          mode = 2;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(21),
                          color: mode == 2 ? buttonBgColor : Colors.transparent,
                        ),
                        child: Text(
                          StringUtils.mode2,
                          style: TextStyle(
                              color: mode == 2 ? buttonTextColor : textColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          mode = 3;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(21),
                          color: mode == 3 ? buttonBgColor : Colors.transparent,
                        ),
                        child: Text(
                          StringUtils.mode3,
                          style: TextStyle(
                              color: mode == 3 ? buttonTextColor : textColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        _showCaptured(context);
                      },
                      child: Container(
                        height: 88,
                        width: 88,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: cModels.isNotEmpty
                                ? ImageStack(widgets: cModels)
                                : Image.asset(AssetImages.imageBgLayer)),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: () async {
                          /*   final path = join(
                            (await getTemporaryDirectory()).path,
                            '${DateTime.now()}.jpg',
                          );*/
                          if (mode == 1) {
                            cModels = [];
                          }
                          var result = await controller.takePicture();
                          Image img = Image.asset(AssetImages.imageBgLayer);
                          img = await xFileToImage(result);

                          cModels.add(CaptureModel(
                              capture: result, widget: img, isSelect: false));
                          setState(() {
                            debugPrint('--->W len ${cModels.length}');
                          });
                        },
                        icon: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                color: backGroundColor,
                                border:
                                    Border.all(color: activeTxtColor, width: 3),
                                shape: BoxShape.circle),
                            child: SvgPicture.asset(
                              SvgImages.capture,
                              height: 20,
                            )),
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        CamaraResponse response  = CamaraResponse(models: cModels, mode: mode);
                        Navigator.pop(context, response);
                      },
                      icon: const Icon(
                        Icons.check,
                        color: Colors.grey,
                        size: 48,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ])),
    );
  }

  void _showCaptured(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: listTileBgColor,
        isScrollControlled: true,
        isDismissible: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter setSheetState /*You can rename this!*/) {
            return Padding(
                padding: EdgeInsets.fromLTRB(
                    20, 20, 20, MediaQuery.of(context).viewInsets.bottom),
                child: Wrap(children: <Widget>[
                  ListTile(
                    trailing: InkWell(
                      onTap: () async {
                        setState(() {});
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.clear,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      "Invoices",
                      style: TextStyle(color: textColor, fontSize: 18),
                    ),
                  ),
                  AnimatedSwitcher(
                      duration: Duration(milliseconds: 300),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: _buildGridView(setSheetState),
                      )),
                ]));
          });
        });
  }

  _buildGridView(StateSetter setSheetState) {
    return GridView.builder(
      itemCount: cModels.length,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: GridTile(
              header: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(Icons.delete_forever),
                  color: Colors.yellowAccent,
                  onPressed: () {
                    _removeselected(cModels[index], setSheetState);
                  },
                ),
              ),
              child: cModels[index].widget),
        );
      },
    );
  }

  void _removeselected(CaptureModel model, StateSetter setSheetState) {
    cModels.remove(model);
    setSheetState(() {});
  }
}

class CaptureModel {
  XFile capture;
  Widget widget;
  bool isSelect;

  CaptureModel(
      {required this.capture, required this.widget, required this.isSelect});
}

class CamaraResponse {
  List<CaptureModel> models;
  int mode;

  CamaraResponse({required this.models, required this.mode});
}
