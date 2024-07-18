import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_document_scanner/flutter_document_scanner.dart';
import 'package:flutter/material.dart';

class ScanDocumentPage extends StatefulWidget {
  const ScanDocumentPage({super.key});

  @override
  State<ScanDocumentPage> createState() => _ScanDocumentPageState();
}

class _ScanDocumentPageState extends State<ScanDocumentPage> {
  final _controller = DocumentScannerController();

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: DocumentScanner(
          controller: _controller,
          generalStyles: const GeneralStyles(
            hideDefaultBottomNavigation: true,
            messageTakingPicture: 'Taking picture of document',
            messageCroppingPicture: 'Cropping picture of document',
            messageEditingPicture: 'Editing picture of document',
            messageSavingPicture: 'Saving picture of document',
            baseColor: Colors.teal,
          ),
          takePhotoDocumentStyle: TakePhotoDocumentStyle(
            top: MediaQuery.of(context).padding.top + 25,
            hideDefaultButtonTakePicture: true,
            onLoading: const CircularProgressIndicator(
              color: Colors.white,
            ),
            children: [
              // * AppBar
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.teal,
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 10,
                    bottom: 15,
                  ),
                  child: const Center(
                    child: Text(
                      'Take a picture of the document',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              // * Button to take picture
              Positioned(
                bottom: MediaQuery.of(context).padding.bottom + 10,
                left: 0,
                right: 0,
                child: Center(
                  child: ElevatedButton(
                    onPressed: _controller.takePhoto,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                    ),
                    child: const Text(
                      'Take picture',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          cropPhotoDocumentStyle: CropPhotoDocumentStyle(
            top: MediaQuery.of(context).padding.top,
            maskColor: Colors.teal.withOpacity(0.2),
          ),
          editPhotoDocumentStyle: EditPhotoDocumentStyle(
            top: MediaQuery.of(context).padding.top,
          ),
          resolutionCamera: ResolutionPreset.ultraHigh,
          pageTransitionBuilder: (child, animation) {
            final tween = Tween<double>(begin: 0, end: 1);
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            );
            return ScaleTransition(
              scale: tween.animate(curvedAnimation),
              child: child,
            );
          },
          onSave: (Uint8List imageBytes) async {
            // ? Bytes of the document/image already processed
            /* var file =
                await PlatformFile('invoice.jpg').writeAsBytes(imageBytes);*/
            // bloc.uploadInvoice(context, file);
          },
        ),
        /*StreamBuilder(
          stream: _bloc.mainStream,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return Container();
          },
        ),*/
      ),
    );
  }
}
