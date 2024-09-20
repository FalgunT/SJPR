import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../../common/app_session.dart';
import '../../common/app_theme.dart';
import '../../utils/color_utils.dart';
import '../../utils/image_utils.dart';
import '../invoice/custom_camera2.dart';

class UploadScreen extends StatefulWidget {
  String title;
  bool isBankStmt;

  UploadScreen({super.key, required this.title, required this.isBankStmt});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  List<CaptureModel> cModels = [];

  @override
  Widget build(BuildContext context) {
    AppThemeState appTheme = AppTheme.of(context);
    return SafeArea(
        child: Scaffold(
            backgroundColor: appTheme.backGroundColor,
            /* appBar: AppBar(
        backgroundColor: appTheme.backGroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: appTheme.textColor,
          ),
        ),
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ),
      ),*/
            body: getBody(),
            persistentFooterButtons: getPersistanceButton()));
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
                        //info about formats you can select...
                        return Center();
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
                "${widget.title}",
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
      Expanded(child: getGrid()),
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
                  icon: const Icon(Icons.expand_rounded),
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
                  pickFile();
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

                //CamaraResponse response = CamaraResponse(models: cModels, mode: mode);
                Navigator.pop(
                  context, /*response*/
                );
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

  Future<void> _removeselected(CaptureModel model) async {
    //delete the file from storage..
    bool? res = await AppSession.getInstance()?.deleteFile(model.capturePath);
    if (res!) {
      cModels.remove(model);
      setState(() {});
    }
  }

  pickFile() async {
    //for single image...
    List<File> files = [];
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['csv', 'pdf'],
    );

    if (result == null) {
      //nothing selected
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Nothing is selected')));
      return;
    }

    files = result.paths.map((path) => File(path!)).toList();
    if (!mounted) return;
    if (files.isNotEmpty) {
      for (var picture in files) {
        //String ext = getFileExtension(picture.path);
        //String filenm = getFileName(picture.path);
       // String fileSize = getFileSize(picture.path);
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
      });
    }
  }
}
