import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: IconButton(
              icon: const Icon(
                Icons.person,
                size: 40,
                color: Color(0xFF2E7D32),
              ),
              onPressed: () {
                Get.toNamed(Routes.PROFILE);
              },
            ),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: SmartRefresher(
        controller: controller.refreshController,
        onRefresh: () => controller.onRefresh(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                const Text(
                  'MENU',
                  style: TextStyle(
                    fontSize: 26,
                    color: Color(0xFF2E7D32),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 25),

                // Gunakan Obx untuk memantau perubahan pada `isLoading` dan `listData`
                Obx(() {
                  if (controller.isLoading.value) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF2E7D32),
                        ),
                      ),
                    );
                  }

                  if (controller.listData.isEmpty) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: const Center(
                        child: Text("Data tidak tersedia"),
                      ),
                    );
                  }

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 0.9,
                    ),
                    itemCount: controller.listData.length,
                    itemBuilder: (BuildContext context, int index) {
                      final item = controller.listData[index];
                      return GestureDetector(
                        onTap: () {
                          // Tambahkan navigasi sesuai kebutuhan
                          if (item['title'] == 'PEMESANAN TIKET') {
                            Get.toNamed(Routes.PEMESANAN_TIKET);
                          } else {
                            Get.toNamed(Routes.MENU_PAGE, arguments: item);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color(0xFF2E7D32), width: 1),
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 90,
                                height: 90,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: const Color(0xFF2E7D32),
                                    width: 1,
                                  ),
                                ),
                                child: ClipOval(
                                  child: item['title'] == 'PEMESANAN TIKET'
                                      ? Image.asset(
                                          item[
                                              'gambar'], // Menggunakan Image.asset untuk gambar dari assets
                                          fit: BoxFit.cover,
                                          // Tidak menggunakan loadingBuilder atau errorBuilder untuk assets
                                        )
                                      : Image.network(
                                          item[
                                              'gambar'], // Menggunakan Image.network untuk gambar dari URL
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return const Icon(Icons
                                                .error); // Tampilkan icon error jika gambar gagal dimuat
                                          },
                                          loadingBuilder: (context, child,
                                              loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          },
                                        ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Flexible(
                                child: Text(
                                  (item['title'] ?? '')
                                      .toUpperCase(), // Tambahkan null check
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Color(0xFF2E7D32),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
