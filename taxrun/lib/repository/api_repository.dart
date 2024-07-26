import 'package:taxrun/model/common_data.dart';
import 'package:taxrun/services/api_services.dart';

class ApiRepositoryIml extends ApiRepository {
  final ApiServices _apiServices = ApiServices();

  @override
  Future<CommonData?> driverLogin({String? mobileNo, String? deviceId}) {
    return _apiServices.driverLogin(mobileNo ?? '', deviceId ?? '');
  }
}

abstract class ApiRepository {
  Future<CommonData?> driverLogin({String? mobileNo, String? deviceId});
}
