import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sjpr/screen/lineitems/line_items_bloc.dart';
import 'package:sjpr/utils/color_utils.dart';
import 'package:sjpr/widgets/common_button.dart';
import '../common/app_theme.dart';
import '../utils/image_utils.dart';

class CommingSoonDialog extends StatelessWidget {
  const CommingSoonDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: listTileBgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Stack(
          children: [
            SvgPicture.asset(
              SvgImages.comingsoon,
              width: MediaQuery.of(context).size.width- 100,
              height: MediaQuery.of(context).size.width- 100,
            ),
            Positioned(
              top: 16,
              right: 8,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                }, icon: Icon(Icons.cancel_outlined, color: activeTxtColor,size: 32,),
                
              ),
            ),
          ],
        ),
      ),
    );
  }
}
