import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../routes/app_pages.dart';
import '../controllers/pemesanan_tiket_controller.dart';

class PemesananTiketView extends GetView<PemesananTiketController> {
  const PemesananTiketView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Color(0xFF2E7D32),
            size: 30,
          ),
          onPressed: () => Get.back(),
        ),
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              const Text(
                'PEMESANAN TIKET',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E7D32),
                ),
              ),
              const SizedBox(height: 20),
              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.listData.isEmpty) {
                  return const Center(child: Text("Data tidak tersedia"));
                }

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 2,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: controller.listData.length,
                  itemBuilder: (context, index) {
                    final item = controller.listData[index];
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(
                          Routes.INFO_TIKET,
                          arguments: item,
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: const Color(0xFF2E7D32)),
                              ),
                              child: ClipOval(
                                child: Image.network(
                                  item['gambar'],
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(Icons.error);
                                  },
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Flexible(
                              child: Text(
                                item['nama_gunung'].toString().toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF2E7D32),
                                ),
                                textAlign: TextAlign.center,
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
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Pemesanan tiket pendakian gunung online berisi informasi pendakian seperti nama gunung, jalur, tanggal, dan biaya. Pengguna dapat memilih tanggal, memasukkan data pendaki, dan menambahkan fasilitas tambahan. Setelah itu, muncul ringkasan pemesanan, lalu pengguna memilih metode pembayaran. Konfirmasi pemesanan ditampilkan setelah pembayaran berhasil.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF2E7D32),
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Get.toNamed(Routes.PESANAN);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E7D32),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons
                          .confirmation_number, // Ganti dengan ikon yang Anda inginkan
                      color: Colors.white,
                      size: 20,
                    ),
                    SizedBox(width: 10), // Jarak antara ikon dan teks
                    Text(
                      'TIKET SAYA',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
