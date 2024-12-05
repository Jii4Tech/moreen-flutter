import 'package:get/get.dart';

class ApiProvider extends GetConnect {
  static const String _baseUrl = 'http://192.168.18.186:8080';

  @override
  void onInit() {
    httpClient.baseUrl = _baseUrl;
    super.onInit();
  }

  @override
  String get baseUrl => _baseUrl;
}
