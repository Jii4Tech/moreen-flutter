import 'package:get/get.dart';

class InfoTiketController extends GetxController {
  var itemTiket = {}.obs;

  @override
  void onInit() {
    super.onInit();
    // Ambil data dari Get.arguments
    itemTiket.value = Get.arguments ?? {};
  }
}
