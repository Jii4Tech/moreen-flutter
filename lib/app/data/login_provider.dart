import 'package:get/get.dart';
import 'package:pendakian_mobile/app/data/api_provider.dart';

class LoginProvider extends GetConnect {
  Future<Response> auth(Map<String, dynamic> data) {
    var myHeader = {
      'Accept': 'application/json',
    };
    return post('${ApiProvider().baseUrl}/api/login', data, headers: myHeader);
  }
}
