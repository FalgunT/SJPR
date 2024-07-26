import 'dart:async';
import 'package:intl/intl.dart';
import 'package:sjpr/common/bloc_provider.dart';
import 'package:sjpr/common/common_toast.dart';
import 'package:sjpr/di/app_component_base.dart';
import 'package:flutter/material.dart';
import 'package:sjpr/model/lineitem_detail_model.dart';
import 'package:sjpr/model/ownedby_list_model.dart';

class LineItemsBloc extends BlocBase {
  //StreamController mainStreamController = StreamController.broadcast();

  // StreamController<List<LineItemDetailData>?> lineItemDetailStreamController =
  //     StreamController.broadcast();

//  Stream get mainStream => mainStreamController.stream;

  // Stream<List<LineItemDetailData>?> get lineItemDetailStream =>
  //     lineItemDetailStreamController.stream;

  TextEditingController txtController = TextEditingController();

  LineItemDetailData? lineitemdetail;

  String selectedValue = "";

  /*String categoryValue = "";
  String productValue = "";
  String classValue = "";
  String locationValue = "";
  String customerValue = "";*/

  ValueNotifier<String> lineItemName = ValueNotifier<String>("Line Item 01");
  ValueNotifier<String> selectedValueC = ValueNotifier<String>("");

  ValueNotifier<String> selectedValueP = ValueNotifier<String>("");
  ValueNotifier<String> selectedValueClass = ValueNotifier<String>("");
  ValueNotifier<String> selectedValueL = ValueNotifier<String>("");
  ValueNotifier<String> selectedValueCustomer = ValueNotifier<String>("");

  ValueNotifier<String> selectedTotalAmt = ValueNotifier<String>("");
  ValueNotifier<String> selectedTaxAmt = ValueNotifier<String>("");
  ValueNotifier<String> selectedTaxRate = ValueNotifier<String>("");
  ValueNotifier<String> selectedNetAmt = ValueNotifier<String>("");
  ValueNotifier<String> selectedUnitPrice = ValueNotifier<String>("");
  ValueNotifier<String> selectedQuatity = ValueNotifier<String>("");

  List categoryList = [
    "None",
    "Accumulated Depreciation",
    "Ask My Accountant",
    "Buildings and Improvements",
    "Business Licenses and Permits",
    "Charitable Contributions",
    "Computer and Internet Expenses",
    "Counting Education",
    "Depreciation Expense"
  ];

  List productList = [
    "None",
    "Admin Fee",
    "Annual Return/Confirmation Statement",
    "Benefits",
    "Company Restoration",
    "Consultation On Liquidation",
    "CVA",
    "Business Event",
    "FCA Fees"
  ];

  List classList = [
    'None',
    "Bruno Portfolio",
    "Jonas Portfolio",
    "Luiz Portfolio",
    "Vitor Portfolio",
    "Wilson Portfolio"
  ];

  List locationList = [
    "None",
    "France",
    "Germany",
    "International",
    "Netherlands",
    "Portugal",
    "Saudi Arabia",
    "Spain",
    "United Kingdom"
  ];

  List customerList = [
    "None",
    "001 Client",
    "002 Client",
    "003 Client",
    "004 Client",
    "005 Client",
    "006 Client",
    "007 Client",
    "008 Client",
  ];

  Future getLineItemDetail(BuildContext context, String lineItemId) async {
    var getLineItemListResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getLineItemDetail(lineItemId);
    if (getLineItemListResponse != null) {
      if (getLineItemListResponse.message != null) {
        CommonToast.getInstance()
            ?.displayToast(message: getLineItemListResponse.message!);
      }
      if (getLineItemListResponse.status == true) {
        List<LineItemDetailData>? list = getLineItemListResponse.data;
        lineitemdetail = list?[0];
        debugPrint(lineitemdetail.toString());
        txtController.text = lineitemdetail?.description ?? "";
        selectedTotalAmt.value = getFormetted(lineitemdetail?.totalAmount ?? "0.0");
        selectedTaxAmt.value = getFormetted(lineitemdetail!.taxRate.toString()??"0.0");
        selectedTaxRate.value = getFormetted(lineitemdetail!.taxRate.toString()??"0.0");
        selectedNetAmt.value = getFormetted(lineitemdetail?.totalAmount ?? "0.0");
        selectedUnitPrice.value = getFormetted(lineitemdetail?.unitPrice ?? "0.0");
        selectedQuatity.value = getFormetted(lineitemdetail?.quantity ?? "0");
        // lineItemDetailStreamController.sink.add(getLineItemListResponse.data);
      } else {}
    }
  }
  getFormetted(String input){
    double number = double.parse(input);
    return  NumberFormat('##0.00').format(number);
  }
  @override
  void dispose() {}
}
