import 'package:get/get.dart';
import 'package:pendakian_mobile/app/data/api_provider.dart';
import 'package:sp_util/sp_util.dart';

class TiketProvider extends GetConnect {
  Future<Response> getAll() {
    var myHeader = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SpUtil.getString("token")!}'
    };
    return get('${ApiProvider().baseUrl}/api/tiket', headers: myHeader);
  }

  Future<Response> bookingData(Map<String, dynamic> data) {
    var myHeader = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SpUtil.getString("token")!}'
    };
    return post('${ApiProvider().baseUrl}/api/tiket', data, headers: myHeader);
  }

  Future<Response> getTiket() {
    var myHeader = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SpUtil.getString("token")!}'
    };
    return get('${ApiProvider().baseUrl}/api/tiket-saya', headers: myHeader);
  }
}
