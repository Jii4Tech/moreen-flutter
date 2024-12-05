import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pendakian_mobile/app/data/profile_provider.dart';
import 'package:sp_util/sp_util.dart';

class ProfileController extends GetxController {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController no_telpController;
  late TextEditingController alamatController;
  late TextEditingController hobiController;

  final ProfileProvider profileProvider = ProfileProvider();

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    initControllers();
    fetchProfileData();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    no_telpController.dispose();
    alamatController.dispose();
    hobiController.dispose();
    super.onClose();
  }

  void initControllers() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    no_telpController = TextEditingController();
    alamatController = TextEditingController();
    hobiController = TextEditingController();
  }

  Future<void> fetchProfileData() async {
    try {
      isLoading.value = true;
      final response = await profileProvider.getProfile();
      if (response.statusCode == 200) {
        var data = response.body['data']['user'];

        nameController.text = data['name'] ?? '';
        emailController.text = data['email'] ?? '';
        no_telpController.text = data['no_telp'] ?? '';
        alamatController.text = data['alamat'] ?? '';
        hobiController.text = data['hobi'] ?? '';

        // Update SharedPreferences if needed
        await SpUtil.putString("name", data['name'] ?? '');
        await SpUtil.putString("email", data['email'] ?? '');
        await SpUtil.putString("no_telp", data['no_telp'] ?? '');
        await SpUtil.putString("alamat", data['alamat'] ?? '');
        await SpUtil.putString("hobi", data['hobi'] ?? '');
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to load profile",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateProfile() async {
    final data = {
      'name': nameController.text,
      'email': emailController.text,
      'no_telp': no_telpController.text,
      'alamat': alamatController.text,
      'hobi': hobiController.text,
    };

    isLoading.value = true;
    try {
      final response = await profileProvider.updateData(data);
      if (response.statusCode == 200) {
        Get.snackbar(
          "Success",
          "Profile updated successfully",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        await fetchProfileData(); // Refresh profile data
      } else {
        Get.snackbar(
          "Error",
          response.body['message'] ?? "Update failed",
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to update profile",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
