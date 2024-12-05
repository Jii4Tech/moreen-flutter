import 'package:get/get.dart';
import 'package:pendakian_mobile/app/data/menu_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeController extends GetxController {
  var listData = <Map<String, dynamic>>[].obs;
  var isLoading = true.obs;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  // Fungsi untuk mendapatkan data dari API
  void getAll() async {
    try {
      isLoading.value = true;
      Response response = await MenuProvider().getAll();

      // Print status code
      print('Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        var responseBody = response.body;

        var data = responseBody['data'];

        if (data != null && data is List) {
          listData.assignAll(
            data
                .map((item) => {
                      'id': item['id'],
                      'title': item['title'],
                      'gambar': item['gambar'],
                      'informasi': item['informasi'],
                    })
                .toList(),
          );

          // Tambahkan item PEMESANAN TIKET setelah data dari API
          listData.add({
            'id': 'pemesanan_tiket', // ID unik untuk item ini
            'title': 'PEMESANAN TIKET',
            'gambar': 'assets/images/tiket.jpg', // Gambar untuk PEMESANAN TIKET
          });

          // Print listData setelah assign
          print('List Data yang disimpan: $listData');
        } else {
          print('Data kosong atau tidak berbentuk List');
        }
      } else {
        print('Error: ${response.statusText}');
      }
    } catch (e) {
      print('Exception: $e');
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
