import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../routes/app_pages.dart';
import '../controllers/detail_pesanan_controller.dart';

class DetailPesananView extends GetView<DetailPesananController> {
  const DetailPesananView({super.key});
  @override
  Widget build(BuildContext context) {
    String formatCurrency(dynamic amount) {
      // Cek apakah 'amount' adalah String, lalu konversi ke int
      if (amount is String) {
        amount = int.tryParse(amount) ?? 0;
      }

      // Gunakan NumberFormat untuk memformat menjadi IDR
      final formatter = NumberFormat.currency(
        locale: 'id_ID',
        symbol: 'Rp ',
        decimalDigits: 0,
      );
      return formatter.format(amount);
    }

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
      body: Obx(() {
        // Jika data belum ada, tampilkan indikator loading
        if (controller.itemPesanan.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'TIKET SAYA',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Kode tiket
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2E7D32),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      controller.itemPesanan['kode_tiket'] ?? '-',
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Nama gunung
                Text(
                  controller.itemPesanan['gunung']['nama_gunung'],
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                // Detail tiket
                _buildDetailRow('Nama', controller.itemPesanan['user']['name']),
                _buildDetailRow('Pos Perizinan Masuk',
                    controller.itemPesanan['pos_perizinan_masuk'] ?? '-'),
                _buildDetailRow('Pos Perizinan Keluar',
                    controller.itemPesanan['pos_perizinan_keluar'] ?? '-'),
                _buildDetailRow('Tanggal Masuk',
                    controller.itemPesanan['tgl_masuk'] ?? '-'),
                _buildDetailRow('Tanggal Keluar',
                    controller.itemPesanan['tgl_keluar'] ?? '-'),
                _buildDetailRow(
                    'Metode Pembayaran',
                    _getPaymentMethodName(
                        controller.itemPesanan['metode_pembayaran'] ?? '-')),
                _buildDetailRow(
                  'Total Harga',
                  formatCurrency(controller.itemPesanan['total_harga']),
                ),
                _buildDetailRow(
                  'Status Pembayaran',
                  controller.itemPesanan['status_pembayaran'] ?? '-',
                  valueColor:
                      controller.itemPesanan['status_pembayaran'] == 'success'
                          ? Colors.green
                          : Colors.orange,
                ),
                // Menambahkan note untuk COD
                if (controller.itemPesanan['metode_pembayaran'] ==
                    'cash_on_delivery')
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.orange.shade200),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Catatan:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Silakan lakukan pembayaran di pos perizinan dan tunjukan kode tiketnya.',
                          style: TextStyle(color: Colors.orange),
                        ),
                      ],
                    ),
                  ),
                // Tombol Bayar (hanya muncul jika status pending dan metode pembayaran bank_transfer)
                Obx(() {
                  final status = controller.itemPesanan['status_pembayaran']
                      ?.toString()
                      .toLowerCase();
                  final paymentMethod =
                      controller.itemPesanan['metode_pembayaran']?.toString();

                  if (status == 'pending' && paymentMethod == 'bank_transfer') {
                    return Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2E7D32),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: controller.isLoading.value
                              ? null
                              : () async {
                                  try {
                                    final data = {
                                      "kode_tiket": controller
                                              .itemPesanan['kode_tiket']
                                              ?.toString() ??
                                          '',
                                      "nama": controller.itemPesanan['user']
                                                  ['name']
                                              ?.toString() ??
                                          '',
                                      "total_harga": controller
                                              .itemPesanan['total_harga']
                                              ?.toString() ??
                                          '',
                                    };

                                    print('Sending data to server: $data');

                                    final transactionResponse = await controller
                                        .createTransaction(data);

                                    // Store the Midtrans order_id
                                    controller.itemPesanan['order_id'] =
                                        transactionResponse['order_id'];

                                    // Tampilkan dialog pembayaran menggunakan WebView
                                    Get.to(
                                      () => Scaffold(
                                        appBar: AppBar(
                                          leading: IconButton(
                                            icon: const Icon(Icons.close),
                                            onPressed: () => Get.back(),
                                          ),
                                          title: const Text('Pembayaran'),
                                        ),
                                        body: WebViewWidget(
                                          controller: WebViewController()
                                            ..setJavaScriptMode(
                                                JavaScriptMode.unrestricted)
                                            ..loadRequest(Uri.parse(controller
                                                .paymentUrl
                                                .value)) // Gunakan paymentUrl dari controller
                                            ..setNavigationDelegate(
                                              NavigationDelegate(
                                                onNavigationRequest:
                                                    (NavigationRequest
                                                        request) {
                                                  if (request.url.startsWith(
                                                      'tiketmobile://')) {
                                                    Get.back(); // Tutup WebView
                                                    controller
                                                        .refreshTicketData()
                                                        .then((_) {
                                                      // Tampilkan dialog sukses
                                                      Get.dialog(
                                                        AlertDialog(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16),
                                                          ),
                                                          title: const Column(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .check_circle,
                                                                color: Colors
                                                                    .green,
                                                                size: 64,
                                                              ),
                                                              SizedBox(
                                                                  height: 16),
                                                              Text(
                                                                'Pembayaran Berhasil',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                            ],
                                                          ),
                                                          content: const Text(
                                                            'Terima kasih, pembayaran Anda telah berhasil.',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                          actions: [
                                                            Container(
                                                              width: double
                                                                  .infinity,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          16),
                                                              child:
                                                                  ElevatedButton(
                                                                onPressed:
                                                                    () async {
                                                                  Get.back();
                                                                  // Navigate and hide loading
                                                                  await Get.toNamed(
                                                                      Routes
                                                                          .DETAIL_PESANAN);
                                                                },
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  backgroundColor:
                                                                      const Color(
                                                                          0xFF2E7D32),
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          12),
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(8),
                                                                  ),
                                                                ),
                                                                child:
                                                                    const Text(
                                                                  'OK',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        barrierDismissible:
                                                            false,
                                                      );
                                                    });
                                                    return NavigationDecision
                                                        .prevent;
                                                  }
                                                  return NavigationDecision
                                                      .navigate;
                                                },
                                                onWebResourceError:
                                                    (WebResourceError error) {
                                                  print(
                                                      'WebView error: ${error.description}');
                                                },
                                              ),
                                            ),
                                        ),
                                      ),
                                    );
                                  } catch (e) {
                                    print('Error during payment process: $e');
                                    Get.snackbar(
                                      'Error',
                                      'Gagal memproses pembayaran: ${e.toString()}',
                                      backgroundColor: Colors.red,
                                      colorText: Colors.white,
                                      duration: const Duration(seconds: 5),
                                      snackPosition: SnackPosition.BOTTOM,
                                    );
                                  }
                                },
                          child: controller.isLoading.value
                              ? const CircularProgressIndicator(
                                  color: Colors.white)
                              : const Text(
                                  'Bayar Sekarang',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                    );
                  }
                  return const SizedBox();
                }),
              ],
            ),
          ),
        );
      }),
    );
  }

  // Widget helper untuk baris detail
  Widget _buildDetailRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label :',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: valueColor ?? Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  String _getPaymentMethodName(String method) {
    switch (method) {
      case 'bank_transfer':
        return 'Transfer Bank';
      case 'cash_on_delivery':
        return 'Cash on Delivery (COD)';
      default:
        return method;
    }
  }
}
