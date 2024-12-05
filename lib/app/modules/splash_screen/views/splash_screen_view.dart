import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 5), () {
      Get.toNamed('/login');
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                      color: Color(0xFF2E7D32), // Dark green color
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 100.0),
              child: Text(
                'www.mfnms.com',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF2E7D32), // Dark green color
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
