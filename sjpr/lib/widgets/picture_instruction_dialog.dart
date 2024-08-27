import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sjpr/screen/lineitems/line_items_bloc.dart';
import 'package:sjpr/utils/color_utils.dart';
import 'package:sjpr/widgets/common_button.dart';
import '../common/app_theme.dart';
import '../utils/image_utils.dart';

class PictureInstructionDialog extends StatelessWidget {
  var ListChild;

  PictureInstructionDialog({super.key, required this.ListChild});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(0),
      contentPadding: const EdgeInsets.all(0),
      backgroundColor: listTileBgColor,
      title: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: const Text(
          "Instructions",
          style: TextStyle(color: Colors.white),
        ),
      ),
      content: SizedBox(
        height: (MediaQuery.of(context).size.height / 2) + 40,
        width: MediaQuery.of(context).size.width - 40,
        child: ListChild,
      ),
      actions: <Widget>[
        TextButton(
          child: const Text(
            'Ok',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
        ),
      ],
    );

    /*Dialog(
      backgroundColor: listTileBgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SvgPicture.asset(
              SvgImages.comingsoon,
              width: MediaQuery.of(context).size.width - 100,
              height: MediaQuery.of(context).size.width - 100,
            ),
            Positioned(
              top: 16,
              right: 8,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                icon: Icon(
                  Icons.cancel_outlined,
                  color: activeTxtColor,
                  size: 32,
                ),
              ),
            ),
          ],
        ),
      ),
    );*/
  }
}
