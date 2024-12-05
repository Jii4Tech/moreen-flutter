import 'package:get/get.dart';
import 'package:pendakian_mobile/app/data/api_provider.dart';

class RegisterProvider extends GetConnect {
  Future<Response> auth(Map<String, dynamic> data) {
    var myHeader = {
      'Accept': 'application/json',
    };
    return post('${ApiProvider().baseUrl}/api/register', data,
        headers: myHeader);
  }
}
