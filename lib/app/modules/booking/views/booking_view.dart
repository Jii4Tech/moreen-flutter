import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../routes/app_pages.dart';
import '../controllers/booking_controller.dart';

class BookingView extends GetView<BookingController> {
  const BookingView({super.key});
  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID', // Indonesian locale
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    String hargaWeekdaysLokal =
        formatter.format(controller.itemBooking['weekdays_lokal']);
    String hargaWeekendLokal =
        formatter.format(controller.itemBooking['weekend_lokal']);
    String hargaWeekdaysAsing =
        formatter.format(controller.itemBooking['weekdays_asing']);
    String hargaWeekendAsing =
        formatter.format(controller.itemBooking['weekend_asing']);

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
              alignment: Alignment.centerLeft,
              child: Text(
                'BOOKING',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E7D32),
                ),
              ),
            ),
            const SizedBox(height: 25),
            Text(
              'Tiket ${controller.itemBooking['nama_gunung'] ?? '-'}',
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF2E7D32),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Pos Perizinan Masuk',
                style: TextStyle(
                  color: Color(0xFF2E7D32),
                ),
              ),
            ),
            const SizedBox(height: 5),
            TextField(
              onChanged: (value) {
                controller.setPosPerizinanMasuk(value);
              },
              style: const TextStyle(
                color: Color(0xFF2E7D32),
                fontWeight: FontWeight.w500,
              ),
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF2E7D32)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF2E7D32)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF2E7D32)),
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Pos Perizinan Keluar',
                style: TextStyle(
                  color: Color(0xFF2E7D32),
                ),
              ),
            ),
            const SizedBox(height: 5),
            TextField(
              onChanged: (value) {
                controller.setPosPerizinanKeluar(value);
              },
              style: const TextStyle(
                color: Color(0xFF2E7D32),
                fontWeight: FontWeight.w500,
              ),
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF2E7D32)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF2E7D32)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF2E7D32)),
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Tanggal Masuk',
                style: TextStyle(
                  color: Color(0xFF2E7D32),
                ),
              ),
            ),
            const SizedBox(height: 5),
            TextField(
              controller: controller.masukDateController,
              style: const TextStyle(
                color: Color(0xFF2E7D32),
                fontWeight: FontWeight.w500,
              ),
              readOnly: true,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.calendar_today,
                  color: Color(0xFF2E7D32),
                ),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF2E7D32)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF2E7D32)),
                ),
              ),
              onTap: () => controller.selectMasukDate(context),
            ),
            const SizedBox(height: 15),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Tanggal Keluar',
                style: TextStyle(
                  color: Color(0xFF2E7D32),
                ),
              ),
            ),
            const SizedBox(height: 5),
            TextField(
              controller: controller.keluarDateController,
              style: const TextStyle(
                color: Color(0xFF2E7D32),
                fontWeight: FontWeight.w500,
              ),
              readOnly: true,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.calendar_today,
                  color: Color(0xFF2E7D32),
                ),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF2E7D32)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF2E7D32)),
                ),
              ),
              onTap: () => controller.selectKeluarDate(context),
            ),
            const SizedBox(height: 15),
            // Harga Tiket
            Obx(() {
              return Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Harga Tiket : ${controller.getFormattedPrice()}.-',
                  style: const TextStyle(
                    color: Color(0xFF2E7D32),
                  ),
                ),
              );
            }),
            const SizedBox(height: 10),
            Obx(() {
              return DropdownButtonFormField<String>(
                value: controller.selectedVisitorType.value,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF2E7D32)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF2E7D32)),
                  ),
                ),
                style: const TextStyle(
                    color: Color(0xFF2E7D32),
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
                items: controller.visitorTypeOptions.map((option) {
                  return DropdownMenuItem<String>(
                    value: option['value'],
                    child: Text(option['label']),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    controller.selectedVisitorType.value = newValue;
                  }
                },
              );
            }),
            const SizedBox(height: 15),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Jumlah Pemesanan',
                style: TextStyle(
                  color: Color(0xFF2E7D32),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: const Color(0xFF2E7D32)),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: IconButton(
                      onPressed: controller.decrementQuantity,
                      icon: const Icon(Icons.remove, color: Color(0xFF2E7D32)),
                      iconSize: 20,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      controller.quantity.value.toString(),
                      style: const TextStyle(
                        fontSize: 18,
                        color: Color(0xFF2E7D32),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: const Color(0xFF2E7D32)),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: IconButton(
                      onPressed: controller.incrementQuantity,
                      icon: const Icon(Icons.add, color: Color(0xFF2E7D32)),
                      iconSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Metode Pembayaran',
                style: TextStyle(
                  color: Color(0xFF2E7D32),
                ),
              ),
            ),
            const SizedBox(height: 5),
            // Add the payment method dropdown
            Obx(() {
              return DropdownButtonFormField<String>(
                value: controller.selectedPaymentMethod.value,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF2E7D32)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF2E7D32)),
                  ),
                ),
                style: const TextStyle(
                    color: Color(0xFF2E7D32),
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
                items: controller.paymentMethods.map((option) {
                  return DropdownMenuItem<String>(
                    value: option['value'],
                    child: Text(option['label']),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    controller.selectedPaymentMethod.value = newValue;
                  }
                },
              );
            }),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showBottomSheet(context); // Calling the function with context
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
                'Checkout',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                width: 40.0,
                height: 5.0,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 204, 204, 204),
                  borderRadius: BorderRadius.circular(100.0),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Pos Perizinan Masuk',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF2E7D32),
                  ),
                ),
                Obx(() {
                  return Text(
                    controller.posPerizinanMasuk
                        .value, // Dynamically displaying the input value
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  );
                }),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Pos Perizinan Keluar',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF2E7D32),
                  ),
                ),
                Obx(() {
                  return Text(
                    controller.posPerizinanKeluar
                        .value, // Dynamically displaying the input value
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  );
                }),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Tgl Pendakian',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF2E7D32),
                  ),
                ),
                Obx(() {
                  // Format tanggal masuk dan keluar
                  String formattedMasukDate = DateFormat('dd/MM/yyyy')
                      .format(controller.masukDate.value);
                  String formattedKeluarDate = DateFormat('dd/MM/yyyy')
                      .format(controller.keluarDate.value);

                  return Text(
                    "$formattedMasukDate - $formattedKeluarDate",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  );
                }),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Jenis Tiket',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF2E7D32),
                  ),
                ),
                Obx(() {
                  return Text(
                    controller.selectedVisitorType.value == 'lokal'
                        ? 'Wisatawan Lokal'
                        : 'Wisatawan Asing',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  );
                }),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Metode Pembayaran',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF2E7D32),
                  ),
                ),
                Obx(() {
                  return Text(
                    controller.selectedPaymentMethod.value == 'bank_transfer'
                        ? 'Transfer Bank'
                        : 'Cash on Delivery (COD)',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  );
                }),
              ],
            ),
            const SizedBox(height: 15),
            const Divider(
              // Divider widget
              color: Colors.grey, // Line color
              thickness: 1, // Line thickness
              indent: 0, // Left indentation
              endIndent: 0, // Right indentation
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Harga',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF2E7D32),
                  ),
                ),
                Obx(() {
                  return Text(
                    "${controller.getTotalPrice()} | ${controller.quantity} Org",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  );
                }),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  controller.bookingData();
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: const Color(0xFF2E7D32),
                ),
                child: const Text(
                  'Confirm',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
