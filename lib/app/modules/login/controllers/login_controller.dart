// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sp_util/sp_util.dart';

import '../../../data/login_provider.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  var isLoading = false.obs;

  Future<void> auth() async {
    String email = txtEmail.text.trim();
    String password = txtPassword.text;

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        "Error",
        "Email dan password tidak boleh kosong",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 1),
      );
      return;
    }

    try {
      isLoading.value = true;
      var data = {
        "email": email,
        "password": password,
      };

      var value = await LoginProvider().auth(data);

      if (value.statusCode == 200) {
        var responseBody = value.body;
        var data = responseBody['data'];
        var userData = data['user'];

        // Save basic user data
        SpUtil.putString('name', userData['name'] ?? '');
        SpUtil.putString('email', userData['email'] ?? '');
        SpUtil.putString('token', data['token'] ?? '');
        SpUtil.putBool('isLogin', true);

        // Save optional user data with null checks
        SpUtil.putString('no_telp', userData['no_telp'] ?? '');
        SpUtil.putString('alamat', userData['alamat'] ?? '');
        SpUtil.putString('hobi', userData['hobi'] ?? '');

        // Check if profile is incomplete
        bool isProfileIncomplete = userData['no_telp']?.isEmpty ??
            true || userData['alamat']?.isEmpty ??
            true || userData['hobi']?.isEmpty ??
            true;

        if (isProfileIncomplete) {
          Get.offAllNamed(Routes.HOME);
          Get.snackbar(
            "Peringatan",
            "Silakan lengkapi profil Anda (No. Telp, Alamat, dan Hobi)",
            backgroundColor: Colors.orange,
            colorText: Colors.white,
            duration: const Duration(seconds: 3),
          );
        } else {
          Get.offAllNamed(Routes.HOME);
          Get.snackbar(
            "Success",
            "Login berhasil",
            backgroundColor: Colors.green,
            colorText: Colors.white,
            duration: const Duration(seconds: 1),
          );
        }
      } else if (value.statusCode == 401) {
        Get.snackbar(
          "Error",
          value.body['message'] ?? "Email atau password salah",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 1),
        );
      } else if (value.statusCode == 400) {
        Get.snackbar(
          "Error",
          value.body['message'] ?? "Login gagal. Silakan coba lagi.",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 1),
        );
      } else {
        Get.snackbar(
          "Error",
          "Terjadi kesalahan pada server",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 1),
        );
      }
    } catch (e) {
      print('Error during login: $e');
      Get.snackbar(
        "Error",
        "Terjadi kesalahan saat login",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 1),
      );
    } finally {
      isLoading.value = false;
    }
  }
}
