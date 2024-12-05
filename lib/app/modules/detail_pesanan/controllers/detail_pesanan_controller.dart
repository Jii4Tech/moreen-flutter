import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pendakian_mobile/app/data/transaction_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPesananController extends GetxController {
  var itemPesanan = {}.obs;
  final transactionProvider = TransactionProvider();
  final isLoading = false.obs;
  final paymentUrl = ''.obs;
  Timer? _statusCheckTimer;

  @override
  void onInit() {
    super.onInit();
    itemPesanan.value = Get.arguments ?? {};
  }

  Future<Map<String, dynamic>> createTransaction(
      Map<String, dynamic> data) async {
    try {
      isLoading(true);
      final response = await transactionProvider.createTransaction(data);

      print('Transaction response: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final redirectUrl = response.body['redirect_url'];
        if (redirectUrl == null || redirectUrl.isEmpty) {
          throw Exception('URL pembayaran tidak ditemukan');
        }

        paymentUrl.value = redirectUrl;

        return {
          'order_id': response.body['order_id'] ?? '',
          'snap_token': response.body['snap_token'],
        };
      } else {
        throw Exception(response.body['message'] ?? 'Gagal membuat transaksi');
      }
    } catch (e) {
      print('Error in createTransaction: $e');
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  Future<void> processPayment() async {
    try {
      isLoading(true);
      final paymentData = {
        'kode_tiket': itemPesanan['kode_tiket'],
        'nama': itemPesanan['user']['name'],
        'total_harga': itemPesanan['total_harga'],
      };

      final response = await transactionProvider.createTransaction(paymentData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.body['data'];
        paymentUrl.value = responseData['payment_url'] ?? '';

        // Update order_id for status checking
        itemPesanan['order_id'] = responseData['order_id'];

        if (paymentUrl.value.isNotEmpty) {
          await launchUrl(
            Uri.parse(paymentUrl.value),
            mode: LaunchMode.externalApplication,
          );
        }
      } else {
        throw Exception(response.body['message'] ?? 'Gagal membuat transaksi');
      }
    } catch (e) {
      print('Error during payment process: $e');
      Get.snackbar(
        'Error',
        'Gagal memproses pembayaran: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading(false);
    }
  }

  Future<void> refreshTicketData() async {
    try {
      isLoading(true);
      await Future.delayed(const Duration(seconds: 2)); // Add artificial delay

      // Update ticket status directly
      final updatedTicket = Map<String, dynamic>.from(itemPesanan);
      updatedTicket['status_pembayaran'] = 'success';

      print('Updating ticket status to: Berhasil');
      itemPesanan.assignAll(updatedTicket);
    } catch (e) {
      print('Error refreshing ticket data: $e');
      Get.snackbar(
        'Error',
        'Gagal memperbarui data tiket: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading(false);
    }
  }

  @override
  void onClose() {
    _statusCheckTimer?.cancel();
    super.onClose();
  }
}
