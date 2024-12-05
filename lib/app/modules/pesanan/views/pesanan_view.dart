import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../routes/app_pages.dart';
import '../controllers/pesanan_controller.dart';

class PesananView extends GetView<PesananController> {
  const PesananView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
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
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.getData();
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
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
                  const SizedBox(height: 15),
                  Obx(() {
                    if (controller.isLoading.value) {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.7,
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(
                          color: Color(0xFF2E7D32),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.listData.length,
                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                        itemBuilder: (context, index) {
                          var item = controller.listData[index];
                          return TicketView(item: item);
                        },
                      );
                    }
                  }),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TicketView extends StatelessWidget {
  final dynamic item;

  const TicketView({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    DateTime tglMasuk = DateTime.parse(item['tgl_masuk']);
    String formattedTglMasuk = DateFormat('d MMM yyyy').format(tglMasuk);

    DateTime tglKeluar = DateTime.parse(item['tgl_keluar']);
    String formattedTglKeluar = DateFormat('d MMM yyyy').format(tglKeluar);

    double totalHargaValue =
        double.tryParse(item['total_harga'].toString()) ?? 0.0;

    final formatter = NumberFormat.currency(
      locale: 'id_ID', // Indonesian locale
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    String totalHarga = formatter.format(totalHargaValue);

    Color badgeColor;
    String statusText;

    switch (item['status_pembayaran']) {
      case 'pending':
        badgeColor = Colors.yellow.shade700; // Yellow for pending
        statusText = 'pending';
        break;
      case 'success':
        badgeColor = Colors.green.shade700; // Green for success (Success)
        statusText = 'success';
        break;
      case 'failure':
        badgeColor = Colors.red.shade700; // Red for failure (failure)
        statusText = 'failed';
        break;
      default:
        badgeColor = Colors.grey.shade500; // Default color if no status found
        statusText = 'Unknown';
        break;
    }
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.DETAIL_PESANAN, arguments: item);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24))),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        item['gunung']['nama_gunung'].toString().toUpperCase(),
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 6),
                        decoration: BoxDecoration(
                          color: badgeColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          statusText,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        formattedTglMasuk,
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(20)),
                        child: SizedBox(
                          height: 8,
                          width: 8,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                color: Colors.green.shade400,
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            children: <Widget>[
                              SizedBox(
                                height: 24,
                                child: LayoutBuilder(
                                  builder: (context, constraints) {
                                    return Flex(
                                      direction: Axis.horizontal,
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: List.generate(
                                          (constraints.constrainWidth() / 6)
                                              .floor(),
                                          (index) => SizedBox(
                                                height: 1,
                                                width: 3,
                                                child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                      color:
                                                          Colors.grey.shade300),
                                                ),
                                              )),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(20)),
                        child: SizedBox(
                          height: 8,
                          width: 8,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                color: Colors.red.shade400,
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Text(
                        formattedTglKeluar,
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Metode Pembayaran:",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        item['metode_pembayaran'] == 'cash_on_delivery'
                            ? 'Cash on Delivery (COD)'
                            : item['metode_pembayaran'] == 'bank_transfer'
                                ? 'Transfer Bank'
                                : item['metode_pembayaran'] ?? '-',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                    width: 10,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          color: Colors.grey.shade200),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return Flex(
                            direction: Axis.horizontal,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(
                                (constraints.constrainWidth() / 10).floor(),
                                (index) => SizedBox(
                                      height: 1,
                                      width: 5,
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade400),
                                      ),
                                    )),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                    width: 10,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10)),
                          color: Colors.grey.shade200),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24))),
              child: Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(20)),
                    child: const Icon(Icons.wallet, color: Color(0xFF2E7D32)),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  const Text("Total Harga",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey)),
                  Expanded(
                    child: Text('$totalHarga.-',
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
