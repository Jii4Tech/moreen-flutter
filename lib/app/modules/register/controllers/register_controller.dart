import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/register_provider.dart';
import '../../../routes/app_pages.dart';

class RegisterController extends GetxController {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  var isLoading = false.obs;

  // Email validation regex pattern
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  Future<void> auth() async {
    String name = txtName.text.trim();
    String email = txtEmail.text.trim();
    String password = txtPassword.text;

    // Validate empty fields
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      Get.snackbar(
        "Error",
        "Form tidak boleh kosong",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 1),
      );
      return;
    }

    // Validate email format
    if (!emailRegex.hasMatch(email)) {
      Get.snackbar(
        "Error",
        "Format email tidak valid",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 1),
      );
      return;
    }

    // Password validation
    if (password.length < 8) {
      Get.snackbar(
        "Error",
        "Password harus minimal 8 karakter",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 1),
      );
      return;
    }

    try {
      isLoading.value = true;

      var data = {
        "name": name,
        "email": email,
        "password": password,
      };

      var response = await RegisterProvider().auth(data);

      switch (response.statusCode) {
        case 200:
          Get.snackbar(
            'Success',
            'Registrasi berhasil',
            backgroundColor: Colors.green,
            colorText: Colors.white,
            duration: const Duration(seconds: 1),
          );
          _clearForm();
          Get.offAllNamed(Routes.LOGIN);
          break;

        case 400:
          String errorMessage = response.body['message'] ??
              "Registrasi gagal. Silahkan coba lagi.";
          if (errorMessage.toLowerCase().contains('email') &&
              errorMessage.toLowerCase().contains('terdaftar')) {
            Get.snackbar(
              "Error",
              "Email sudah terdaftar. Silakan gunakan email lain.",
              backgroundColor: Colors.red,
              colorText: Colors.white,
              duration: const Duration(seconds: 1),
            );
          } else {
            Get.snackbar(
              "Error",
              errorMessage,
              backgroundColor: Colors.red,
              colorText: Colors.white,
              duration: const Duration(seconds: 1),
            );
          }
          break;

        case 401:
          Get.snackbar(
            "Error",
            response.body['message'] ?? "Unauthorized access",
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: const Duration(seconds: 1),
          );
          break;

        default:
          Get.snackbar(
            "Error",
            "Terjadi kesalahan pada server",
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: const Duration(seconds: 1),
          );
      }
    } catch (e) {
      print('Error during registration: $e');
      Get.snackbar(
        "Error",
        "Terjadi kesalahan saat melakukan registrasi",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 1),
      );
    } finally {
      isLoading.value = false;
    }
  }

  void _clearForm() {
    txtName.clear();
    txtEmail.clear();
    txtPassword.clear();
  }
}
