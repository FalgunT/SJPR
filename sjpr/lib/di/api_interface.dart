import 'package:sjpr/repository/api_repository.dart';

class ApiInterface implements ApiInterfaceServices {
  @override
  ApiRepositoryIml getApiRepository() {
    return ApiRepositoryIml();
  }
}

abstract class ApiInterfaceServices {
  ApiRepositoryIml getApiRepository();
}
