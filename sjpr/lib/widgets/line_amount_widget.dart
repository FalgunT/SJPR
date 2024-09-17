import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sjpr/screen/invoice/invoice_detail_bloc.dart';
import 'package:sjpr/screen/lineitems/line_items_bloc.dart';
import 'package:sjpr/utils/color_utils.dart';

import '../common/AppEnums.dart';
import '../common/app_theme.dart';
import '../model/api_response_taxrate.dart';
import 'AddNewItemDialog.dart';
import 'CommonBottomSheetDialog.dart';

class LineAmountWidget extends StatefulWidget {
  LineItemsBloc bloc;
  bool isReadOnly;
  String curSign;

  LineAmountWidget(
      {super.key,
      required this.bloc,
      required this.curSign,
      required this.isReadOnly});

  @override
  State<LineAmountWidget> createState() => _LineAmountWidgetState();
}

class _LineAmountWidgetState extends State<LineAmountWidget> {
  late ApiLineAmount apiAmount;
  late int taxId;
  String error = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      //padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: listTileBgColor,
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          iconColor: activeTxtColor,
          collapsedIconColor: activeTxtColor,
          //backgroundColor: listTileBgColor,
          tilePadding: const EdgeInsets.symmetric(horizontal: 16),
          // Adjust the horizontal padding
          childrenPadding: EdgeInsets.zero,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Amount',
                style: TextStyle(
                    color: activeTxtColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "${widget.curSign} ${getApiTotal()}",
                style: TextStyle(
                    color: activeTxtColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          children: [
            commonRowWidget(context,
                title: "Quantity",
                value: widget.bloc.lineitemdetail.value.quantity, onTap: () {
              AddNewItemDialog(
                  isAmt: true,
                  context: context,
                  title: 'Edit Quantity',
                  hint: 'Enter Quantity',
                  label: 'Quantity',
                  oldValue: widget.bloc.lineitemdetail.value.quantity,
                  type: SheetType.none,
                  onPressed: (String v) {
                    debugPrint('F() called--->, $v');
                    widget.bloc.lineitemdetail.value.quantity = v;
                    setState(() {});
                  });
            }),
            commonRowWidget(context,
                title: "Unit price",
                value: widget.bloc
                    .getFormetted(widget.bloc.lineitemdetail.value.unitPrice),
                onTap: () {
              AddNewItemDialog(
                  isAmt: true,
                  context: context,
                  title: "Edit Unit price",
                  hint: 'Enter Unit price',
                  label: 'Unit price${widget.bloc.getCurrency(widget.curSign)}',
                  oldValue: widget.bloc
                      .getFormetted(widget.bloc.lineitemdetail.value.unitPrice),
                  type: SheetType.none,
                  onPressed: (String v) {
                    debugPrint('F() called--->, $v');
                    widget.bloc.lineitemdetail.value.unitPrice = v;
                    setState(() {});
                  });
            }),
            commonRowWidget(context,
                title: "Total",
                isClickable: false,
                value: widget.bloc.getFormetted(
                    widget.bloc.lineitemdetail.value.netAmount ?? "0.00"),
                isNumber: true, onTap: () {
              AddNewItemDialog(
                  isAmt: true,
                  context: context,
                  title: "Edit Total Amount",
                  hint: 'Enter Total Amount',
                  label:
                      'Total Amount ${widget.bloc.getCurrency(widget.curSign)}',
                  oldValue: widget.bloc.getFormetted(
                      widget.bloc.lineitemdetail.value.netAmount ?? "0.00"),
                  type: SheetType.none,
                  onPressed: (String v) {
                    debugPrint('F() called--->, $v');
                    widget.bloc.lineitemdetail.value.netAmount = v;
                    updateAmount();
                  });
            }),
            ValueListenableBuilder(
                valueListenable: widget.bloc.selectedValueTaxRate,
                builder: (context, value, _) {
                  return commonRowWidget(
                    context,
                    isClickable: !widget.isReadOnly,
                    title: "Tax rate",
                    value: value,
                    onTap: () {
                      CommonBottomSheetDialog(
                          context: context,
                          list: widget.bloc.taxRateList,
                          title: "Tax rate",
                          ItemId: widget.bloc.getId(SheetType.taxrate),
                          bottomSheetType: SheetType.taxrate,
                          Addf: () {},
                          onItemSelected: (id, name) {
                            widget.bloc.SetName(id, name, SheetType.taxrate);
                            Future.delayed(const Duration(milliseconds: 80),
                                () {
                              updateAmount();
                            });
                          }).Show();
                    },
                  );
                }),
            commonRowWidget(context,
                title: "Tax",
                isClickable: getClickStatus(),
                isNumber: true,
                value: widget.bloc.getFormetted(
                    widget.bloc.lineitemdetail.value.taxRate ?? "0.00"),
                onTap: () {
              AddNewItemDialog(
                  isAmt: true,
                  context: context,
                  title: "Edit Tax Amount",
                  hint: 'Enter Tax Amount',
                  label: 'Tax Amount${widget.bloc.getCurrency(widget.curSign)}',
                  oldValue: widget.bloc.getFormetted(
                      widget.bloc.lineitemdetail.value.taxRate ?? "0.00"),
                  type: SheetType.none,
                  onPressed: (String v) {
                    debugPrint('F() called--->, $v');
                    widget.bloc.lineitemdetail.value.taxRate = v;
                    updateAmount();
                  });
            }),
            commonRowWidget(context,
                title: "Total + Tax",
                isClickable: getClickStatus(),
                isNumber: true,
                value: widget.bloc.getFormetted(
                    widget.bloc.lineitemdetail.value.totalAmount ?? "0.00"),
                onTap: () {
              AddNewItemDialog(
                  isAmt: true,
                  context: context,
                  title: "Edit Tax Total",
                  hint: 'Enter Tax Total',
                  label: 'Tax Total${widget.bloc.getCurrency(widget.curSign)}',
                  oldValue: widget.bloc.getFormetted(
                      widget.bloc.lineitemdetail.value.totalAmount ?? "0.00"),
                  type: SheetType.none,
                  onPressed: (String v) {
                    debugPrint('F() called--->, $v');
                    widget.bloc.lineitemdetail.value.totalAmount = v;
                    setState(() {});
                  });
            }),
            widget.isReadOnly
                ? const Center()
                : error == ""
                    ? const Center()
                    : Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          error,
                          style: const TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.w200,
                              fontSize: 12),
                        ),
                      ),
            widget.isReadOnly
                ? Center()
                : SizedBox(
                    width: MediaQuery.of(context).size.width - 80,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        reset();
                      },
                      icon: Icon(
                        Icons.reset_tv_outlined,
                        size: 14,
                        color: activeTxtColor,
                      ),
                      // The icon inside the button
                      label: Text(
                        'Reset Amount',
                        style: TextStyle(
                          color: activeTxtColor,
                        ),
                      ),
                      // The text inside the button
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.amberAccent,
                        side: BorderSide(color: activeTxtColor, width: 1),
                        // Border color and width
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(8), // Rounded corners
                        ), // Icon and text color
                      ),
                    ),
                  ),
            const SizedBox(
              height: 8,
            )
          ],
        ),
      ),
    );
  }

  Widget commonRowWidget(BuildContext context,
      {required title,
      required value,
      required Function onTap,
      isNumber = false,
      isClickable = true}) {
    final appTheme = AppTheme.of(context);
    return InkWell(
      onTap: () {
        if (!isClickable) return;
        onTap();
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: appTheme.listTileBgColor,
        ),
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                  color: appTheme.textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              width: 5,
            ),
            isNumber
                ? Expanded(
                    child: Text(
                      '${widget.curSign} $value',
                      style: TextStyle(color: appTheme.textColor, fontSize: 14),
                      textAlign: TextAlign.end,
                    ),
                  )
                : Expanded(
                    child: Text(
                      value ?? "None",
                      style: TextStyle(color: appTheme.textColor, fontSize: 14),
                      textAlign: TextAlign.end,
                    ),
                  ),
            const SizedBox(
              width: 5,
            ),
            (isClickable)
                ? Icon(
                    Icons.arrow_forward_ios,
                    color: appTheme.textColor,
                  )
                : const Center()
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    taxId = getTaxRateValue();
    apiAmount = ApiLineAmount(
        billAmount: widget.bloc.lineitemdetail.value.netAmount ?? '0.00',
        taxAmount: widget.bloc.lineitemdetail.value.taxRate ?? '0.00',
        taxId: widget.bloc.lineitemdetail.value.taxRateId ?? "",
        grandTotal: widget.bloc.lineitemdetail.value.totalAmount ?? '0.00',
        qty: widget.bloc.lineitemdetail.value.quantity ?? '0',
        unitP: widget.bloc.lineitemdetail.value.unitPrice ?? '0');
    debugPrint('-------------------------------------------');
    debugPrint(apiAmount.toString());
    debugPrint('-------------------------------------------');
    setInitial();
  }

  void setInitial() {
    double qty = double.parse(apiAmount.qty);
    double up = double.parse(apiAmount.unitP);
    double tot = qty * up;

    widget.bloc.lineitemdetail.value.netAmount =
        apiAmount.billAmount = tot.toStringAsFixed(2);
  }

  void reset() {
    error = "";
    widget.bloc.lineitemdetail.value.quantity = apiAmount.qty;
    widget.bloc.lineitemdetail.value.unitPrice = apiAmount.unitP;
    widget.bloc.lineitemdetail.value.netAmount = apiAmount.billAmount;
    widget.bloc.lineitemdetail.value.taxRate = apiAmount.taxAmount;
    widget.bloc.lineitemdetail.value.totalAmount = apiAmount.grandTotal;
    if (apiAmount.taxId.isEmpty) {
      apiAmount.taxId = widget.bloc.lineitemdetail.value.taxRateId =
          widget.bloc.taxRateList.first.id;
      widget.bloc.selectedValueTaxRate.value =
          widget.bloc.taxRateList.first.taxRate;
    } else {
      widget.bloc.lineitemdetail.value.taxRateId = apiAmount.taxId;
      widget.bloc.selectedValueTaxRate.value =
          getTaxnameFromId(apiAmount.taxId);
    }

    setState(() {});
  }

  void updateAmount() {
    error = "";
    int id = getTaxRateValue();
    taxId = id;
    if (id > -1) {
      //calculate all...
      double billamt =
          double.parse(widget.bloc.lineitemdetail.value.netAmount ?? "0.00");
      double tax = (billamt * id) / 100;
      widget.bloc.lineitemdetail.value.taxRate = (tax).toStringAsFixed(2);
      widget.bloc.lineitemdetail.value.totalAmount =
          (billamt + tax).toStringAsFixed(2);
    }
    checkforApiAmount();
    setState(() {});
  }

  int getTaxRateValue() {
    for (int i = 0; i < widget.bloc.taxRateList.length; i++) {
      if (widget.bloc.taxRateList[i].id ==
          widget.bloc.lineitemdetail.value.taxRateId) {
        if (i == 0) {
          return -1;
        } else if (i == 1 || i == 4 || i == 5) {
          return 0;
        } else if (i == 2) {
          return 20;
        } else if (i == 3) return 5;
      }
    }
    return -1;
  }

  getApiTotal() {
    double? tot = double.parse(apiAmount.grandTotal);
    if (tot == 0.0) {
      return widget.bloc.lineitemdetail.value.totalAmount ?? '0.00';
    } else {
      return apiAmount.grandTotal;
    }
  }

  void checkforApiAmount() {
    double? localTotal =
        double.parse(double.parse(apiAmount.grandTotal).toStringAsFixed(2));
    double? tot = double.parse(
        double.parse(widget.bloc.lineitemdetail.value.totalAmount ?? '0.00')
            .toStringAsFixed(2));
    debugPrint('local:' + localTotal.toString());
    debugPrint('api:' + tot.toString());
    //check if initial value is 0 for the invoice
    if(localTotal==0){
      error ="";
      return;
    }
    if (localTotal != tot) {
      error = "The line item total amount does not match!";
    } else {
      error = "";
    }
  }

  getClickStatus() {
    if (widget.isReadOnly) {
      return false;
    }
    try {
      if (widget.bloc.lineitemdetail.value.taxRateId !=
          widget.bloc.taxRateList.first.id) {
        return false;
      }
    } catch (e) {
      print(e);
    }
    return true;
  }

  String getTaxnameFromId(String taxId) {
    for (DataItem obj in widget.bloc.taxRateList) {
      if (obj.id == taxId) {
        return obj.taxRate;
      }
    }
    return '';
  }
}

class ApiLineAmount {
  String qty;
  String unitP;
  String billAmount;
  String taxAmount;
  String grandTotal;
  String taxId;

  ApiLineAmount(
      {required this.qty,
      required this.unitP,
      required this.billAmount,
      required this.taxAmount,
      required this.grandTotal,
      required this.taxId});

  @override
  String toString() {
    return 'ApiLineAmount{qty: $qty, unitP: $unitP, billAmount: $billAmount, taxAmount: $taxAmount, grandTotal: $grandTotal, taxId: $taxId}';
  }
}
