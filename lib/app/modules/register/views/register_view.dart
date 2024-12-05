import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                  'MOREEN',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7D32),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Create',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7D32),
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'New Account',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7D32),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  child: TextField(
                    controller: controller.txtName,
                    style: const TextStyle(
                      color:
                          Color(0xFF2E7D32), // Set the desired text color here
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Name',
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
                    controller: controller.txtEmail,
                    style: const TextStyle(
                      color:
                          Color(0xFF2E7D32), // Set the desired text color here
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Email',
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
                    controller: controller.txtPassword,
                    style: const TextStyle(
                      color:
                          Color(0xFF2E7D32), // Set the desired text color here
                      fontWeight: FontWeight.w500,
                    ),
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
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
                const SizedBox(height: 30),
                Obx(() => SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: controller.isLoading.value
                            ? null
                            : () async {
                                await controller.auth();
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
                              'Register',
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Sudah punya Akun?',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF2E7D32),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed(Routes.LOGIN);
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF2E7D32),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
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
