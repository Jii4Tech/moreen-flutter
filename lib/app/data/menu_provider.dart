import 'package:get/get.dart';
import 'package:pendakian_mobile/app/data/api_provider.dart';
import 'package:sp_util/sp_util.dart';

class MenuProvider extends GetConnect {
  Future<Response> getAll() {
    var myHeader = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SpUtil.getString("token")!}'
    };
    return get('${ApiProvider().baseUrl}/api/menu', headers: myHeader);
  }
}
