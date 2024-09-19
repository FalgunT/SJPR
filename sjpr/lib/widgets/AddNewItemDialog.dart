import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../common/AppEnums.dart';
import '../common/common_toast.dart';
import '../screen/lineitems/line_items_detail.dart';
import '../utils/color_utils.dart';
import '../utils/textinput_utils.dart';

class AddNewItemDialog {
  final String title, hint, label, oldValue;
  final BuildContext context;
  TextEditingController eController = TextEditingController();
  final Function onPressed;

  AddNewItemDialog({
    bool isAmt = false,
    required this.context,
    required this.title,
    required this.hint,
    required this.label,
    required this.oldValue,
    required SheetType type,
    required this.onPressed,
  }) {
    eController.text = oldValue;
    eController.selection = TextSelection(
      baseOffset: 0,
      extentOffset: oldValue.length,
    );
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctxt) => AlertDialog(
              backgroundColor: listTileBgColor,
              insetPadding: const EdgeInsets.all(4),
              title: Text(
                title,
                style: const TextStyle(color: Colors.white),
              ),
              content: Builder(
                builder: (context) {
                  // Get available height and width of the build area of this widget. Make a choice depending on the size.
                  var height = MediaQuery.of(context).size.height;
                  var width = MediaQuery.of(context).size.width;

                  return SizedBox(
                    width: width - 100,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 16,
                        ),
                        TextField(
                          style: const TextStyle(color: Colors.white),
                          autofocus: true,
                          keyboardType: isAmt
                              ? const TextInputType.numberWithOptions(
                                  decimal: true, signed: false)
                              : TextInputType.text,
                          inputFormatters: getTextFormatter(isAmt,
                              isDouble:
                                  /*label.contains("Quantity") ? false :*/ true),
                          decoration: InputDecoration(
                            filled: false,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: profileListBgColor, width: 1.0),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.0),
                            ),
                            hintText: hint,
                            hintStyle: const TextStyle(color: Colors.white70),
                            labelText: label,
                            labelStyle: const TextStyle(color: Colors.white70),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(50)),
                          ),
                          controller: eController,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Cancel',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                if (eController.text.isEmpty) {
                                  CommonToast.getInstance()?.displayToast(
                                      message: "Please enter $label",
                                      bContext: context);
                                  return;
                                }
                                onPressed(eController.text.trim());
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Save',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ));
  }

  getTextFormatter(bool isAmt, {bool isDouble = true}) {
    List<TextInputFormatter> formatters = [];
    if (isAmt) {
      if (isDouble) {
        formatters.add(FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),);
        formatters.add(DecimalTextInputFormatter(decimalRange: 2));
      } else {
        formatters.add(FilteringTextInputFormatter.allow(RegExp(r"[0-9]")),);
      }
    } else {
      formatters.add(FilteringTextInputFormatter.singleLineFormatter);
    }
    return formatters;
  }

  /*
  *  void _showAddProductDialog(
      String title, String hint, String label, String oldValue,
      {bool isAmt = false, required SheetType type}) {
    bloc.eController.text = oldValue;
    bloc.eController.selection = TextSelection(
      baseOffset: 0,
      extentOffset: oldValue.length,
    );
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctxt) => AlertDialog(
              backgroundColor: listTileBgColor,
              insetPadding: const EdgeInsets.all(4),
              title: Text(
                title,
                style: const TextStyle(color: Colors.white),
              ),
              content: Builder(
                builder: (context) {
                  // Get available height and width of the build area of this widget. Make a choice depending on the size.
                  var height = MediaQuery.of(context).size.height;
                  var width = MediaQuery.of(context).size.width;

                  return SizedBox(
                    width: width - 100,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 16,
                        ),
                        TextField(
                          style: const TextStyle(color: Colors.white),
                          autofocus: true,
                          keyboardType: isAmt
                              ? const TextInputType.numberWithOptions(
                                  decimal: true, signed: false)
                              : TextInputType.text,
                          inputFormatters: getTextFormatter(isAmt,
                              isDouble:
                                  label.contains("Quantity") ? false : true),
                          decoration: InputDecoration(
                            filled: false,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: profileListBgColor, width: 1.0),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.0),
                            ),
                            hintText: hint,
                            hintStyle: const TextStyle(color: Colors.white70),
                            labelText: label,
                            labelStyle: const TextStyle(color: Colors.white70),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(50)),
                          ),
                          controller: bloc.eController,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Cancel',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                if (bloc.eController.text.isEmpty) {
                                  CommonToast.getInstance()?.displayToast(
                                      message: "Please enter $label",
                                      bContext: context);
                                  return;
                                }
                                if (isAmt) {
                                  //update amount field...
                                  if (label
                                      .toLowerCase()
                                      .contains('quantity')) {
                                    String v = bloc.eController.text;
                                    bloc.lineitemdetail.value.quantity = v;
                                  } else if (label
                                      .toLowerCase()
                                      .contains('unit price')) {
                                    String v = bloc
                                        .getFormetted(bloc.eController.text);
                                    bloc.lineitemdetail.value.unitPrice = v;
                                  } else if (label
                                      .toLowerCase()
                                      .contains('net amount')) {
                                    String v = bloc
                                        .getFormetted(bloc.eController.text);
                                    bloc.lineitemdetail.value.netAmount = v;
                                  } else if (label
                                      .toLowerCase()
                                      .contains('tax amount')) {
                                    String v = bloc
                                        .getFormetted(bloc.eController.text);
                                    bloc.lineitemdetail.value.taxRate = v;
                                  } else if (label
                                      .toLowerCase()
                                      .contains('total amount')) {
                                    String v = bloc
                                        .getFormetted(bloc.eController.text);
                                    //bloc.selectedTotalAmt.value = v;
                                    bloc.lineitemdetail.value.totalAmount = v;
                                  }
                                  Navigator.pop(context);
                                  setState(() {});
                                  return;
                                } else {

                                }

                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Save',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ));
  }
  * */
}
