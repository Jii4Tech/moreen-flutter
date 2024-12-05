import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:pendakian_mobile/app/data/tiket_provider.dart';

import '../../../routes/app_pages.dart';

class BookingController extends GetxController {
  var itemBooking = Get.arguments;

  // Pilihan tipe pengunjung
  final List<Map<String, dynamic>> visitorTypeOptions = [
    {'label': 'Wisatawan Lokal', 'value': 'lokal'},
    {'label': 'Wisatawan Asing', 'value': 'asing'},
  ];

  // Selected visitor type
  var selectedVisitorType = 'lokal'.obs;

  var posPerizinanMasuk = '-'.obs;
  var posPerizinanKeluar = '-'.obs;

  final masukDate = DateTime.now().obs;
  final keluarDate = DateTime.now().obs;

  final masukDateController = TextEditingController();
  final keluarDateController = TextEditingController();

  // Quantity counter
  final quantity = 1.obs;

  // Add near the top with other properties
  final List<Map<String, dynamic>> paymentMethods = [
    {'label': 'Transfer Bank', 'value': 'bank_transfer'},
    {'label': 'Cash on Delivery (COD)', 'value': 'cash_on_delivery'},
  ];

  // Selected payment method
  var selectedPaymentMethod = 'bank_transfer'.obs;

  @override
  void onInit() {
    super.onInit();
    masukDateController.text = DateFormat('dd/MM/yyyy').format(masukDate.value);
    keluarDateController.text =
        DateFormat('dd/MM/yyyy').format(keluarDate.value);
    updateTicketLabel();
  }

  // Method to update "Pos Perizinan Masuk" (could be set via a TextField input)
  void setPosPerizinanMasuk(String pos) {
    posPerizinanMasuk.value = pos;
  }

  // Method to update "Pos Perizinan Keluar" (could be set via a TextField input)
  void setPosPerizinanKeluar(String pos) {
    posPerizinanKeluar.value = pos;
  }

  // Method untuk mendapatkan jenis tiket (weekdays/weekend)
  String getSelectedTicketType() {
    bool isWeekend = masukDate.value.weekday == DateTime.saturday ||
        masukDate.value.weekday == DateTime.sunday;
    return isWeekend
        ? 'weekend_${selectedVisitorType.value}'
        : 'weekdays_${selectedVisitorType.value}';
  }

  // Method untuk mendapatkan harga berdasarkan pilihan tiket
  int getSelectedTicketPrice() {
    final harga = itemBooking[getSelectedTicketType()] ?? 0;
    return harga;
  }

  String getFormattedPrice() {
    int price = getSelectedTicketPrice();
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ', // Prefix for IDR
      decimalDigits: 0, // No decimal places
    ).format(price);
  }

  // Method untuk menghitung total harga
  String getTotalPrice() {
    int totalPrice = getSelectedTicketPrice() * quantity.value;
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    ).format(totalPrice);
  }

  // Date picker untuk "Tanggal Masuk"
  Future<void> selectMasukDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: masukDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      masukDate.value = picked;
      masukDateController.text = DateFormat('dd/MM/yyyy').format(picked);
      updateTicketLabel(); // Perbarui label tiket otomatis
    }
  }

  // Date picker untuk "Tanggal Keluar"
  Future<void> selectKeluarDate(BuildContext context) async {
    DateTime? minKeluarDate = masukDate.value.add(const Duration(days: 1));

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: keluarDate.value.isAfter(minKeluarDate)
          ? keluarDate.value
          : minKeluarDate,
      firstDate: minKeluarDate,
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      keluarDate.value = picked;
      keluarDateController.text = DateFormat('dd/MM/yyyy').format(picked);
    }
  }

  void updateTicketLabel() {
    selectedVisitorType
        .refresh(); // Refresh otomatis berdasarkan tipe yang dipilih
    masukDate.refresh(); // Tambahkan ini agar Obx mendeteksi perubahan
  }

  // Fungsi untuk mengirim data booking
  Future<void> bookingData() async {
    Map<String, dynamic> data = {
      "id_gunung": itemBooking['id_gunung'],
      "pos_perizinan_masuk": posPerizinanMasuk.value,
      "pos_perizinan_keluar": posPerizinanKeluar.value,
      "tgl_masuk": DateFormat('yyyy-MM-dd').format(masukDate.value),
      "tgl_keluar": DateFormat('yyyy-MM-dd').format(keluarDate.value),
      "metode_pembayaran": selectedPaymentMethod.value,
      "total_harga": getSelectedTicketPrice() * quantity.value,
    };

    final response = await TiketProvider().bookingData(data);
    if (response.isOk) {
      // Reset form fields
      posPerizinanMasuk.value = '-';
      posPerizinanKeluar.value = '-';
      masukDate.value = DateTime.now();
      keluarDate.value = DateTime.now();
      masukDateController.text =
          DateFormat('dd/MM/yyyy').format(masukDate.value);
      keluarDateController.text =
          DateFormat('dd/MM/yyyy').format(keluarDate.value);
      selectedVisitorType.value = 'lokal';
      quantity.value = 1;
      selectedPaymentMethod.value = 'bank_transfer';

      Get.snackbar(
        "Sukses",
        "Tiket berhasil dipesan",
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
      Get.toNamed(Routes.PESANAN);
    } else {
      Get.snackbar("Gagal", "Gagal memesan tiket",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3));
    }
  }

  // Increment dan decrement quantity
  void incrementQuantity() {
    quantity.value++;
  }

  void decrementQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }
}
