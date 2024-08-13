import 'dart:convert';

import 'package:sjpr/common/common_toast.dart';
import 'package:sjpr/utils/string_utils.dart';
import 'package:sjpr/di/app_component_base.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  static String baseUrl = 'https://sjprcrm.com/api/client';
  static String freshDeskUrl = '';
  static String userManualUrl = '';
  static String version = "";
  static String resultflagSuccess = "Success";
  final String jsonHeaderName = 'Content-Type';
  final String headerAuthorization = 'Authorization';
  final String loginHeaderName = 'authtoken';
  final String loginHeaderValue =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyIjoic2FnYXJzaGFybWFAdmlydHVhbGVtcGxveWVlLmNvbSIsIm5hbWUiOiJzYWdhcnNoYXJtYSIsIkFQSV9USU1FIjoxNzA5NzE0NDAzfQ.IchiPWgaKBftdjr8xfetUEehTriVkDRNM4E4QqLXARA';
  final String logoutHeaderName = 'usertoken';
  static String logoutHeaderValue = '';

  final String jsonHeaderValue = 'application/json; charset=UTF-8';
  final String urlEncodedHeaderValue = 'application/x-www-form-urlencoded';
  final String formHeaderValue =
      'multipart/form-data; boundary=<calculated when request is sent>';

  //var successResponse = [200, 201, 400, 401, 404, 422];
  static String otpTypeSMS = "sms";
  static String otpTypeEmail = "email";

  static String bearerToken = "";
  static String login = "$baseUrl/login";
  static String logout = "$baseUrl/logout";
  static String profile = "$baseUrl/profile";
  static String uploadInvoice = "$baseUrl/scaninvoice";
  static String getInvoiceList = "$baseUrl/invoices";
  static String getInvoiceDetail = "$baseUrl/invoicedata";
  static String getCategoryList = "$baseUrl/getcategory";
  static String getProductList = "$baseUrl/getproductservices";
  static String getTypeList = "$baseUrl/detailstype";
  static String getOwnedByList = "$baseUrl/getownedby";

  static String cancelInvoice = '$baseUrl/move/to/archive';
  static String addProduct = "$baseUrl/addproductservices";
  static String getCurrencyList = "$baseUrl/getcurrencylist";
  static String getPaymentMethods = "$baseUrl/getpaymentmethod";
  static String getPublishTo = "$baseUrl/getpublishto";

  static String postAddCustomer = "$baseUrl/addcustomers";
  static String postAddClass = "$baseUrl/addclass";
  static String postAddLocation = "$baseUrl/addlocation";

  static String getAllCustomers = "$baseUrl/getallcustomers";
  static String getAllClass = "$baseUrl/getallclass";
  static String getAllLocation = "$baseUrl/getalllocation";
  static String getAllTaxRate = "$baseUrl/getalltaxrate";

  static String updateScannedInvoice = "$baseUrl/scanned/invoice/update";
  static String getLineItemList = "$baseUrl/invoice/line/item/list/";
  static String getLineItemDetail = "$baseUrl/invoice/line/item/details/";
  static String insertLineItemDetail = "$baseUrl/invoice/line/item/insert";
  static String updateLineItemDetail = "$baseUrl/invoice/line/item/update";
  static String deleteLineItemDetail = "$baseUrl/invoice/line/item/delete";

  static String getSplitItemList = "$baseUrl/invoice/split/list/";
  static String insertSplitItemDetail = "$baseUrl/invoice/split/insert";

  static final RegExp nameRegExp = RegExp('[a-zA-Z]');

  Map<String, String> getJsonHeader() {
    var header = <String, String>{};
    header[jsonHeaderName] = jsonHeaderValue;
    header[headerAuthorization] = 'Bearer $bearerToken';
    return header;
  }

  Map<String, String> getUrlEncodedHeader() {
    var header = <String, String>{};
    header[jsonHeaderName] = urlEncodedHeaderValue;
    return header;
  }

  Map<String, String> getLoginHeader() {
    var header = <String, String>{};
    header[loginHeaderName] = loginHeaderValue;
    return header;
  }

  Map<String, String> getLogoutHeader() {
    var header = <String, String>{};
    header[loginHeaderName] = loginHeaderValue;
    header[logoutHeaderName] = logoutHeaderValue;
    return header;
  }

  Map<String, String> getFormHeader() {
    var header = <String, String>{};
    header[jsonHeaderName] = formHeaderValue;
    header[headerAuthorization] = 'Bearer $bearerToken';
    return header;
  }

  gets(String url,
      {Map<String, String>? headers,
      bool isProgressBar = true,
      bool isBackground = false}) async {
    headers ??= getJsonHeader();
    if (await AppComponentBase.getInstance()
            ?.getNetworkManager()
            .isConnected() ??
        false) {
      if (isProgressBar) {
        AppComponentBase.getInstance()?.showProgressDialog(true);
      }
      AppComponentBase.getInstance()?.disableWidget(true);
      try {
        var response = await http.get(Uri.parse(url), headers: headers);
        if (response.bodyBytes.isNotEmpty) {
          //(successResponse.contains(response.statusCode)) {
          AppComponentBase.getInstance()?.disableWidget(false);
          String bodyBytes = utf8.decode(response.bodyBytes);
          logPrint(requestData: "", response: response);
          if (isProgressBar) {
            AppComponentBase.getInstance()?.showProgressDialog(false);
          }
          return bodyBytes;
        }
        if (isProgressBar) {
          AppComponentBase.getInstance()?.showProgressDialog(false);
        }
        AppComponentBase.getInstance()?.disableWidget(false);
      } catch (exception) {
        if (isProgressBar) {
          AppComponentBase.getInstance()?.showProgressDialog(false);
        }
        AppComponentBase.getInstance()?.disableWidget(false);

        var e =
            exception is String ? exception : StringUtils.someThingWentWrong;
        if (!isBackground) {
          CommonToast.getInstance()?.displayToast(message: e);
        }
      }
    } else {
      if (!isBackground) {
        CommonToast.getInstance()
            ?.displayToast(message: StringUtils.noInternetContent);
      }
      if (isProgressBar) {
        AppComponentBase.getInstance()?.showProgressDialog(false);
      }
      AppComponentBase.getInstance()?.disableWidget(false);
      throw StringUtils.noInternetContent;
    }
  }

  posts(String url,
      {Map<String, String>? headers,
      dynamic body,
      Encoding? encoding,
      bool isProgressBar = true,
      bool isBackground = false}) async {
    headers ??= getJsonHeader();
    if (await AppComponentBase.getInstance()
            ?.getNetworkManager()
            .isConnected() ??
        false) {
      if (isProgressBar) {
        AppComponentBase.getInstance()?.showProgressDialog(true);
        AppComponentBase.getInstance()?.disableWidget(true);
      }
      try {
        /*http.Response response = await http.post(Uri.parse(url),
            headers: headers, body: body, encoding: encoding);*/

        var request = http.MultipartRequest('POST', Uri.parse(url));
        //request.fields.addAll(body);
        if (body != null) {
          request.fields.addAll(body);
        }
        request.headers.addAll(headers);

        http.StreamedResponse response = await request.send();

        if (response.statusCode != null) {
          //logPrint(requestData: body, response: response);

          if (isProgressBar) {
            AppComponentBase.getInstance()?.showProgressDialog(false);
          }
          AppComponentBase.getInstance()?.disableWidget(false);

          String bodyBytes = await response.stream.bytesToString();

          debugPrint('request body : $body');
          debugPrint('response body : $bodyBytes');
          return bodyBytes;
        }
        /*
        print(response.body);
        if (response.statusCode != 200) return null;
        Map<String, dynamic> map = json.decode(response.body);
        return map;
        //return List<Map<String, dynamic>>.from(json.decode(response.body));
        var responseStatus = json.decode(response.body);
        return responseStatus;*/
      } catch (exception) {
        debugPrint(exception.toString());
        if (isProgressBar) {
          AppComponentBase.getInstance()?.showProgressDialog(false);
        }
        AppComponentBase.getInstance()?.disableWidget(false);
        var e =
            exception is String ? exception : StringUtils.someThingWentWrong;
        if (!isBackground) {
          CommonToast.getInstance()?.displayToast(message: e);
        }
      }
      if (isProgressBar) {
        AppComponentBase.getInstance()?.showProgressDialog(false);
      }
      AppComponentBase.getInstance()?.disableWidget(false);
    } else {
      if (!isBackground) {
        CommonToast.getInstance()
            ?.displayToast(message: StringUtils.noInternetContent);
      }
      //throw StringUtils.noInternetContent;
    }
  }

  postJson(String url,
      {Map<String, String>? headers,
      dynamic body,
      Encoding? encoding,
      bool isProgressBar = true,
      bool isBackground = false}) async {
    headers ??= getJsonHeader();
    if (await AppComponentBase.getInstance()
            ?.getNetworkManager()
            .isConnected() ??
        false) {
      if (isProgressBar) {
        AppComponentBase.getInstance()?.showProgressDialog(true);
        AppComponentBase.getInstance()?.disableWidget(true);
      }
      try {
        http.Response response = await http.post(Uri.parse(url),
            headers: headers, body: body, encoding: encoding);

        if (response.statusCode != null) {
          if (isProgressBar) {
            AppComponentBase.getInstance()?.showProgressDialog(false);
          }
          AppComponentBase.getInstance()?.disableWidget(false);
          String bodyBytes = response.body;
          debugPrint('response body : $bodyBytes');
          return bodyBytes;
        }
        /*
        print(response.body);
        if (response.statusCode != 200) return null;
        Map<String, dynamic> map = json.decode(response.body);
        return map;
        //return List<Map<String, dynamic>>.from(json.decode(response.body));
        var responseStatus = json.decode(response.body);
        return responseStatus;*/
      } catch (exception) {
        debugPrint(exception.toString());
        if (isProgressBar) {
          AppComponentBase.getInstance()?.showProgressDialog(false);
        }
        AppComponentBase.getInstance()?.disableWidget(false);
        var e =
            exception is String ? exception : StringUtils.someThingWentWrong;
        if (!isBackground) {
          CommonToast.getInstance()?.displayToast(message: e);
        }
      }
      if (isProgressBar) {
        AppComponentBase.getInstance()?.showProgressDialog(false);
      }
      AppComponentBase.getInstance()?.disableWidget(false);
    } else {
      if (!isBackground) {
        CommonToast.getInstance()
            ?.displayToast(message: StringUtils.noInternetContent);
      }
      //throw StringUtils.noInternetContent;
    }
  }

  Future postsMultipart(http.MultipartRequest request,
      {Map<String, String>? headers,
      dynamic body,
      Encoding? encoding,
      bool isProgressBar = true,
      bool isBackground = false}) async {
    headers ??= getJsonHeader();
    if (await AppComponentBase.getInstance()
            ?.getNetworkManager()
            .isConnected() ??
        false) {
      if (isProgressBar) {
        AppComponentBase.getInstance()?.showProgressDialog(true);
      }
      AppComponentBase.getInstance()?.disableWidget(true);
      try {
        request.headers.addAll(headers);
        var result = await request.send();
        var response = await http.Response.fromStream(result);
        //if (successResponse.contains(response.statusCode)) {
        if (isProgressBar) {
          AppComponentBase.getInstance()?.showProgressDialog(false);
        }
        AppComponentBase.getInstance()?.disableWidget(false);
        String bodyBytes = utf8.decode(response.bodyBytes);
        debugPrint('request body : ${request.fields.values}');
        debugPrint('response body : $bodyBytes');
        return bodyBytes;
        /* .catchError((err) => print('error : $err'))
            .whenComplete(() {
              */
      } //);
      /*
        print(response.body);
        if (response.statusCode != 200) return null;
        Map<String, dynamic> map = json.decode(response.body);
        return map;
        //return List<Map<String, dynamic>>.from(json.decode(response.body));
        var responseStatus = json.decode(response.body);
        return responseStatus;*/
      catch (exception) {
        if (isProgressBar) {
          AppComponentBase.getInstance()?.showProgressDialog(false);
        }
        AppComponentBase.getInstance()?.disableWidget(false);
        var e =
            exception is String ? exception : StringUtils.someThingWentWrong;
        if (!isBackground) {
          CommonToast.getInstance()?.displayToast(message: e);
        }
      }
      if (isProgressBar) {
        AppComponentBase.getInstance()?.showProgressDialog(false);
      }
      AppComponentBase.getInstance()?.disableWidget(false);
    } else {
      if (!isBackground) {
        CommonToast.getInstance()
            ?.displayToast(message: StringUtils.noInternetContent);
      }
      throw StringUtils.noInternetContent;
    }
  }

  postsBase64(String url,
      {Map<String, String>? headers,
      dynamic body,
      Encoding? encoding,
      bool isProgressBar = true,
      bool isBackground = false}) async {
    headers ??= getJsonHeader();
    if (await AppComponentBase.getInstance()
            ?.getNetworkManager()
            .isConnected() ??
        false) {
      if (isProgressBar) {
        AppComponentBase.getInstance()?.showProgressDialog(true);
      }
      AppComponentBase.getInstance()?.disableWidget(true);
      try {
        http.Response response = await http.post(Uri.parse(url),
            headers: headers, body: body, encoding: encoding);
        logPrint(requestData: body, response: response);

        //var data = json.decode(response.body);

        return response.body;
      } catch (exception) {
        if (isProgressBar) {
          AppComponentBase.getInstance()?.showProgressDialog(false);
        }
        AppComponentBase.getInstance()?.disableWidget(false);
        var e =
            exception is String ? exception : StringUtils.someThingWentWrong;
        if (!isBackground) {
          CommonToast.getInstance()?.displayToast(message: e);
        }
      }
      if (isProgressBar) {
        AppComponentBase.getInstance()?.showProgressDialog(false);
      }
    } else {
      if (!isBackground) {
        CommonToast.getInstance()
            ?.displayToast(message: StringUtils.noInternetContent);
      }
      throw StringUtils.noInternetContent;
    }
  }

  void logPrint({String? requestData, http.Response? response}) {
    if (response != null) {
      debugPrint(
          '--------------------------------------------------------------');
      debugPrint(
          'request url :${response.request?.method}  ${response.request?.url}');
      debugPrint('request header : ${response.request?.headers}');
      if (requestData != null) {
        debugPrint('request body : ${requestData.toString()}');
      }
      debugPrint(
          '--------------------------------------------------------------');
      //debugPrint('response header : ${response.headers.toString()}');
      debugPrint('response statusCode : ${response.statusCode.toString()}');
      debugPrint('response body : ${response.body.toString()}');
    }
  }
}
