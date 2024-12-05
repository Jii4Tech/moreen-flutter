import 'package:get/get.dart';

import '../controllers/pemesanan_tiket_controller.dart';

class PemesananTiketBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PemesananTiketController>(
      () => PemesananTiketController(),
    );
  }
}
