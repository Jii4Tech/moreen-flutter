import 'package:get/get.dart';
import 'package:pendakian_mobile/app/data/api_provider.dart';
import 'package:sp_util/sp_util.dart';

class ProfileProvider extends GetConnect {
  Future<Response> getProfile() {
    var myHeader = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SpUtil.getString("token")!}'
    };
    return get('${ApiProvider().baseUrl}/api/profile', headers: myHeader);
  }

  Future<Response> updateData(Map<String, dynamic> data) {
    var myHeader = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SpUtil.getString("token")!}'
    };
    return patch('${ApiProvider().baseUrl}/api/profile', data,
        headers: myHeader);
  }
}
