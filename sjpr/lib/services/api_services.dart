import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:sjpr/di/app_component_base.dart';
import 'package:sjpr/model/api_response_location.dart';
import 'package:sjpr/model/api_response_taxrate.dart';
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
import 'package:sjpr/model/split_list_model.dart';
import 'package:sjpr/model/type_list_model.dart';
import 'package:sjpr/model/upload_invoice.dart';
import 'package:sjpr/services/api_client.dart';
import 'package:http/http.dart' as http;
import '../di/app_shared_preferences.dart';
import '../model/api_response_class.dart';
import '../model/api_response_costomer.dart';
import '../model/api_response_otprequest.dart';
import '../screen/invoice/custom_camera2.dart';

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
      if (data.result != null && data.status == true) {
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

  Future<CommonModelClass?> uploadProfilePic(
      {required String profilePath}) async {
    AppComponentBase.getInstance()?.showProgressDialog(true);
    AppComponentBase.getInstance()?.disableWidget(true);
    var request = http.MultipartRequest(
        "POST", Uri.parse(ApiClient.uploadProfilePicture));

    request.files.add(await http.MultipartFile.fromPath(
      'profile_image',
      profilePath,
    ));
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

  /*Future<CommonModelClass?> uploadInvoice({required XFile invoice}) async {
    */ /*  if (ApiClient.bearerToken.isEmpty) {
      var tokenValue = await AppComponentBase.getInstance()
          ?.getApiInterface()
          .getApiRepository()
          .token();
      if (tokenValue != null && tokenValue.accessToken != null) {
        if (tokenValue.accessToken!.isNotEmpty) {
          ApiClient.bearerToken = tokenValue.accessToken!;
        }
      }
    }*/ /*
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

    request.files.add(await http.MultipartFile.fromPath(
      'upload_invoice',
      invoice.path,
    ));
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
        invoices[i].capture.path,
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
  }*/

//new Engine function***************
  Future<CommonModelClass?> uploadInvoice(
      {required String invoicepath, required int isPurchase}) async {
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
    var result = invoicepath.split('.');
    var mimeType = result.last;
    Map body = {
      "invoice_type": mimeType,
      "upload_mode": "single",
      'is_purchase': isPurchase.toString(),
    };
    //String jsonString = json.encode(body);
    var request =
        http.MultipartRequest("POST", Uri.parse(ApiClient.uploadInvoice));
    for (var entry in body.entries) {
      request.fields[entry.key] = entry.value;
      if (kDebugMode) {
        print(entry.value);
      }
    }

    request.files.add(await http.MultipartFile.fromPath(
      'upload_invoice',
      invoicepath,
    ));
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
      required String uploadMode,
      required int isPurchase}) async {
    AppComponentBase.getInstance()?.showProgressDialog(true);
    AppComponentBase.getInstance()?.disableWidget(true);

    Map body = {
      "invoice_type": 'pdf',
      "upload_mode": uploadMode,
      'is_purchase': isPurchase.toString()
    };
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
        invoices[i].capturePath,
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

  //Ends here *********************

  Future<InvoiceList?> getInvoiceList(
      {required isPurchase, required page}) async {
    String url = "${ApiClient.getInvoiceList}/$page/$isPurchase";
    debugPrint('url : $url');
    var response =
        await gets(url, headers: getLogoutHeader(), isBackground: false);
    if (response != null) {
      var data = InvoiceList.fromJson(json.decode(response));
      return data;
    }
    return null;
  }

  Future<InvoiceList?> getArchiveList(
      String dt, int isPurchase, int page) async {
    Map<String, String> body = {
      'name_id': '',
      'updated_date': dt,
      'is_purchase': '$isPurchase',
    };
    var response = await posts("${ApiClient.getArchiveList}/$page",
        headers: getLogoutHeader(), body: body, isBackground: true);
    if (response != null) {
      var data = InvoiceList.fromJson(json.decode(response));
      return data;
    }
    return null;
  }

  Future<InvoiceDetail?> getInvoiceDetail(String id) async {
    var response = await gets("${ApiClient.getInvoiceDetail}/$id",
        headers: getLogoutHeader(), isBackground: false);
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

  Future<CommonModelClass?> CancelInvoice(String invid) async {
    Map<String, String> body = {
      'invoice_file_id': invid,
    };
    var response = await posts(ApiClient.cancelInvoice,
        headers: getLogoutHeader(), body: body, isBackground: true);
    if (response != null) {
      var data = CommonModelClass.fromJson(json.decode(response));
      return data;
    }
    return null;
  }

  Future<CommonModelClass?> MovetoInbox(String invid) async {
    Map<String, String> body = {
      'invoice_file_id': invid,
    };
    var response = await posts(ApiClient.movetoInbox,
        headers: getLogoutHeader(), body: body, isBackground: true);
    if (response != null) {
      var data = CommonModelClass.fromJson(json.decode(response));
      return data;
    }
    return null;
  }

  Future<CommonModelClass?> DeleteInvoice(String invid) async {
    Map<String, String> body = {
      'invoice_file_id': invid,
    };
    var response = await posts(ApiClient.deleteInvoice,
        headers: getLogoutHeader(), body: body, isBackground: true);
    if (response != null) {
      var data = CommonModelClass.fromJson(json.decode(response));
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

  Future<LineItemDetailApiResponse?> getLineItemDetail(
      String lineItemId) async {
    var response = await gets("${ApiClient.getLineItemDetail}$lineItemId",
        headers: getLogoutHeader(), isBackground: true);
    if (response != null) {
      var data = LineItemDetailApiResponse.fromJson(json.decode(response));
      return data;
    }
    return null;
  }

  Future<CommonModelClass?> insertLineItemDetail(
      Map<String, String> body) async {
    var response = await posts(ApiClient.insertLineItemDetail,
        headers: getLogoutHeader(), body: body, isBackground: true);
    if (response != null) {
      var data = CommonModelClass.fromJson(json.decode(response));
      return data;
    }
    return null;
  }

  Future<CommonModelClass?> updateLineItemDetail(
      Map<String, String> body) async {
    var response = await posts(ApiClient.updateLineItemDetail,
        headers: getLogoutHeader(), body: body, isBackground: true);
    if (response != null) {
      var data = CommonModelClass.fromJson(json.decode(response));
      return data;
    }
    return null;
  }

  Future<CommonModelClass?> deleteLineItemDetail(String invoiceId) async {
    Map<String, String> body = {
      'id': invoiceId,
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

  Future updateScannedInvoice(Map<String, dynamic> json) async {
    debugPrint(ApiClient.updateScannedInvoice);
    String req = jsonEncode(json);
    debugPrint(req);
    var response = await postJson(ApiClient.updateScannedInvoice,
        headers: getLogoutHeader(),
        body: const JsonEncoder().convert(json),
        isBackground: true);
    if (response != null) {
      //debugPrint('response succeed');
      var data = CommonModelClass.fromJson(jsonDecode(response));
      return data;
    }
    return null;
  }

  Future<CustomerApiResponse?> getAllCustomer({required int isPurchase}) async {
    var response = await gets("${ApiClient.getAllCustomers}/$isPurchase",
        headers: getLogoutHeader(), isBackground: true);
    if (response != null) {
      Map res = json.decode(response);
      return CustomerApiResponse.fromJson(res);
    }
    return null;
  }

  Future<ApiResponseClassModel?> getAllClass() async {
    var response = await gets(ApiClient.getAllClass,
        headers: getLogoutHeader(), isBackground: true);
    if (response != null) {
      Map res = json.decode(response);
      return ApiResponseClassModel.fromJson(res);
    }
    return null;
  }

  Future<ApiResponseLocationModel?> getAllLocation() async {
    var response = await gets(ApiClient.getAllLocation,
        headers: getLogoutHeader(), isBackground: true);
    if (response != null) {
      Map res = json.decode(response);
      return ApiResponseLocationModel.fromJson(res);
    }
    return null;
  }

  Future<ApiResponseTaxRate?> getAllTaxRate() async {
    var response = await gets(ApiClient.getAllTaxRate,
        headers: getLogoutHeader(), isBackground: true);
    if (response != null) {
      Map res = json.decode(response);
      return ApiResponseTaxRate.fromJson(res);
    }
    return null;
  }

  Future<CommonModelClass?> addSubcategory(
      String id, String categoryName, String code) async {
    Map<String, String> body = {
      'id': id,
      'category_name': categoryName,
      'code': "1234"
    };
    var response = await posts(ApiClient.postAddSubcategory,
        headers: getLogoutHeader(), body: body, isBackground: true);
    if (response != null) {
      var data = CommonModelClass.fromJson(json.decode(response));
      return data;
    }
    return null;
  }

  Future<CommonModelClass?> addCustomer(String cName,
      {required int isPurchase}) async {
    Map<String, String> body = {
      'customer_name': cName,
      'is_purchase': isPurchase.toString(),
    };
    var response = await posts(ApiClient.postAddCustomer,
        headers: getLogoutHeader(), body: body, isBackground: true);
    if (response != null) {
      var data = CommonModelClass.fromJson(json.decode(response));
      return data;
    }
    return null;
  }

  Future<CommonModelClass?> addClass(String cName) async {
    Map<String, String> body = {
      'class_name': cName,
    };
    var response = await posts(ApiClient.postAddClass,
        headers: getLogoutHeader(), body: body, isBackground: true);
    if (response != null) {
      var data = CommonModelClass.fromJson(json.decode(response));
      return data;
    }
    return null;
  }

  Future<CommonModelClass?> addLocation(String cName) async {
    Map<String, String> body = {
      'location_name': cName,
    };
    var response = await posts(ApiClient.postAddLocation,
        headers: getLogoutHeader(), body: body, isBackground: true);
    if (response != null) {
      var data = CommonModelClass.fromJson(json.decode(response));
      return data;
    }
    return null;
  }

  Future<SplitList?> getSplitItemList(String invoiceId) async {
    /* Map<String, String> body = {
      'location_name': cName,
    };
    var response = await posts(ApiClient.postAddLocation,
        headers: getLogoutHeader(), body: body, isBackground: true);*/
    var response = await gets("${ApiClient.getSplitItemList}$invoiceId",
        headers: getLogoutHeader(), isBackground: true);
    if (response != null) {
      var data = SplitList.fromJson(json.decode(response));
      return data;
    }
    return null;
  }

  Future<CommonModelClass?> insertSplitItemDetail(
    String invoiceId,
    String categoryId,
    String totalAmount,
    String totalTaxAmount,
  ) async {
    /* Map<String, String> body = {
      'location_name': cName,
    };
    var response = await posts(ApiClient.postAddLocation,
        headers: getLogoutHeader(), body: body, isBackground: true);*/
    var response = await gets("${ApiClient.getSplitItemList}$invoiceId",
        headers: getLogoutHeader(), isBackground: true);
    if (response != null) {
      var data = CommonModelClass.fromJson(json.decode(response));
      return data;
    }
    return null;
  }

  Future<CommonModelClass?> updateSplitItemList(
      List<SplitListDataRequest> lstSplitListDataRequest) async {
    String jsonData =
        jsonEncode(lstSplitListDataRequest.map((i) => i.toJson()).toList())
            .toString();
    debugPrint('request body : $jsonData');
    var response = await postJson(ApiClient.updateSplitItemDetail,
        headers: getLogoutHeader(), body: jsonData, isBackground: true);
    if (response != null) {
      var data = CommonModelClass.fromJson(json.decode(response));
      return data;
    }
    return null;
  }

  Future<OtpResponse?> sendOTP(String email) async {
    Map<String, String> body = {
      'email': email,
    };
    var response = await postJson(ApiClient.sendOTP,
        headers: getLoginHeader(), body: body, isBackground: true);
    if (response != null) {
      var data1 = OtpResponse.fromJson(json.decode(response));
      return data1;
    }
    return null;
  }

  Future<CommonModelClass?> newPassword(
      String pass, String confirmpass, String id) async {
    Map<String, String> body = {
      'id': id,
      'newpassword': pass,
      'confirm_password': confirmpass,
    };
    var response = await postJson(ApiClient.newPassword,
        headers: getLoginHeader(), body: body, isBackground: true);
    if (response != null) {
      var data = CommonModelClass.fromJson(json.decode(response));
      return data;
    }
    return null;
  }

  Future<CommonModelClass?> passwordReset(
      String old, String pass, String confirmpass) async {
    Map<String, String> body = {
      'oldpassword': old,
      'newpassword': pass,
      'confirm_password': confirmpass,
    };
    var response = await postJson(ApiClient.resetPassword,
        headers: getLogoutHeader(), body: body, isBackground: true);
    if (response != null) {
      var data = CommonModelClass.fromJson(json.decode(response));
      return data;
    }
    return null;
  }
}
