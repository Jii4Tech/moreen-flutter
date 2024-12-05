import 'package:get/get.dart';
import 'package:pendakian_mobile/app/data/tiket_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PemesananTiketController extends GetxController {
  var listData = <Map<String, dynamic>>[].obs;
  var isLoading = true.obs;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void getAll() async {
    try {
      isLoading.value = true;
      Response response = await TiketProvider().getAll();

      if (response.statusCode == 200) {
        var responseBody = response.body;
        var data = responseBody['data'];

        if (data != null && data is List) {
          listData.assignAll(
            data.map((item) {
              var gunung = item['gunung'] ?? {};
              return {
                'id': item['id'],
                'id_gunung': item['id_gunung'],
                'nama_gunung': gunung['nama_gunung'] ?? '-',
                'gambar': gunung['gambar'] ?? '',
                'lokasi': gunung['lokasi'] ?? '',
                'tinggi_gunung': gunung['tinggi_gunung'] ?? '',
                'deskripsi': gunung['deskripsi'] ?? '',
                'weekdays_lokal': item['weekdays_lokal'],
                'weekend_lokal': item['weekend_lokal'],
                'weekdays_asing': item['weekdays_asing'],
                'weekend_asing': item['weekend_asing'],
              };
            }).toList(),
          );
        }
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    getAll();
    super.onInit();
  }

  void onRefresh() async {
    getAll();
    // if failed,use refreshFailed()
    refreshController.refreshCompleted();
  }
}
