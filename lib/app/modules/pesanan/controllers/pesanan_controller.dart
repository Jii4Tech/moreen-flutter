import 'package:get/get.dart';
import 'package:pendakian_mobile/app/data/tiket_provider.dart';

class PesananController extends GetxController {
  var listData = [].obs;
  var isLoading = true.obs; // Track loading state

  Future<void> getData() async {
    isLoading(true);
    try {
      final response = await TiketProvider().getTiket();
      if (response.statusCode == 200) {
        var responseBody = response.body;
        var data = responseBody['data'];
        listData.assignAll(data);
      }
    } catch (error) {
      print('Error fetching data: $error');
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }
}
