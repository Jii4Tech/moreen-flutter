import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../routes/app_pages.dart';
import '../controllers/info_tiket_controller.dart';

class InfoTiketView extends GetView<InfoTiketController> {
  const InfoTiketView({super.key});

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID', // Indonesian locale
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    String hargaWeekdaysLokal =
        formatter.format(controller.itemTiket['weekdays_lokal'] ?? 0);
    String hargaWeekendLokal =
        formatter.format(controller.itemTiket['weekend_lokal'] ?? 0);
    String hargaWeekdaysAsing =
        formatter.format(controller.itemTiket['weekdays_asing'] ?? 0);
    String hargaWeekendAsing =
        formatter.format(controller.itemTiket['weekend_asing'] ?? 0);

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerLeft, // Align the text to the left
              child: Text(
                'PEMESANAN TIKET',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E7D32),
                ),
              ),
            ),
            const SizedBox(height: 25),
            Text(
              '${controller.itemTiket['nama_gunung']}'.toUpperCase(),
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF2E7D32),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Image.network(
              '${controller.itemTiket['gambar']}', // Replace with your image asset path
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                '${controller.itemTiket['deskripsi']}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF2E7D32),
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                '${controller.itemTiket['lokasi']}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF2E7D32),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            Table(
              border: TableBorder.all(color: const Color(0xFF2E7D32), width: 1),
              columnWidths: const {
                0: FractionColumnWidth(0.4),
                1: FractionColumnWidth(0.3),
                2: FractionColumnWidth(0.3),
              },
              children: [
                const TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        'Harga Tiket',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2E7D32),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        'Weekdays',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2E7D32),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        'Weekend',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2E7D32),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        'Wisatawan Lokal',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF2E7D32),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        '$hargaWeekdaysLokal.-',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFF2E7D32),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        '$hargaWeekendLokal.-',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFF2E7D32),
                        ),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        'Wisatawan Asing',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF2E7D32),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '$hargaWeekdaysAsing.-',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFF2E7D32),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        '$hargaWeekendAsing.-',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFF2E7D32),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.toNamed(
                  Routes.BOOKING,
                  arguments: controller.itemTiket,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E7D32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: const Text(
                'PESAN SEKARANG !',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
