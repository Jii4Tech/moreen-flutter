import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sp_util/sp_util.dart';

import '../../../routes/app_pages.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
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
                Icons.logout,
                size: 30,
                color: Color(0xFF2E7D32),
              ),
              onPressed: () {
                SpUtil.clear();
                Get.offAllNamed(Routes.LOGIN);
              },
            ),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/mountain.png',
                  width: 200,
                ),
                const Text(
                  'PROFILE',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7D32),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  child: TextField(
                    controller: controller.nameController,
                    style: const TextStyle(
                      color:
                          Color(0xFF2E7D32), // Set the desired text color here
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      hintText: 'MOREEN',
                      hintStyle: const TextStyle(
                          color: Color.fromARGB(255, 73, 138, 75),
                          fontWeight: FontWeight.w400),
                      filled: true,
                      fillColor: const Color(0xFFA5D6A7),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  child: TextField(
                    controller: controller.emailController,
                    style: const TextStyle(
                      color:
                          Color(0xFF2E7D32), // Set the desired text color here
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      hintText: 'mfnms@gmail.com',
                      hintStyle: const TextStyle(
                          color: Color.fromARGB(255, 73, 138, 75),
                          fontWeight: FontWeight.w400),
                      filled: true,
                      fillColor: const Color(0xFFA5D6A7),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  child: TextField(
                    controller: controller.no_telpController,
                    style: const TextStyle(
                      color:
                          Color(0xFF2E7D32), // Set the desired text color here
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      hintText: '081212121212',
                      hintStyle: const TextStyle(
                          color: Color.fromARGB(255, 73, 138, 75),
                          fontWeight: FontWeight.w400),
                      filled: true,
                      fillColor: const Color(0xFFA5D6A7),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                    ),
                    textAlign: TextAlign.center, // Center-align the hint text
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  child: TextField(
                    controller: controller.alamatController,
                    style: const TextStyle(
                      color:
                          Color(0xFF2E7D32), // Set the desired text color here
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Yogyakarta',
                      hintStyle: const TextStyle(
                          color: Color.fromARGB(255, 73, 138, 75),
                          fontWeight: FontWeight.w400),
                      filled: true,
                      fillColor: const Color(0xFFA5D6A7),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                    ),
                    textAlign: TextAlign.center, // Center-align the hint text
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  child: TextField(
                    controller: controller.hobiController,
                    style: const TextStyle(
                      color:
                          Color(0xFF2E7D32), // Set the desired text color here
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Mendaki Gunung',
                      hintStyle: const TextStyle(
                          color: Color.fromARGB(255, 73, 138, 75),
                          fontWeight: FontWeight.w400),
                      filled: true,
                      fillColor: const Color(0xFFA5D6A7),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                    ),
                    textAlign: TextAlign.center, // Center-align the hint text
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(() => SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: controller.isLoading.value
                            ? null
                            : () async {
                                await controller.updateProfile();
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: controller.isLoading.value
                              ? Colors.grey
                              : const Color(0xFF2E7D32),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (controller.isLoading.value)
                              const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.0,
                                ),
                              ),
                            if (controller.isLoading.value)
                              const SizedBox(width: 10),
                            const Text(
                              'Update Profile',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
                const SizedBox(height: 50),
                const Text(
                  'www.mfnms.com',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF2E7D32),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
