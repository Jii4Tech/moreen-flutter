import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sp_util/sp_util.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SpUtil.getInstance();
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute:
          (SpUtil.getBool('isLogin')! ? Routes.HOME : Routes.SPLASH_SCREEN),
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    ),
  );
}
