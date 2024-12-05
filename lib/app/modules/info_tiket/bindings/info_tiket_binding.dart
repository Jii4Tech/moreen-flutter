import 'package:get/get.dart';

import '../controllers/info_tiket_controller.dart';

class InfoTiketBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InfoTiketController>(
      () => InfoTiketController(),
    );
  }
}
