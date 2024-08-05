import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:sjpr/model/api_response_costomer.dart';
import 'package:sjpr/model/api_response_location.dart';
import 'package:sjpr/model/category_list_model.dart';
import 'package:sjpr/model/product_list_model.dart';
import 'package:sjpr/screen/lineitems/line_items_bloc.dart';
import 'package:sjpr/utils/color_utils.dart';
import 'package:sjpr/widgets/common_button.dart';
import 'package:sjpr/model/api_response_class.dart' as itemclass;

import '../../common/common_toast.dart';
import '../../model/api_response_class.dart';
import '../../utils/textinput_utils.dart';
import '../../widgets/check_box.dart';
import '../../widgets/expandable_radio_list.dart';
import '../../widgets/radio_button_list.dart';

enum SheetType {
  category,
  product,
  itemclass,
  location,
  customer,
  taxrate,
  none
}

class LineItemsDetailScreen extends StatefulWidget {
  final String id;

  const LineItemsDetailScreen({super.key, required this.id});

  @override
  State<LineItemsDetailScreen> createState() => _LineItemsDetailScreenState();
}

class _LineItemsDetailScreenState extends State<LineItemsDetailScreen> {
  LineItemsBloc bloc = LineItemsBloc();

  @override
  initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        backgroundColor: backGroundColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: ValueListenableBuilder(
            valueListenable: bloc.lineitemdetail,
            builder: (context, value, _) {
              return Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          bloc.lineitemdetail.value.name,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: activeTxtColor,
                              fontSize: 24),
                        ),
                        CommonButton(
                            textFontSize: 16,
                            height: 30,
                            content: "Delete",
                            bgColor: backGroundColor,
                            textColor: activeTxtColor,
                            outlinedBorderColor: activeTxtColor,
                            onPressed: () {
                              _showDeleteConfirmationDialog(context);
                            })
                      ],
                    ),
                    Spacer(),
                    Container(
                      padding: const EdgeInsets.all(12),
                      height: 112,
                      width: MediaQuery.sizeOf(context).width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color.fromRGBO(44, 45, 51, 1),
                      ),
                      child: TextField(
                        controller: bloc.txtController,
                        maxLines: 5,
                        style: TextStyle(color: textColor, fontSize: 16),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            hintText: "Description",
                            hintStyle:
                                TextStyle(color: textColor, fontSize: 16)),
                      ),
                    ),
                    Spacer(),
                    ValueListenableBuilder(
                        valueListenable: bloc.selectedValueC,
                        builder: (context, value, _) {
                          return commonRowWidget(
                              title: "Category",
                              value: value,
                              onTap: () {
                                bloc.selectedValue = 0;
                                singleSelectBottomSheet(
                                    context: context,
                                    list: bloc.categoryList,
                                    title: "Category",
                                    bottomSheetType: SheetType.category);
                              },
                              context: context);
                        }),
                    ValueListenableBuilder(
                        valueListenable: bloc.selectedValueP,
                        builder: (context, value, _) {
                          return commonRowWidget(
                              title: "Product/Service",
                              value: value,
                              onTap: () {
                                bloc.selectedValue = 0;
                                singleSelectBottomSheet(
                                    context: context,
                                    list: bloc.productList,
                                    title: "Product/Service",
                                    bottomSheetType: SheetType.product);
                              },
                              context: context);
                        }),
                    ValueListenableBuilder(
                        valueListenable: bloc.selectedValueClass,
                        builder: (context, value, _) {
                          return commonRowWidget(
                              title: "Class",
                              value: value,
                              onTap: () {
                                bloc.selectedValue = 0;
                                singleSelectBottomSheet(
                                    context: context,
                                    list: bloc.classList,
                                    title: "Class",
                                    bottomSheetType: SheetType.itemclass);
                              },
                              context: context);
                        }),
                    ValueListenableBuilder(
                        valueListenable: bloc.selectedValueL,
                        builder: (context, value, _) {
                          return commonRowWidget(
                              title: "Location",
                              value: value,
                              onTap: () {
                                bloc.selectedValue = 0;
                                singleSelectBottomSheet(
                                    context: context,
                                    list: bloc.locationList,
                                    title: "Location",
                                    bottomSheetType: SheetType.location);
                              },
                              context: context);
                        }),
                    ValueListenableBuilder(
                        valueListenable: bloc.selectedValueCustomer,
                        builder: (context, value, _) {
                          return commonRowWidget(
                              title: "Customer",
                              value: value,
                              onTap: () {
                                bloc.selectedValue = 0;
                                singleSelectBottomSheet(
                                    context: context,
                                    list: bloc.customerList,
                                    title: "Customer",
                                    bottomSheetType: SheetType.customer);
                              },
                              context: context);
                        }),
                    commonRowWidget(
                        title: "Quantity",
                        value: bloc
                            .getFormetted(bloc.lineitemdetail.value.quantity),
                        onTap: () {
                          _showAddProductDialog(
                              "Edit Quantity", 'Enter Quantity', 'Quantity',
                              isAmt: true, type: SheetType.none);
                        },
                        context: context),
                    commonRowWidget(
                        title: "Unit price ",
                        value: bloc
                            .getFormetted(bloc.lineitemdetail.value.unitPrice),
                        onTap: () {
                          _showAddProductDialog("Edit Unit price ",
                              'Enter Unit price ', 'Unit price ',
                              isAmt: true, type: SheetType.none);
                        },
                        context: context),
                    commonRowWidget(
                        title: "Net Amount",
                        value: bloc
                            .getFormetted(bloc.lineitemdetail.value.netAmount),
                        onTap: () {
                          _showAddProductDialog("Edit Net Amount",
                              'Enter Net Amount', 'Net Amount',
                              isAmt: true, type: SheetType.none);
                        },
                        context: context),
                    /*commonRowWidget(
                        title: "Tax rate",
                        value: bloc
                            .getFormetted(bloc.lineitemdetail.value.taxRate),
                        onTap: () {},
                        context: context),*/
                    commonRowWidget(
                        title: "Tax Amount",
                        value: bloc
                            .getFormetted(bloc.lineitemdetail.value.taxRate),
                        onTap: () {
                          _showAddProductDialog("Edit Tax Amount",
                              'Enter Tax Amount', 'Tax Amount',
                              isAmt: true, type: SheetType.none);
                        },
                        context: context),
                    commonRowWidget(
                        title: "Total Amount",
                        value: bloc.getFormetted(
                            bloc.lineitemdetail.value.totalAmount),
                        onTap: () {
                          _showAddProductDialog("Edit Total Amount",
                              'Enter Total Amount', 'Total Amount',
                              isAmt: true, type: SheetType.none);
                        },
                        context: context),
                    CommonButton(
                        textFontSize: 16,
                        content: "Save",
                        bgColor: buttonBgColor,
                        textColor: buttonTextColor,
                        outlinedBorderColor: buttonBgColor,
                        onPressed: () async {
                          bloc.lineitemdetail.value.description =
                              bloc.txtController.text;
                          if (isValid()) {
                            bool res = await bloc.updateLineItem(context);
                            if (res) {
                              Navigator.pop(context, res);
                            }
                          }
                        })
                  ],
                ),
              );
            }),
      ),
    );
  }

  Widget Spacer() {
    return const SizedBox(
      height: 10,
    );
  }

  singleSelectBottomSheet({
    required context,
    required list,
    required title,
    required bottomSheetType,
  }) {
    return showModalBottomSheet(
        backgroundColor: Colors.black,
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          bottomSheetType != SheetType.category
                              ? OutlinedButton.icon(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    _showAddProductDialog("Add $title",
                                        'Enter $title Name', '$title Name',
                                        type: bottomSheetType);
                                  },
                                  label: const Text(
                                    "Add",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  icon: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                )
                              : Center(),
                          const SizedBox(
                            width: 16,
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.close,
                                color: textColor,
                              ))
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    style: TextStyle(color: textColor),
                    decoration: InputDecoration(
                        isDense: true,
                        prefixIcon: Icon(
                          Icons.search,
                          color: textColor,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        fillColor: const Color.fromRGBO(44, 45, 51, 1),
                        filled: true,
                        hintText: "Search",
                        hintStyle: TextStyle(color: textColor)),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  bottomSheetType == SheetType.category
                      ? Expanded(
                          child: ExpandableRadioList(
                            catList:
                                bloc.categoryList as List<CategoryListData>,
                            f: (id, name) {
                              debugPrint('--->f() called');
                              bloc.lineitemdetail.value.categoryId = '$id';
                              bloc.selectedValueC.value = name;
                            },
                            selectedId: getCategoryId(),
                          ),
                        )
                      : Expanded(
                          child: RadioButtonList1(
                            items: list,
                            selectedId: getId(bottomSheetType),
                            f: (id, name) {
                              SetName(id, name, bottomSheetType);
                            },
                          ),
                        ),
                ],
              ),
            );
          });
        });
  }

  Widget commonRowWidget(
      {required title, required value, required onTap, required context}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: listTileBgColor,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Text(
                value,
                style: TextStyle(color: textColor, fontSize: 17),
                textAlign: TextAlign.end,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: textColor,
            )
          ],
        ),
      ),
    );
  }

  String getBottomSheetTitle(int index, SheetType bottomSheetType) {
    if (bottomSheetType == SheetType.customer) {
      return bloc.customerList[index].customerName;
    } else if (bottomSheetType == SheetType.location) {
      return bloc.locationList[index].location;
    } else if (bottomSheetType == SheetType.itemclass) {
      return bloc.classList[index].className;
    } else if (bottomSheetType == SheetType.product) {
      return bloc.productList[index].productServicesName!;
    }
    return '';
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: listTileBgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.warning_amber_rounded,
                    color: Colors.yellow, size: 50),
                SizedBox(height: 16),
                Text(
                  'Delete line',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Are you sure you want to delete this item?',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black, // Background color
                    backgroundColor: Colors.yellow, // Text color
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  ),
                  onPressed: () async {
                    bool res = await bloc.deleteLineItemDetail(
                        bloc.lineitemdetail.value.id, context);
                    if (res) {
                      Navigator.of(context).pop(); // Close the dialog
                      Navigator.of(context).pop(); // Close the page
                      // Add your delete logic here
                    }
                  },
                  child: Text(
                    'Continue to delete',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(fontSize: 16, color: Colors.yellow),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showAddProductDialog(String title, String hint, String label,
      {bool isAmt = false, required SheetType type}) {
    bloc.eController.text = "";
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
                          inputFormatters: getTextFormatter(isAmt),
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
                                    String v = bloc
                                        .getFormetted(bloc.eController.text);
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
                                  if (type == SheetType.product) {
                                    bloc.addProductService(
                                        context, bloc.eController.text);
                                  } else if (type == SheetType.itemclass) {
                                    bloc.addClass(
                                        context, bloc.eController.text);
                                  } else if (type == SheetType.location) {
                                    bloc.addlocation(
                                        context, bloc.eController.text);
                                  } else if (type == SheetType.customer) {
                                    bloc.addCustomer(
                                        context, bloc.eController.text);
                                  }
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

  getTextFormatter(bool isAmt) {
    List<TextInputFormatter> formatters = [];
    if (isAmt) {
      formatters.add(
        FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
      );
      formatters.add(DecimalTextInputFormatter(decimalRange: 2));
    } else {
      formatters.add(FilteringTextInputFormatter.singleLineFormatter);
    }
    return formatters;
  }

  Future<void> _init() async {
    if (widget.id.isNotEmpty) {
      await bloc.getLineItemDetail(context, widget.id);
    }
    bloc.getDetailCategory(context);
    bloc.getProductService(context);
    bloc.getAllCustomer(context);
    bloc.getAllTaxRate(context);
    bloc.getAllClass(context);
    bloc.getAllLocations(context);
  }

  getCategoryId() {
    String catid = '0';
    if (bloc.lineitemdetail.value.categoryId.isEmpty) {
      catid = '0';
    } else {
      catid = bloc.lineitemdetail.value.categoryId;
    }
    return int.parse(catid);
  }

  getId(bottomSheetType) {
    String id = "0";
    if (bottomSheetType == SheetType.product) {
      id = bloc.lineitemdetail.value.productId;
    } else if (bottomSheetType == SheetType.itemclass) {
      id = bloc.lineitemdetail.value.classId;
    } else if (bottomSheetType == SheetType.location) {
      id = bloc.lineitemdetail.value.locationId;
    } else if (bottomSheetType == SheetType.customer) {
      id = bloc.lineitemdetail.value.customerId;
    }
    if (id.isEmpty) {
      id = '0';
    }
    return int.parse(id);
  }

  bool isValid() {
    String catid = bloc.lineitemdetail.value.categoryId ?? "";
    if (catid == "") {
      CommonToast.getInstance()?.displayToast(
          message: "Category field is required", bContext: context);
      return false;
    }
    String pid = bloc.lineitemdetail.value.productId ?? "";
    if (pid == "") {
      CommonToast.getInstance()?.displayToast(
          message: "Product/Service field is required", bContext: context);
      return false;
    }
    String tid = bloc.lineitemdetail.value.classId ?? "";
    if (tid == "") {
      CommonToast.getInstance()
          ?.displayToast(message: "Class field is required", bContext: context);
      return false;
    }
    String loc = bloc.lineitemdetail.value.locationId ?? "";
    if (loc == "") {
      CommonToast.getInstance()?.displayToast(
          message: "Location field is required", bContext: context);
      return false;
    }
    String cus = bloc.lineitemdetail.value.customerId ?? "";
    if (cus == "") {
      CommonToast.getInstance()?.displayToast(
          message: "Customer field is required", bContext: context);
      return false;
    }
    String total = bloc.lineitemdetail.value.totalAmount ?? "";
    if (total.isEmpty) {
      CommonToast.getInstance()?.displayToast(
          message: "Total  field is required", bContext: context);
      return false;
    }
    String tax = bloc.lineitemdetail.value.taxRate ?? "";
    if (tax.isEmpty) {
      CommonToast.getInstance()
          ?.displayToast(message: "Tax  field is required", bContext: context);
      return false;
    }
    String net = bloc.lineitemdetail.value.netAmount ?? "";
    if (net.isEmpty) {
      CommonToast.getInstance()?.displayToast(
          message: "Net Amount field is required", bContext: context);
      return false;
    }
    return true;
  }

  void SetName(id, name, bottomSheetType) {
    if (bottomSheetType == SheetType.product) {
      bloc.lineitemdetail.value.productId = '$id';
      bloc.selectedValueP.value = name;
    } else if (bottomSheetType == SheetType.itemclass) {
      bloc.lineitemdetail.value.classId = '$id';
      bloc.selectedValueClass.value = name;
    } else if (bottomSheetType == SheetType.location) {
      bloc.lineitemdetail.value.locationId = '$id';
      bloc.selectedValueL.value = name;
    } else if (bottomSheetType == SheetType.customer) {
      bloc.lineitemdetail.value.customerId = '$id';
      bloc.selectedValueCustomer.value = name;
    }
  }
}
