import 'dart:async';
import 'dart:ffi';
import 'package:intl/intl.dart';
import 'package:sjpr/common/bloc_provider.dart';
import 'package:sjpr/common/common_toast.dart';
import 'package:sjpr/di/app_component_base.dart';
import 'package:flutter/material.dart';
import 'package:sjpr/model/currency_model.dart';
import 'package:sjpr/model/invoice_detail_model.dart';
import 'package:sjpr/model/lineitem_list_model.dart';
import 'package:sjpr/model/payment_methods.dart';
import 'package:sjpr/model/publish_to.dart';
import 'package:sjpr/model/split_list_model.dart';
import 'package:sjpr/model/type_list_model.dart';

import '../../common/AppEnums.dart';
import '../../model/api_response_taxrate.dart';
import '../../model/category_list_model.dart';
import '../../model/product_list_model.dart';
import '../../widgets/check_box.dart';

class InvoiceDetailBloc extends BlocBase {
  ValueNotifier<InvoiceDetailData> invoiceDetailData =
      ValueNotifier<InvoiceDetailData>(InvoiceDetailData.empty());

  List<PaymentMethodsModel> pmList = [];
  List<PublishToModel> publishToList = [];
  List<CurrencyModel> curList = [];
  List<CategoryListData> cList = [];
  List<TypeListData> tList = [];
  List<ProductServicesListData> pList = [];
  List<DataItem> taxRateList = [];
  ValueNotifier<bool> isWaitingForDetail = ValueNotifier<bool>(true);

  ValueNotifier<String> ownedBy = ValueNotifier<String>("None");
  ValueNotifier<String> selectedValueC = ValueNotifier<String>("None");
  ValueNotifier<String> selectedValueP = ValueNotifier<String>("None");
  ValueNotifier<String> selectedValueT = ValueNotifier<String>("None");
  ValueNotifier<String> selectedValueCur = ValueNotifier<String>("");
  ValueNotifier<String> selectedValueCurSign = ValueNotifier<String>("");
  ValueNotifier<String> selectedValuePM = ValueNotifier<String>("None");
  ValueNotifier<String> selectedValuePT = ValueNotifier<String>("None");
  ValueNotifier<String> selectedValueTaxRate = ValueNotifier<String>("None");

  ValueNotifier<bool> hideCat = ValueNotifier<bool>(false);
  ValueNotifier<bool> hideProd = ValueNotifier<bool>(false);
  ValueNotifier<bool> switchVal = ValueNotifier<bool>(true);

  Future getInvoiceDetail(BuildContext context, String id) async {
    isWaitingForDetail.value = true;
    var getInvoiceDetailResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getInvoiceDetail(id);
    if (getInvoiceDetailResponse != null) {
      if (getInvoiceDetailResponse.status == false &&
          getInvoiceDetailResponse.message != null) {
        CommonToast.getInstance()?.displayToast(
            message: getInvoiceDetailResponse.message!, bContext: context);
      }
      if (getInvoiceDetailResponse.status == true &&
          getInvoiceDetailResponse.data != null) {
        invoiceDetailData.value = getInvoiceDetailResponse.data!;
        await checkNullAmount();
        getLineItemList(context, invoiceDetailData.value.id!);
      }
    }
    isWaitingForDetail.value = false;
  }

  checkNullAmount() async {
    invoiceDetailData.value.totalAmount =
        getFormetted(invoiceDetailData.value.totalAmount ?? '0.00');
    invoiceDetailData.value.netAmount =
        getFormetted(invoiceDetailData.value.netAmount ?? '0.00');
    invoiceDetailData.value.totalTaxAmount =
        getFormetted(invoiceDetailData.value.totalTaxAmount ?? '0.00');
  }

  Future getLineItemList(BuildContext context, String invoiceId) async {
    var getLineItemListResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getLineItemList(invoiceId);
    if (getLineItemListResponse != null) {
      bool lineCat = false, lineProduct = false;
      //check for category and product selection on any item
      invoiceDetailData.value.line_item_count =
          getLineItemListResponse.data!.length;
      for (int i = 0; i < getLineItemListResponse.data!.length; i++) {
        LineItemListData obj = getLineItemListResponse.data![i];
        if (obj.scannedLineItemCategoryId.isNotEmpty &&
            obj.scannedLineItemCategoryId != '0') {
          lineCat = true;
          break;
        }
      }

      for (int i = 0; i < getLineItemListResponse.data!.length; i++) {
        LineItemListData obj = getLineItemListResponse.data![i];
        if (obj.productServicesId!.isNotEmpty && obj.productServicesId != '0') {
          lineProduct = true;
          break;
        }
      }
      Map<dynamic, dynamic> result = {
        "CAT": lineCat,
        "PROD": lineProduct,
      };
      Check_Cat_Prod(result);
    }
  }

  Future getSplitItemList(BuildContext context, String invoiceId) async {
    var getSplitItemListResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getSplitItemList(invoiceId);
    if (getSplitItemListResponse != null) {
      bool lineCat = false, lineProduct = false;
      //check for category and product selection on any item
      invoiceDetailData.value.split_item_count =
          getSplitItemListResponse.data!.length;
      for (int i = 0; i < getSplitItemListResponse.data!.length; i++) {
        SplitListData obj = getSplitItemListResponse.data![i];
        if (obj.categoryId!.isNotEmpty && obj.categoryId != '0') {
          lineCat = true;
          break;
        }
      }

      Map<dynamic, dynamic> result = {
        "CAT": lineCat,
        "PROD": lineProduct,
      };
      Check_Cat_Prod(result);
    }
  }

  Future getAllTaxRate(BuildContext context, {bool isAdd = false}) async {
    var getResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getAllTaxRate();
    if (getResponse != null) {
      taxRateList = getResponse.data;
      taxRateList.forEach(
        (element) {
          if (element.id == invoiceDetailData.value.taxRateId) {
            selectedValueTaxRate.value = element.taxRate;
          }
        },
      );
      if (isAdd) {
        selectedValueTaxRate.value = taxRateList.last.taxRate;
        invoiceDetailData.value.taxRateId = taxRateList.last.id;
      } else {
        String id = invoiceDetailData.value.taxRateId ?? '';
        if (id.isEmpty) {
          selectedValueTaxRate.value = taxRateList.first.taxRate;
          invoiceDetailData.value.taxRateId = taxRateList.first.id;
        }
      }
    }
  }

  Future getProfile(BuildContext context) async {
    if (await AppComponentBase.getInstance()
            ?.getNetworkManager()
            .isConnected() ??
        false) {
      var getProfile = await AppComponentBase.getInstance()
          ?.getApiInterface()
          .getApiRepository()
          .profile();

      if (getProfile != null) {
        if (getProfile.status == true) {
          ownedBy.value =
              '${getProfile.data?.firstname} ${getProfile.data?.lastname}';
          //profileStreamController.sink.add(getProfile.data);
        }
      }
    }
  }

  Future CancelInvoice() async {
    var getResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .CancelInvoic(invoiceDetailData.value.invoiceFileId!);
    if (getResponse != null) {
      return getResponse.status;
    }
    return false;
  }

  Future getDetailCategory(BuildContext context) async {
    var getCategoryListResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getCategoryList();
    if (getCategoryListResponse != null) {
      cList = getCategoryListResponse.data!.categories;
      cList.forEach(
        (element) {
          element.list?.forEach(
            (o) {
              if (o.sub_category_id ==
                  invoiceDetailData.value.scanned_category_id) {
                selectedValueC.value = o.sub_category_name ?? 'None';
              }
            },
          );
        },
      );
    }
  }

  Future getDetailType(BuildContext context, String invoiceId) async {
    var getCategoryListResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getTypeList();
    if (getCategoryListResponse != null) {
      /* if (getLineItemListResponse.status == false &&
          getLineItemListResponse.message != null) {
        CommonToast.getInstance()
            ?.displayToast(message: getLineItemListResponse.message!);
      }*/
      tList = getCategoryListResponse.data!;

      tList.forEach(
        (element) {
          if (element.id == invoiceDetailData.value.scanned_type_id) {
            selectedValueT.value = element.typeName ?? 'None';
          }
        },
      );
    }
  }

  /*Future getDetailOwnBy(BuildContext context, String invoiceId) async {
    var getCategoryListResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getOwnedByList();
    if (getCategoryListResponse != null) {
      */ /* if (getLineItemListResponse.status == false &&
          getLineItemListResponse.message != null) {
        CommonToast.getInstance()
            ?.displayToast(message: getLineItemListResponse.message!);
      }*/ /*
      oList = getCategoryListResponse.data!;

    }
  }
*/
  Future getProductService(BuildContext context, {bool isAdd = false}) async {
    var getCategoryListResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getProductList();
    if (getCategoryListResponse != null) {
      pList = getCategoryListResponse.data!;
      pList.forEach(
        (element) {
          if (element.id ==
              invoiceDetailData.value.scanned_product_service_id) {
            selectedValueP.value = element.productServicesName ?? 'None';
          }
        },
      );

      if (isAdd) {
        selectedValueP.value = pList.last.productServicesName ?? 'None';
        invoiceDetailData.value.scanned_product_service_id = pList.last.id!;
      }
    }
  }

  Future addProductService(BuildContext context, String pName) async {
    var getCategoryListResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .addProduct(pName: pName);
    if (getCategoryListResponse != null) {
      //refresh the page...
      getProductService(context, isAdd: true);
    }
  }

  Future addSubcategory(
      BuildContext context, String id, String categoryName) async {
    var getCategoryListResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .addSubcategory(id, categoryName, "");
    if (getCategoryListResponse != null) {
      if (getCategoryListResponse.message != null) {
        CommonToast.getInstance()?.displayToast(
            bContext: context, message: getCategoryListResponse.message!);
      }
      //refresh the page...
      getDetailCategory(
        context,
      );
    }
  }

  Future getCurrency(BuildContext context) async {
    var getCategoryListResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getCurrencyList();
    if (getCategoryListResponse != null) {
      curList = getCategoryListResponse;
      for (var element in curList) {
        if (element.id == invoiceDetailData.value.scanned_currency_id) {
          selectedValueCur.value = element.currency_name ?? '';
          selectedValueCurSign.value = element.currency_sign ?? '';
        }
      }
    }
  }

  Future getPaymentMethods(BuildContext context) async {
    var getCategoryListResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getpaymentmethod();
    if (getCategoryListResponse != null) {
      pmList = getCategoryListResponse;
      for (var element in pmList) {
        if (element.id == invoiceDetailData.value.payment_method_id) {
          selectedValuePM.value = element.method_name ?? 'None';
        }
      }
    }
  }

  Future getPublishTo(BuildContext context) async {
    var getCategoryListResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getPublishTo();
    if (getCategoryListResponse != null) {
      publishToList = getCategoryListResponse;
      for (var element in publishToList) {
        if (element.id == invoiceDetailData.value.publish_to_id) {
          selectedValuePT.value = element.name ?? 'None';
        }
      }
    }
  }

  Future<bool> updateScannedInvoice(
      Map<String, dynamic> json, BuildContext context) async {
    var getResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .updateScannedInvoice(json);
    if (getResponse != null) {
      if (getResponse.message != null) {
        CommonToast.getInstance()
            ?.displayToast(message: getResponse.message!, bContext: context);
      }
      if (getResponse.status == true) {
        return true;
      }
    }
    return false;
  }

  getCheckBoxList(int flag) async {
    List<CheckBoxItem> cItems = [];
    if (flag == 0) {
      for (CategoryListData? obj in cList) {
        cItems.add(CheckBoxItem.withChildren(
            isSelected: false,
            text: obj!.name!,
            itemId: obj.id!,
            myChildren: obj.list!));
      }
    } else if (flag == 1) {
      for (ProductServicesListData? obj in pList) {
        cItems.add(CheckBoxItem(
            isSelected: false,
            text: obj!.productServicesName!,
            itemId: obj.id!));
      }
    } else if (flag == 2) {
      for (TypeListData? obj in tList) {
        cItems.add(CheckBoxItem(
            isSelected: false, text: obj!.typeName!, itemId: obj.id!));
      }
    } else if (flag == 6) {
      for (CurrencyModel? obj in curList) {
        cItems.add(CheckBoxItem(
            isSelected: false, text: obj!.currency_name!, itemId: obj.id!));
      }
    } else if (flag == 7) {
      for (PaymentMethodsModel? obj in pmList) {
        cItems.add(CheckBoxItem(
            isSelected: false, text: obj!.method_name!, itemId: obj.id!));
      }
    } else if (flag == 8) {
      for (PublishToModel? obj in publishToList) {
        cItems.add(
            CheckBoxItem(isSelected: false, text: obj!.name!, itemId: obj.id!));
      }
    }

    return cItems;
  }

  getFormetted(String input) {
    if (input == null || input.isEmpty) {
      input = "0";
    }
    String res = "0.00";
    try {
      double number = double.parse(input);
      res = NumberFormat('##0.00').format(number);
    } catch (e) {
      debugPrint(e.toString());
      res = "0.00";
    }
    return res;
  }

  getCurrencySign() {
    String sign = selectedValueCurSign.value;
    if (sign.isEmpty) {
      return '';
    } else {
      return ' ($sign)';
    }
  }

  String getCurrencySignById() {
    String sign = '';
    for (var element in curList) {
      if (element.id == invoiceDetailData.value.scanned_currency_id) {
        sign = element.currency_sign ?? '';
        break;
      }
    }
    return sign;
  }

  getId(bottomSheetType) {
    String id = "0";
    if (bottomSheetType == SheetType.product) {
      id = invoiceDetailData.value.scanned_product_service_id ?? '';
    } else if (bottomSheetType == SheetType.category) {
      id = invoiceDetailData.value.scanned_category_id ?? '';
    } else if (bottomSheetType == SheetType.type) {
      id = invoiceDetailData.value.scanned_type_id ?? '';
    } else if (bottomSheetType == SheetType.currency) {
      id = invoiceDetailData.value.scanned_currency_id ?? '';
    } else if (bottomSheetType == SheetType.paymentmethods) {
      id = invoiceDetailData.value.payment_method_id ?? '';
    } else if (bottomSheetType == SheetType.publishto) {
      id = invoiceDetailData.value.publish_to_id ?? '';
    } else if (bottomSheetType == SheetType.taxrate) {
      id = invoiceDetailData.value.taxRateId ?? '';
    }
    if (id.isEmpty) {
      id = '0';
    }
    return int.parse(id);
  }

  void SetName(id, name, bottomSheetType) {
    if (bottomSheetType == SheetType.product) {
      invoiceDetailData.value.scanned_product_service_id = '$id';
      selectedValueP.value = name;
    } else if (bottomSheetType == SheetType.type) {
      invoiceDetailData.value.scanned_type_id = '$id';
      selectedValueT.value = name;
    } else if (bottomSheetType == SheetType.currency) {
      invoiceDetailData.value.scanned_currency_id = '$id';
      selectedValueCur.value = name;
      selectedValueCurSign.value = getCurrencySignById();
    } else if (bottomSheetType == SheetType.paymentmethods) {
      invoiceDetailData.value.payment_method_id = '$id';
      selectedValuePM.value = name;
    } else if (bottomSheetType == SheetType.publishto) {
      invoiceDetailData.value.publish_to_id = '$id';
      selectedValuePT.value = name;
    } else if (bottomSheetType == SheetType.category) {
      invoiceDetailData.value.scanned_category_id = '$id';
      selectedValueC.value = name;
    } else if (bottomSheetType == SheetType.taxrate) {
      invoiceDetailData.value.taxRateId = '$id';
      selectedValueTaxRate.value = name;
    }
  }

  bool isValid(BuildContext context) {
    if (!hideCat.value) {
      String catid = invoiceDetailData.value.scanned_category_id ?? "";
      if (catid == "") {
        CommonToast.getInstance()?.displayToast(
            message: "Category field is required", bContext: context);
        return false;
      }
    }
    /*if (!hideProd.value) {
      String pid = invoiceDetailData.value.scanned_product_service_id ?? "";
      if (pid == "") {
        CommonToast.getInstance()?.displayToast(
            message: "Product/Service field is required", bContext: context);
        return false;
      }
    }*/

    String tid = invoiceDetailData.value.scanned_type_id ?? "";
    if (tid == "") {
      CommonToast.getInstance()
          ?.displayToast(message: "Type field is required", bContext: context);
      return false;
    }
    String duedate = invoiceDetailData.value.dueDate ?? "";
    if (tid != '1' && duedate == "") {
      //check for type receipt
      CommonToast.getInstance()?.displayToast(
          message: "Due Date field is required", bContext: context);
      return false;
    }
    String invid = invoiceDetailData.value.invoiceId ?? "";
    if (tid != '1' && invid == "") {
      //check for type receipt
      CommonToast.getInstance()?.displayToast(
          message: "Invoice Number field is required", bContext: context);
      return false;
    }
    String curid = invoiceDetailData.value.scanned_currency_id ?? "";
    if (curid == "") {
      CommonToast.getInstance()?.displayToast(
          message: "Currency field is required", bContext: context);
      return false;
    }
    String total = invoiceDetailData.value.totalAmount ?? "";
    if (total.isEmpty) {
      CommonToast.getInstance()?.displayToast(
          message: "Total  field is required", bContext: context);
      return false;
    }
    String tax = invoiceDetailData.value.totalTaxAmount ?? "";
    if (tax.isEmpty) {
      invoiceDetailData.value.totalTaxAmount = "0";
      // CommonToast.getInstance()
      //     ?.displayToast(message: "Tax  field is required", bContext: context);
      // return false;
    }
    String net = invoiceDetailData.value.netAmount ?? "";
    if (net.isEmpty) {
      CommonToast.getInstance()?.displayToast(
          message: "Tax Total field is required", bContext: context);
      return false;
    }
    String pmid = invoiceDetailData.value.payment_method_id ?? "";
    if (tid != '1' && pmid == "") {
      //check for type receipt
      CommonToast.getInstance()?.displayToast(
          message: "Payment method field is required", bContext: context);
      return false;
    }
    String pubid = invoiceDetailData.value.publish_to_id ?? "";
    if (tid != '1' && pubid == "") {
      //check for type receipt
      CommonToast.getInstance()?.displayToast(
          message: "Publish To field is required", bContext: context);
      return false;
    }
    return true;
  }

  Map<dynamic, dynamic> line_result = {};
  Map<dynamic, dynamic> split_result = {};

  void Check_Cat_Prod(Map<dynamic, dynamic> res) {
    debugPrint('--->Response from line item list: $res');
    line_result = res;
    //check for result catgory and product..
    if (line_result.isNotEmpty) {
      hideCat.value = line_result['CAT'];
      hideProd.value = line_result['PROD'];
      if (hideCat.value) {
        //set main category empty  and hide the widget
        invoiceDetailData.value.scanned_category_id = "";
        selectedValueC.value = "None";
      }

      if (hideProd.value) {
        //set main prod empty  and hide the widget
        invoiceDetailData.value.scanned_product_service_id = "";
        selectedValueP.value = "None";
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
