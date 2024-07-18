import 'package:taxrun/model/common_data.dart';
import 'package:taxrun/services/api_services.dart';

class ApiRepositoryIml extends ApiRepository {
  final ApiServices _apiServices = ApiServices();

  @override
  Future<CommonData?> registerDevice({String? mobileNo, String? deviceId}) {
    return _apiServices.registerDevice(mobileNo ?? '', deviceId ?? '');
  }
}

abstract class ApiRepository {
  Future<CommonData?> registerDevice({String? mobileNo, String? deviceId});
}
