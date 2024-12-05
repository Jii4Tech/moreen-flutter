import 'package:get/get.dart';
import 'package:pendakian_mobile/app/data/api_provider.dart';
import 'package:sp_util/sp_util.dart';

class TransactionProvider extends GetConnect {
  Future<Response> createTransaction(Map<String, dynamic> data) {
    var token = SpUtil.getString('token', defValue: '');
    var myHeader = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final processedData = {
      'kode_tiket': data['kode_tiket'],
      'nama': data['nama'],
      'total_harga': data['total_harga'],
    };

    print('Headers being sent: $myHeader');
    print('Data being sent to Midtrans: $processedData');

    return post(
      '${ApiProvider().baseUrl}/api/midtrans/transaction',
      processedData,
      headers: myHeader,
    ).timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        print('Connection timeout occurred');
        throw Exception('Connection timeout');
      },
    );
  }

  Future<Response> checkPaymentStatus(String orderId) {
    var token = SpUtil.getString('token', defValue: '');
    var myHeader = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    String url = '${ApiProvider().baseUrl}/api/tiket-saya';
    print("Fetching User Pemesanan URL: $url"); // Debug print

    return get(url, headers: myHeader);
  }
}
