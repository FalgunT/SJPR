import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sjpr/di/app_component_base.dart';
import 'package:sjpr/di/shared_preferences.dart';
import 'package:sjpr/model/category_list_model.dart';
import 'package:sjpr/model/currency_model.dart';
import 'package:sjpr/model/invoice_detail_model.dart';
import 'package:sjpr/model/invoice_list_model.dart';
import 'package:sjpr/model/lineitem_detail_model.dart';
import 'package:sjpr/model/lineitem_list_model.dart';
import 'package:sjpr/model/login.dart';
import 'package:sjpr/model/ownedby_list_model.dart';
import 'package:sjpr/model/payment_methods.dart';
import 'package:sjpr/model/product_list_model.dart';
import 'package:sjpr/model/profile_model.dart';
import 'package:sjpr/model/publish_to.dart';
import 'package:sjpr/model/type_list_model.dart';
import 'package:sjpr/model/upload_invoice.dart';
import 'package:sjpr/services/api_client.dart';

import 'package:http/http.dart' as http;

import '../di/app_shared_preferences.dart';
import '../screen/invoice/custom_camera.dart';

class ApiServices extends ApiClient {
  Future<Login?> login(String email, String password) async {
    Map<String, String> body = {
      'email': email,
      'password': password,
    };
    var response = await posts(ApiClient.login,
        headers: getLoginHeader(), body: body, isBackground: true);
    if (response != null) {
      var data = Login.fromJson(json.decode(response));
      if (data != null && data.result != null && data.status == true) {
        ApiClient.logoutHeaderValue = data.result!.token!;
        await AppComponentBase.getInstance()
            ?.getSharedPreference()
            .setUserDetail(
                key: AppSharedPreference.token, value: data.result!.token!);
      }
      return data;
    }
    return null;
  }

  Future<CommonModelClass?> logout() async {
    var response = await posts(ApiClient.logout,
        headers: getLogoutHeader(), isBackground: true);
    if (response != null) {
      var data = CommonModelClass.fromJson(json.decode(response));
      return data;
    }
    return null;
  }

  Future<Profile?> profile() async {
    var response = await gets(ApiClient.profile,
        headers: getLogoutHeader(), isBackground: true);
    if (response != null) {
      var data = Profile.fromJson(json.decode(response));
      return data;
    }
    return null;
  }

  Future<CommonModelClass?> uploadInvoice({required XFile invoice}) async {
    /*  if (ApiClient.bearerToken.isEmpty) {
      var tokenValue = await AppComponentBase.getInstance()
          ?.getApiInterface()
          .getApiRepository()
          .token();
      if (tokenValue != null && tokenValue.accessToken != null) {
        if (tokenValue.accessToken!.isNotEmpty) {
          ApiClient.bearerToken = tokenValue.accessToken!;
        }
      }
    }*/
    AppComponentBase.getInstance()?.showProgressDialog(true);
    AppComponentBase.getInstance()?.disableWidget(true);
    var result = invoice.path.split('.');
    var mimeType = result.last;
    Map body = {"invoice_type": mimeType, "upload_mode": "single"};
    //String jsonString = json.encode(body);
    var request =
        http.MultipartRequest("POST", Uri.parse(ApiClient.uploadInvoice));
    for (var entry in body.entries) {
      request.fields[entry.key] = entry.value;
      if (kDebugMode) {
        print(entry.value);
      }
    }

    if (invoice != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'upload_invoice',
        invoice.path ?? "",
      ));
    }
    //request.headers.addAll(getLogoutHeader());
    var response = await postsMultipart(
      request,
      headers: getLogoutHeader(),
      encoding: Encoding.getByName('utf-8'),
      isBackground: true,
    );
    AppComponentBase.getInstance()?.showProgressDialog(false);
    AppComponentBase.getInstance()?.disableWidget(false);
    if (response != null) {
      var data = CommonModelClass.fromJson(json.decode(response));
      return data;
    }
    return null;
  }

  Future<CommonModelClass?> uploadMultiInvoice(
      {required List<CaptureModel> invoices,
      required String uploadMode}) async {
    AppComponentBase.getInstance()?.showProgressDialog(true);
    AppComponentBase.getInstance()?.disableWidget(true);

    Map body = {"invoice_type": 'pdf', "upload_mode": uploadMode};
    //String jsonString = json.encode(body);
    var request =
        http.MultipartRequest("POST", Uri.parse(ApiClient.uploadInvoice));
    for (var entry in body.entries) {
      request.fields[entry.key] = entry.value;
      if (kDebugMode) {
        print(entry.value);
      }
    }
    for (int i = 0; i < invoices.length; i++) {
      request.files.add(await http.MultipartFile.fromPath(
        'upload_invoice[]',
        invoices[i].capture.path ?? "",
      ));
    }

    //request.headers.addAll(getLogoutHeader());
    var response = await postsMultipart(
      request,
      headers: getLogoutHeader(),
      encoding: Encoding.getByName('utf-8'),
      isBackground: true,
    );
    AppComponentBase.getInstance()?.showProgressDialog(false);
    AppComponentBase.getInstance()?.disableWidget(false);
    if (response != null) {
      var data = CommonModelClass.fromJson(json.decode(response));
      return data;
    }
    return null;
  }

  Future<InvoiceList?> getInvoiceList() async {
    var response = await gets(ApiClient.getInvoiceList,
        headers: getLogoutHeader(), isBackground: true);
    if (response != null) {
      var data = InvoiceList.fromJson(json.decode(response));
      return data;
    }
    return null;
  }

  Future<InvoiceDetail?> getInvoiceDetail(String id) async {
    var response = await gets("${ApiClient.getInvoiceDetail}/$id",
        headers: getLogoutHeader(), isBackground: true);
    if (response != null) {
      var data = InvoiceDetail.fromJson(json.decode(response));
      return data;
    }
    return null;
  }

  Future<CategoryList?> getCategoryList() async {
    CategoryList? responseData;
    var response = await gets(ApiClient.getCategoryList,
        headers: getLogoutHeader(), isBackground: true);
    if (response != null) {
      responseData = CategoryList.fromJson(json.decode(response));
    }
    return responseData;
  }

  Future<ProductServicesList?> getProductList() async {
    var response = await gets(ApiClient.getProductList,
        headers: getLogoutHeader(), isBackground: true);
    if (response != null) {
      var data = ProductServicesList.fromJson(json.decode(response));
      return data;
    }
    return null;
  }

  Future<TypeList?> getTypeList() async {
    var response = await gets(ApiClient.getTypeList,
        headers: getLogoutHeader(), isBackground: true);
    if (response != null) {
      var data = TypeList.fromJson(json.decode(response));
      return data;
    }
    return null;
  }

  Future<OwnedByList?> getOwnedByList() async {
    var response = await gets(ApiClient.getOwnedByList,
        headers: getLogoutHeader(), isBackground: true);
    if (response != null) {
      var data = OwnedByList.fromJson(json.decode(response));
      return data;
    }
    return null;
  }

  Future<CommonModelClass?> addProduct(String pName) async {
    Map<String, String> body = {
      'product_name': pName,
    };
    var response = await posts(ApiClient.addProduct,
        headers: getLogoutHeader(), body: body, isBackground: true);
    if (response != null) {
      var data = CommonModelClass.fromJson(json.decode(response));
      return data;
    }
    return null;
  }

  Future<LineItemList?> getLineItemList(String invoiceId) async {
    var response = await gets("${ApiClient.getLineItemList}$invoiceId",
        headers: getLogoutHeader(), isBackground: true);
    if (response != null) {
      var data = LineItemList.fromJson(json.decode(response));
      return data;
    }

    return null;
  }

  Future<LineItemDetail?> getLineItemDetail(String lineItemId) async {
    var response = await gets("${ApiClient.getLineItemDetail}/$lineItemId",
        headers: getLogoutHeader(), isBackground: true);
    if (response != null) {
      var data = LineItemDetail.fromJson(json.decode(response));
      return data;
    }
    return null;
  }

  Future<CommonModelClass?> insertLineItemDetail(
      String invoiceId,
      String desc,
      String quantity,
      String unitPrice,
      String totalAmount,
      String name,
      String taxRate) async {
    Map<String, String> body = {
      'scanned_invoice_id': invoiceId,
      'description': desc,
      'quantity': quantity,
      'unit_price': unitPrice,
      'total_amount': totalAmount,
      'name': name,
      'tax_rate': taxRate,
    };
    var response = await posts(ApiClient.insertLineItemDetail,
        headers: getLogoutHeader(), body: body, isBackground: true);
    if (response != null) {
      var data = CommonModelClass.fromJson(json.decode(response));
      return data;
    }
    return null;
  }

  Future<OwnedByList?> updateLineItemDetail(
      String invoiceId,
      String desc,
      String quantity,
      String unitPrice,
      String totalAmount,
      String name,
      String taxRate) async {
    Map<String, String> body = {
      'scanned_invoice_id': invoiceId,
      'description': desc,
      'quantity': quantity,
      'unit_price': unitPrice,
      'total_amount': totalAmount,
      'name': name,
      'tax_rate': taxRate,
    };
    var response = await posts(ApiClient.updateLineItemDetail,
        headers: getLogoutHeader(), body: body, isBackground: true);
    if (response != null) {
      var data = OwnedByList.fromJson(json.decode(response));
      return data;
    }
    return null;
  }

  Future<CommonModelClass?> deleteLineItemDetail(String invoiceId) async {
    Map<String, String> body = {
      'scanned_invoice_id': invoiceId,
    };
    var response = await posts(ApiClient.deleteLineItemDetail,
        headers: getLogoutHeader(), body: body, isBackground: true);
    if (response != null) {
      var data = CommonModelClass.fromJson(json.decode(response));
      return data;
    }
    return null;
  }

  Future<List<CurrencyModel>?> getCurrencyList() async {
    var response = await gets(ApiClient.getCurrencyList,
        headers: getLogoutHeader(), isBackground: true);
    if (response != null) {
      Map res = json.decode(response);
      var listFromJson = res['data'] as List;
      List<CurrencyModel> currecyList =
          listFromJson.map((item) => CurrencyModel.fromJson(item)).toList();

      return currecyList;
    }
    return null;
  }

  Future<List<PaymentMethodsModel>?> getPaymentMethods() async {
    var response = await gets(ApiClient.getPaymentMethods,
        headers: getLogoutHeader(), isBackground: true);
    if (response != null) {
      Map res = json.decode(response);
      var listFromJson = res['data'] as List;
      List<PaymentMethodsModel> currecyList = listFromJson
          .map((item) => PaymentMethodsModel.fromJson(item))
          .toList();
      return currecyList;
    }
    return null;
  }

  Future<List<PublishToModel>?> getPublishTo() async {
    var response = await gets(ApiClient.getPublishTo,
        headers: getLogoutHeader(), isBackground: true);
    if (response != null) {
      Map res = json.decode(response);
      var listFromJson = res['data'] as List;
      List<PublishToModel> currecyList =
          listFromJson.map((item) => PublishToModel.fromJson(item)).toList();
      return currecyList;
    }
    return null;
  }

  Future updateScannedInvoice(Map<String, String> json) async {
    debugPrint(ApiClient.updateScannedInvoice);
    debugPrint(json.toString());
    var response = await posts(ApiClient.updateScannedInvoice,
        headers: getLogoutHeader(), body: json, isBackground: true);
    if (response != null) {
      debugPrint('response succeed');
    }
    return null;
  }
}
