import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:sjpr/model/category_list_model.dart';
import 'package:sjpr/screen/lineitems/line_items_bloc.dart';
import 'package:sjpr/utils/color_utils.dart';
import 'package:sjpr/widgets/AddNewItemDialog.dart';
import 'package:sjpr/widgets/CommonBottomSheetDialog.dart';
import 'package:sjpr/widgets/common_button.dart';
import 'package:sjpr/model/api_response_class.dart' as itemclass;
import 'package:sjpr/widgets/delete_confirmation_dialog.dart';

import '../../common/AppEnums.dart';
import '../../common/common_toast.dart';
import '../../utils/textinput_utils.dart';
import '../../widgets/expandable_radio_list.dart';
import '../../widgets/radio_button_list.dart';

class LineItemsDetailScreen extends StatefulWidget {
  final String invoice_id;
  final String lineitem_id;
  final String currencySign;

  const LineItemsDetailScreen(
      {super.key,
      required this.invoice_id,
      required this.lineitem_id,
      required this.currencySign});

  @override
  State<LineItemsDetailScreen> createState() => _LineItemsDetailScreenState();
}

class _LineItemsDetailScreenState extends State<LineItemsDetailScreen> {
  LineItemsBloc bloc = LineItemsBloc();
  final _focusNode = FocusNode();

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
                        focusNode: _focusNode,
                        onEditingComplete: () => _focusNode.unfocus(),
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
                                /*singleSelectBottomSheet(
                                    context: context,
                                    list: bloc.categoryList,
                                    title: "Category",
                                    bottomSheetType: SheetType.category);*/
                                CommonBottomSheetDialog(
                                    context: context,
                                    list: bloc.categoryList,
                                    title: "Category",
                                    ItemId: getCategoryId(),
                                    bottomSheetType: SheetType.category,
                                    Addf: () {},
                                    onItemSelected: (id, name) {
                                      SetName(id, name, SheetType.category);
                                    }).Show();
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
                                //bloc.selectedValue = 0;
                                /*  singleSelectBottomSheet(
                                    context: context,
                                    list: bloc.productList,
                                    title: "Product/Service",
                                    bottomSheetType: SheetType.product);*/

                                CommonBottomSheetDialog(
                                    context: context,
                                    list: bloc.productList,
                                    title: "Product/Service",
                                    ItemId: getId(SheetType.product),
                                    bottomSheetType: SheetType.product,
                                    Addf: (String v) {
                                      bloc.addProductService(context, v);
                                    },
                                    onItemSelected: (id, name) {
                                      SetName(id, name, SheetType.product);
                                    }).Show();
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
                                CommonBottomSheetDialog(
                                    context: context,
                                    list: bloc.classList,
                                    title: "Class",
                                    ItemId: getId(SheetType.itemclass),
                                    bottomSheetType: SheetType.itemclass,
                                    Addf: (String v) {
                                      bloc.addClass(context, v);
                                    },
                                    onItemSelected: (id, name) {
                                      SetName(id, name, SheetType.itemclass);
                                    }).Show();
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
                                CommonBottomSheetDialog(
                                    context: context,
                                    list: bloc.locationList,
                                    title: "Location",
                                    ItemId: getId(SheetType.location),
                                    bottomSheetType: SheetType.location,
                                    Addf: (String v) {
                                      bloc.addlocation(context, v);
                                    },
                                    onItemSelected: (id, name) {
                                      SetName(id, name, SheetType.location);
                                    }).Show();
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
                                CommonBottomSheetDialog(
                                    context: context,
                                    list: bloc.customerList,
                                    title: "Customer",
                                    ItemId: getId(SheetType.customer),
                                    bottomSheetType: SheetType.customer,
                                    Addf: (String v) {
                                      bloc.addCustomer(context, v);
                                    },
                                    onItemSelected: (id, name) {
                                      SetName(id, name, SheetType.customer);
                                    }).Show();
                              },
                              context: context);
                        }),
                    commonRowWidget(
                        title: "Quantity",
                        value: bloc.lineitemdetail.value.quantity,
                        onTap: () {
                          AddNewItemDialog(
                              isAmt: true,
                              context: context,
                              title: 'Edit Quantity',
                              hint: 'Enter Quantity',
                              label: 'Quantity',
                              oldValue: bloc.lineitemdetail.value.quantity,
                              type: SheetType.none,
                              onPressed: (String v) {
                                debugPrint('F() called--->, $v');
                                bloc.lineitemdetail.value.quantity = v;
                                setState(() {});
                              });
                        },
                        context: context),
                    commonRowWidget(
                        isAmt: true,
                        title: "Unit price",
                        value: bloc
                            .getFormetted(bloc.lineitemdetail.value.unitPrice),
                        onTap: () {
                          AddNewItemDialog(
                              isAmt: true,
                              context: context,
                              title: "Edit Unit price",
                              hint: 'Enter Unit price',
                              label: 'Unit price${getCurrency()}',
                              oldValue: bloc.getFormetted(
                                  bloc.lineitemdetail.value.unitPrice),
                              type: SheetType.none,
                              onPressed: (String v) {
                                debugPrint('F() called--->, $v');
                                bloc.lineitemdetail.value.unitPrice = v;
                                setState(() {});
                              });
                        },
                        context: context),
                    commonRowWidget(
                        isAmt: true,
                        title: "Net Amount",
                        value: bloc
                            .getFormetted(bloc.lineitemdetail.value.netAmount),
                        onTap: () {
                          AddNewItemDialog(
                              isAmt: true,
                              context: context,
                              title: "Edit Net Amount",
                              hint: 'Enter Net Amount',
                              label: 'Net Amount${getCurrency()}',
                              oldValue: bloc.getFormetted(
                                  bloc.lineitemdetail.value.netAmount),
                              type: SheetType.none,
                              onPressed: (String v) {
                                debugPrint('F() called--->, $v');
                                bloc.lineitemdetail.value.netAmount = v;
                                setState(() {});
                              });
                        },
                        context: context),
                    ValueListenableBuilder(
                        valueListenable: bloc.selectedValueTaxRate,
                        builder: (context, value, _) {
                          return commonRowWidget(
                              title: "Tax rate",
                              value: value,
                              onTap: () {
                                CommonBottomSheetDialog(
                                    context: context,
                                    list: bloc.taxRateList,
                                    title: "Tax rate",
                                    ItemId: getId(SheetType.taxrate),
                                    bottomSheetType: SheetType.taxrate,
                                    Addf: () {},
                                    onItemSelected: (id, name) {
                                      SetName(id, name, SheetType.taxrate);
                                    }).Show();
                              },
                              context: context);
                        }),

                    /**/
                    commonRowWidget(
                        isAmt: true,
                        title: "Tax Amount",
                        value: bloc
                            .getFormetted(bloc.lineitemdetail.value.taxRate),
                        onTap: () {
                          AddNewItemDialog(
                              isAmt: true,
                              context: context,
                              title: "Edit Tax Amount",
                              hint: 'Enter Tax Amount',
                              label: 'Tax Amount${getCurrency()}',
                              oldValue: bloc.getFormetted(
                                  bloc.lineitemdetail.value.taxRate),
                              type: SheetType.none,
                              onPressed: (String v) {
                                debugPrint('F() called--->, $v');
                                bloc.lineitemdetail.value.taxRate = v;
                                setState(() {});
                              });
                        },
                        context: context),
                    commonRowWidget(
                        isAmt: true,
                        title: "Total Amount",
                        value: bloc.getFormetted(
                            bloc.lineitemdetail.value.totalAmount),
                        onTap: () {
                          AddNewItemDialog(
                              isAmt: true,
                              context: context,
                              title: "Edit Total Amount",
                              hint: 'Enter Total Amount',
                              label: 'Total Amount${getCurrency()}',
                              oldValue: bloc.getFormetted(
                                  bloc.lineitemdetail.value.totalAmount),
                              type: SheetType.none,
                              onPressed: (String v) {
                                debugPrint('F() called--->, $v');
                                bloc.lineitemdetail.value.totalAmount = v;
                                setState(() {});
                              });
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
                          bloc.lineitemdetail.value.name =
                              bloc.lineitemdetail.value.name.isEmpty
                                  ? "LineItem"
                                  : bloc.lineitemdetail.value.name;
                          //bool lineCat = false, lineProduct = false;

                          if (isValid()) {
                            if (widget.lineitem_id.isNotEmpty) {
                              //update
                              bool res = await bloc.updateLineItem(context);
                              if (res) {
                                Navigator.pop(context, res);
                              }
                            } else {
                              //insert
                              bool res = await bloc.insertLineItem(context);
                              if (res) {
                                Navigator.pop(context, res);
                              }
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

  Widget commonRowWidget(
      {required title,
      required value,
      required onTap,
      bool isAmt = false,
      required context}) {
    return InkWell(
      onTap: () {
        _focusNode.unfocus();
        onTap();
      },
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
              child: isAmt
                  ? Text(
                      '${widget.currencySign} $value',
                      style: TextStyle(color: textColor, fontSize: 17),
                      textAlign: TextAlign.end,
                    )
                  : Text(
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

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DeleteConfirmationDialog(
          label: 'Delete line',
          onPressed: () async {
            bool res = await bloc.deleteLineItemDetail(
                bloc.lineitemdetail.value.id, context);
            if (res) {
              Navigator.of(context).pop(); // Close the dialog
              Navigator.of(context).pop(res); // Close the page
              // Add your delete logic here
            }
          },
        );
      },
    );
  }

  Future<void> _init() async {
    if (widget.lineitem_id.isNotEmpty) {
      await bloc.getLineItemDetail(context, widget.lineitem_id);
    }else{
      bloc.lineitemdetail.value.invoiceId = widget.invoice_id;
    }
    bloc.getDetailCategory(context);
    bloc.getProductService(context);
    bloc.getAllCustomer(context);
    bloc.getAllTaxRate(context);
    bloc.getAllClass(context);
    bloc.getAllLocations(context);
    // bloc.getCurrency(context);
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
    } else if (bottomSheetType == SheetType.taxrate) {
      id = bloc.lineitemdetail.value.taxRateId;
    }
    if (id.isEmpty) {
      id = '0';
    }
    return int.parse(id);
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
    } else if (bottomSheetType == SheetType.taxrate) {
      bloc.lineitemdetail.value.taxRateId = '$id';
      bloc.selectedValueTaxRate.value = name;
    } else if (bottomSheetType == SheetType.category) {
      bloc.lineitemdetail.value.categoryId = '$id';
      bloc.selectedValueC.value = name;
    }
  }

  bool isValid() {
    String catid = bloc.lineitemdetail.value.categoryId ?? "";
    /*if (catid == "") {
      CommonToast.getInstance()?.displayToast(
          message: "Category field is required", bContext: context);
      return false;
    }
    String pid = bloc.lineitemdetail.value.productId ?? "";
    if (pid == "") {
      CommonToast.getInstance()?.displayToast(
          message: "Product/Service field is required", bContext: context);
      return false;
    }*/
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

  getCurrency() {
    if(widget.currencySign.isEmpty){
      return '';
    }
    return ' (${widget.currencySign})';
  }
}
