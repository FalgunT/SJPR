import 'dart:convert';

import 'package:taxrun/common/common_toast.dart';
import 'package:taxrun/common/string_utils.dart';
import 'package:taxrun/di/app_component_base.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  static String siteUrl =
      'http://ec2-3-7-188-163.ap-south-1.compute.amazonaws.com';
  static String baseUrl = '$siteUrl:8088';
  static String freshDeskUrl = '';
  static String userManualUrl = '';
  static String version = "";
  static String resultflagSuccess = "Success";
  final String jsonHeaderName = 'Content-Type';
  final String headerAuthorization = 'Authorization';

  final String jsonHeaderValue = 'application/json; charset=UTF-8';
  final String urlEncodedHeaderValue = 'application/x-www-form-urlencoded';
  final String formHeaderValue =
      'multipart/form-data; boundary=<calculated when request is sent>';
  var successResponse = [200, 201, 400, 401, 422];
  static String otpTypeSMS = "sms";
  static String otpTypeEmail = "email";

  //static String otpTypeUpdateMob = "updatemobile";
  static String otpTypeAadhar = "aadharcard";
  static String trainingTypeGI = "gi";
  static String trainingTypeLI = "li";

  static String token = "$baseUrl/token";
  static String bearerToken = "";
  static String getUrls = "$baseUrl/api/mobileApi/GetUrl";
  static String requestACallBack = "$baseUrl/api/mobileApi/RequestcallBack";
  static String registerDevice = "$baseUrl/api/mobileApi/RegisterDevice";
  static String emailCheck = "$baseUrl/api/mobileApi/EmailCheck";
  static String updateMobile = "$baseUrl/api/mobileApi/Updatemobile";
  static String sendOTP = "$baseUrl/api/mobileApi/SendOTP";
  static String getStatus = "$baseUrl/api/mobileApi/GetStatus";
  static String getAadharData = "$baseUrl/api/mobileApi/GetAadhardata";
  static String getPanData = "$baseUrl/api/mobileApi/GetPandata";
  static String getGstData = "$baseUrl/api/mobileApi/GetGSTdata";
  static String getBankData = "$baseUrl/api/mobileApi/GetBankdata";
  static String registerPosp = "$baseUrl/api/APIPospMaster/PUTPospData";
  static String trainingDayURL = "$baseUrl/Mails/";
  static String getDashboard = "$baseUrl/api/mobileApi/GetDashboard";
  static String getProfile = "$baseUrl/api/mobileApi/GetProfile";
  static String updateProfilePhoto = "$baseUrl/api/mobileApi/UpdateProfilePic";
  static String completeTrainingDay =
      "$baseUrl/api/mobileApi/TrainingDayComplete";
  static String getQuestionAnswerList =
      "$baseUrl/api/mobileApi/GetQuestionList";
  static String submitAnswers = "$baseUrl/api/mobileApi/SubmitAnswer";
  static String downloadCerti = "$baseUrl/api/mobileApi/GetCertificate";
  static String reExam = "$baseUrl/api/mobileApi/ReExam";
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
        if (successResponse.contains(response.statusCode)) {
          if (isProgressBar) {
            AppComponentBase.getInstance()?.showProgressDialog(false);
          }
          AppComponentBase.getInstance()?.disableWidget(false);
          String bodyBytes = utf8.decode(response.bodyBytes);
          logPrint(requestData: bodyBytes, response: response);
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
        http.Response response = await http.post(Uri.parse(url),
            headers: headers, body: body, encoding: encoding);
        if (successResponse.contains(response.statusCode)) {
          //logPrint(requestData: body, response: response);

          if (isProgressBar) {
            AppComponentBase.getInstance()?.showProgressDialog(false);
          }
          AppComponentBase.getInstance()?.disableWidget(false);

          String bodyBytes = utf8.decode(response.bodyBytes);
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
        if (successResponse.contains(response.statusCode)) {
          if (isProgressBar) {
            AppComponentBase.getInstance()?.showProgressDialog(false);
          }
          AppComponentBase.getInstance()?.disableWidget(false);
          String bodyBytes = utf8.decode(response.bodyBytes);
          debugPrint('request body : ${request.fields.values}');
          debugPrint('response body : $bodyBytes');
          return bodyBytes;
        }
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

  /*postsBytes(String url,
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
        String jsonString = json.encode(body); // encode map to jsonString
        var paramName = 'param'; // give the post param a nameString
        var formBody = '$paramName=${Uri.encodeQueryComponent(jsonString)}';
        HttpClient httpClient = HttpClient();
        List<int> bodyBytes = utf8.encode(formBody); // utf8 encode
        HttpClientRequest request =
        await httpClient.post("http://ec2-3-7-188-163.ap-south-1.compute.amazonaws.com/", 8081, "token");
        // it's polite to send the body length to the server
        request.headers.set('Content-Length', bodyBytes.length.toString());
        // todo add other headers here
        request.add(bodyBytes);
        return await request.close();
      } catch (exception) {
        if (isProgressBar) {
          AppComponentBase.getInstance()?.showProgressDialog(false);
        }
        AppComponentBase.getInstance()?.disableWidget(false);
        var e = exception is String
            ? exception
            : StringUtils.someThingWentWrong;
        if (!isBackground) {
          CommonToast.getInstance()?.displayToast(message: e);
        }
      }

    } else {
      if (!isBackground) {
        CommonToast.getInstance()
            ?.displayToast(message: StringUtils.noInternetConnection);
      }
      throw StringUtils.noInternetConnection;
    }
  }*/

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
      debugPrint('response header : ${response.headers.toString()}');
      debugPrint('response statusCode : ${response.statusCode.toString()}');
      debugPrint('response body : ${response.bodyBytes.toString()}');
    }
  }
}
