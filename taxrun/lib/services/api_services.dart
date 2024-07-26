import 'dart:convert';

import 'package:taxrun/model/common_data.dart';
import 'package:taxrun/services/api_client.dart';

class ApiServices extends ApiClient {
  Future<CommonData?> driverLogin(String email, String password) async {
    Map<String, String> body = {
      'email': email,
      'password': password,
    };
    String jsonString = json.encode(body);
    var response = await posts(ApiClient.driverLogin,
        body: jsonString, isBackground: true);
    if (response != null) {
      var data = CommonData.fromJson(json.decode(response));
      return data;
    }
    return null;
  }
}
