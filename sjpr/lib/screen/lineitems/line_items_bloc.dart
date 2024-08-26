import 'dart:async';
import 'package:intl/intl.dart';
import 'package:sjpr/common/bloc_provider.dart';
import 'package:sjpr/common/common_toast.dart';
import 'package:sjpr/di/app_component_base.dart';
import 'package:flutter/material.dart';
import 'package:sjpr/model/api_response_class.dart';
import 'package:sjpr/model/lineitem_detail_model.dart';
import 'package:sjpr/model/product_list_model.dart';

import '../../model/api_response_costomer.dart';
import '../../model/api_response_location.dart';
import '../../model/api_response_taxrate.dart';
import '../../model/currency_model.dart';

class LineItemsBloc extends BlocBase {
  TextEditingController txtController = TextEditingController();

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
    var getLineItemListResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getLineItemDetail(lineItemId);
    if (getLineItemListResponse != null) {
      CommonToast.getInstance()?.displayToast(
          bContext: context, message: getLineItemListResponse.message!);
      if (getLineItemListResponse.status == true) {
        lineitemdetail.value = getLineItemListResponse.data.first;
        debugPrint(lineitemdetail.value.toString());
        setValues();
      }
    }
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

  Future getAllCustomer(BuildContext context, {bool isAdd = false}) async {
    var getResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getAllCustomer();
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

  Future addCustomer(BuildContext context, String pName) async {
    var getCategoryListResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .AddCustomer(cName: pName);
    if (getCategoryListResponse != null) {
      //refresh the page...
      getAllCustomer(context, isAdd: true);
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
      }
    }
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

  void setValues() {
    txtController.text = lineitemdetail.value.description ?? "";
  }

  getFormetted(String input) {
    if (input == null || input.isEmpty) {
      input = "0";
    }
    double number = double.parse(input);
    return NumberFormat('##0.00').format(number);
  }
}
