import 'dart:async';
import 'package:intl/intl.dart';
import 'package:sjpr/common/bloc_provider.dart';
import 'package:sjpr/common/common_toast.dart';
import 'package:sjpr/di/app_component_base.dart';
import 'package:flutter/material.dart';
import 'package:sjpr/model/api_response_class.dart';
import 'package:sjpr/model/lineitem_detail_model.dart';
import 'package:sjpr/model/product_list_model.dart';

import '../../common/AppEnums.dart';
import '../../model/api_response_costomer.dart';
import '../../model/api_response_location.dart';
import '../../model/api_response_taxrate.dart';
import '../../model/currency_model.dart';

class LineItemsBloc extends BlocBase {
  TextEditingController txtController = TextEditingController();
  ValueNotifier<bool> isWaitingForDetail = ValueNotifier<bool>(true);

  ValueNotifier<LineItem> lineitemdetail =
      ValueNotifier<LineItem>(LineItem.empty());

  ValueNotifier<String> selectedValueC = ValueNotifier<String>("None");
  ValueNotifier<String> selectedValueP = ValueNotifier<String>("None");
  ValueNotifier<String> selectedValueClass = ValueNotifier<String>("None");
  ValueNotifier<String> selectedValueL = ValueNotifier<String>("None");

  //ValueNotifier<String> selectedValueCur = ValueNotifier<String>("");
  ValueNotifier<String> selectedValueCustomer = ValueNotifier<String>("None");
  ValueNotifier<String> selectedValueTaxRate = ValueNotifier<String>("None");

  List categoryList = [];
  List<ProductServicesListData> productList = [];
  List<CData> classList = [];
  List<Record1> locationList = [];
  List<Customer> customerList = [];
  List<DataItem> taxRateList = [];

  //List<CurrencyModel> currencyList = [];

  Future getLineItemDetail(BuildContext context, String lineItemId) async {
    isWaitingForDetail.value = true;
    var getLineItemListResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getLineItemDetail(lineItemId);
    if (getLineItemListResponse != null) {
      if (getLineItemListResponse.status == true) {
        lineitemdetail.value = getLineItemListResponse.data.first;
        debugPrint(lineitemdetail.value.toString());
        await setValues();
      }
      if (getLineItemListResponse.status == false) {
        CommonToast.getInstance()?.displayToast(
            message: getLineItemListResponse.message, bContext: context);
      }
    }

    isWaitingForDetail.value = false;
  }

  Future getDetailCategory(BuildContext context) async {
    var getCategoryListResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getCategoryList();
    if (getCategoryListResponse != null) {
      categoryList = getCategoryListResponse.data!.categories;

      categoryList.forEach(
        (element) {
          element.list?.forEach(
            (o) {
              if (o.sub_category_id == lineitemdetail.value.categoryId) {
                selectedValueC.value = o.sub_category_name ?? 'None';
              }
            },
          );
        },
      );
    }
  }

  Future getProductService(BuildContext context, {bool isAdd = false}) async {
    var getCategoryListResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getProductList();
    if (getCategoryListResponse != null) {
      productList = getCategoryListResponse.data!;
      productList.forEach(
        (element) {
          if (element.id == lineitemdetail.value.productId) {
            selectedValueP.value = element.productServicesName ?? 'None';
          }
        },
      );
      if (isAdd) {
        selectedValueP.value = productList.last.productServicesName ?? 'None';
        lineitemdetail.value.productId = productList.last.id!;
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

  Future getAllCustomer(BuildContext context,
      {bool isAdd = false, required int isPurchase}) async {
    var getResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getAllCustomer(isPurchase: isPurchase);
    if (getResponse != null) {
      customerList = getResponse.data;
      customerList.forEach(
        (element) {
          if (element.id == lineitemdetail.value.customerId) {
            selectedValueCustomer.value = element.customerName;
          }
        },
      );
      if (isAdd) {
        selectedValueCustomer.value = customerList.last.customerName;
        lineitemdetail.value.customerId = customerList.last.id;
      }
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
      getDetailCategory(context);
    }
  }

  Future addCustomer(BuildContext context, String pName,
      {required int isPurchase}) async {
    var getCategoryListResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .AddCustomer(cName: pName, isPurchase: isPurchase);
    if (getCategoryListResponse != null) {
      //refresh the page...
      getAllCustomer(context, isAdd: true, isPurchase: isPurchase);
    }
  }

  Future getAllClass(BuildContext context, {bool isAdd = false}) async {
    var getResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getAllClass();
    if (getResponse != null) {
      classList = getResponse.data;

      classList.forEach(
        (element) {
          if (element.id == lineitemdetail.value.classId) {
            selectedValueClass.value = element.className;
          }
        },
      );
      if (isAdd) {
        selectedValueClass.value = classList.last.className;
        lineitemdetail.value.classId = classList.last.id;
      }
    }
  }

  Future getAllLocations(BuildContext context, {bool isAdd = false}) async {
    var getResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getAllLocation();
    if (getResponse != null) {
      if (getResponse.error != null && getResponse.error!.isNotEmpty) {
        CommonToast.getInstance()?.displayToast(
            bContext: context,
            message: getResponse.error ?? "Some thing wrong");
        return;
      }
      locationList = getResponse.data;
      locationList.forEach(
        (element) {
          if (element.id == lineitemdetail.value.locationId) {
            selectedValueL.value = element.location;
          }
        },
      );
      if (isAdd) {
        selectedValueL.value = locationList.last.location;
        lineitemdetail.value.locationId = locationList.last.id;
      }
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
          if (element.id == lineitemdetail.value.taxRateId) {
            selectedValueTaxRate.value = element.taxRate;
          }
        },
      );
      if (isAdd) {
        selectedValueTaxRate.value = taxRateList.last.taxRate;
        lineitemdetail.value.taxRateId = taxRateList.last.id;
      } else {
        if (lineitemdetail.value.taxRateId.isEmpty) {
          selectedValueTaxRate.value = taxRateList.first.taxRate;
          lineitemdetail.value.taxRateId = taxRateList.first.id;
        }
      }
    }
  }

  getCategoryId() {
    String catid = '0';
    if (lineitemdetail.value.categoryId.isEmpty) {
      catid = '0';
    } else {
      catid = lineitemdetail.value.categoryId;
    }
    return int.parse(catid);
  }

  getId(bottomSheetType) {
    String id = "0";
    if (bottomSheetType == SheetType.product) {
      id = lineitemdetail.value.productId;
    } else if (bottomSheetType == SheetType.itemclass) {
      id = lineitemdetail.value.classId;
    } else if (bottomSheetType == SheetType.location) {
      id = lineitemdetail.value.locationId;
    } else if (bottomSheetType == SheetType.customer) {
      id = lineitemdetail.value.customerId;
    } else if (bottomSheetType == SheetType.taxrate) {
      id = lineitemdetail.value.taxRateId;
    }
    if (id.isEmpty) {
      id = '0';
    }
    return int.parse(id);
  }

  void SetName(id, name, bottomSheetType) {
    if (bottomSheetType == SheetType.product) {
      lineitemdetail.value.productId = '$id';
      selectedValueP.value = name;
    } else if (bottomSheetType == SheetType.itemclass) {
      lineitemdetail.value.classId = '$id';
      selectedValueClass.value = name;
    } else if (bottomSheetType == SheetType.location) {
      lineitemdetail.value.locationId = '$id';
      selectedValueL.value = name;
    } else if (bottomSheetType == SheetType.customer) {
      lineitemdetail.value.customerId = '$id';
      selectedValueCustomer.value = name;
    } else if (bottomSheetType == SheetType.taxrate) {
      lineitemdetail.value.taxRateId = '$id';
      selectedValueTaxRate.value = name;
    } else if (bottomSheetType == SheetType.category) {
      lineitemdetail.value.categoryId = '$id';
      selectedValueC.value = name;
    }
  }

  bool isValid(BuildContext context) {
    String catid = lineitemdetail.value.categoryId ?? "";
    /*if (catid == "") {
      CommonToast.getInstance()?.displayToast(
          message: "Category field is required", bContext: context);
      return false;
    }
    String pid = lineitemdetail.value.productId ?? "";
    if (pid == "") {
      CommonToast.getInstance()?.displayToast(
          message: "Product/Service field is required", bContext: context);
      return false;
    }*/
    /* String tid = lineitemdetail.value.classId ?? "";
    if (tid == "") {
      CommonToast.getInstance()
          ?.displayToast(message: "Class field is required", bContext: context);
      return false;
    }
    String loc = lineitemdetail.value.locationId ?? "";
    if (loc == "") {
      CommonToast.getInstance()?.displayToast(
          message: "Location field is required", bContext: context);
      return false;
    }
    String cus = lineitemdetail.value.customerId ?? "";
    if (cus == "") {
      CommonToast.getInstance()?.displayToast(
          message: "Customer field is required", bContext: context);
      return false;
    }*/
    String total = lineitemdetail.value.totalAmount ?? "";
    if (total.isEmpty) {
      CommonToast.getInstance()?.displayToast(
          message: "Total  field is required", bContext: context);
      return false;
    }
    String tax = lineitemdetail.value.taxRate ?? "";
    if (tax.isEmpty) {
      CommonToast.getInstance()
          ?.displayToast(message: "Tax  field is required", bContext: context);
      return false;
    }
    String net = lineitemdetail.value.netAmount ?? "";
    if (net.isEmpty) {
      CommonToast.getInstance()?.displayToast(
          message: "Net Amount field is required", bContext: context);
      return false;
    }
    return true;
  }

  getCurrency(String currencySign) {
    if (currencySign.isEmpty) {
      return '';
    }
    return ' ($currencySign)';
  }

  /*Future getCurrency(BuildContext context) async {
    var getCategoryListResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getCurrencyList();
    if (getCategoryListResponse != null) {
      currencyList = getCategoryListResponse;
      for (var element in currencyList) {
        if (element.id == lineitemdetail.value.currencyId) {
          selectedValueCur.value = element.currency_sign!;
        }
      }
    }
  }*/

  @override
  void dispose() {}

  Future<bool> updateLineItem(BuildContext context) async {
    var getResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .updateLineItemDetail(lineitemdetail.value.toJson());
    if (getResponse != null) {
      if (getResponse.error != null && getResponse.error!.isNotEmpty) {
        CommonToast.getInstance()
            ?.displayToast(message: getResponse.error!, bContext: context);
      }
      if (getResponse.message != null && getResponse.message!.isNotEmpty) {
        CommonToast.getInstance()
            ?.displayToast(message: getResponse.message!, bContext: context);
      }

      if (getResponse.status == true) {
        return true;
      }
    }
    return false;
  }

  Future<bool> insertLineItem(BuildContext context) async {
    var getResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .insertLineItemDetail(lineitemdetail.value.toJson());
    if (getResponse != null) {
      if (getResponse.error != null && getResponse.error!.isNotEmpty) {
        CommonToast.getInstance()
            ?.displayToast(message: getResponse.error!, bContext: context);
      }
      if (getResponse.message != null && getResponse.message!.isNotEmpty) {
        CommonToast.getInstance()
            ?.displayToast(message: getResponse.message!, bContext: context);
      }

      if (getResponse.status == true) {
        return true;
      }
    }
    return false;
  }

  Future<void> addClass(BuildContext context, String pName) async {
    var getCategoryListResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .AddClass(cName: pName);
    if (getCategoryListResponse != null) {
      //refresh the page...
      getAllClass(context, isAdd: true);
    }
  }

  Future<void> addlocation(BuildContext context, String pName) async {
    var getCategoryListResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .AddLocation(cName: pName);
    if (getCategoryListResponse != null) {
      //refresh the page...
      getAllLocations(context, isAdd: true);
    }
  }

  deleteLineItemDetail(String invoiceId, BuildContext context) async {
    var getResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .deleteLineItemDetail(invoiceId);
    if (getResponse != null) {
      //refresh the page...
      if (getResponse.error != null && getResponse.error!.isNotEmpty) {
        CommonToast.getInstance()
            ?.displayToast(message: getResponse.error!, bContext: context);
        return false;
      }
      if (getResponse.status == true) {
        return true;
      }
    }
    return false;
  }

  setValues() async {
    if (lineitemdetail.value.name == null ||
        lineitemdetail.value.name.isEmpty) {
      lineitemdetail.value.name = lineitemdetail.value.description ?? "";
    }
    txtController.text = lineitemdetail.value.description ?? "";
    await checkNullAmount();
  }

  checkNullAmount() async {
    lineitemdetail.value.totalAmount =
        getFormetted(lineitemdetail.value.totalAmount ?? '0.00');
    lineitemdetail.value.netAmount =
        getFormetted(lineitemdetail.value.netAmount ?? '0.00');
    lineitemdetail.value.taxRate =
        getFormetted(lineitemdetail.value.taxRate ?? '0.00');

    lineitemdetail.value.quantity =
        getFormetted(lineitemdetail.value.quantity ?? '0.00');

    lineitemdetail.value.unitPrice =
        getFormetted(lineitemdetail.value.unitPrice ?? '0.00');
  }

  getFormetted(String input) {
    if (input == null || input.isEmpty) {
      input = "0";
    }
    double number = double.parse(input);
    return NumberFormat('##0.00').format(number);
  }

/*getIntFormetted(String input) {
    if (input == null || input.isEmpty) {
      input = "0";
    }
    int number = 0;
    try {
      number = int.parse(input);
    } catch (e) {
      print(e);
    }
    return number.toString();
  }*/
}
