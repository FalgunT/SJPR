import 'dart:convert';

import 'package:taxrun/model/common_data.dart';
import 'package:taxrun/services/api_client.dart';

class ApiServices extends ApiClient {
  Future<CommonData?> registerDevice(String mobileNo, String deviceId) async {
    Map<String, String> body = {
      'mobile_no': mobileNo,
      'deviceid': deviceId,
    };
    String jsonString = json.encode(body);
    var response = await posts(ApiClient.registerDevice,
        body: jsonString, isBackground: true);
    if (response != null) {
      var data = CommonData.fromJson(json.decode(response));
      return data;
    }
    return null;
  }
}
