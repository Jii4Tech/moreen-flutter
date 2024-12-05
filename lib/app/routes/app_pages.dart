import 'package:get/get.dart';

import '../modules/booking/bindings/booking_binding.dart';
import '../modules/booking/views/booking_view.dart';
import '../modules/detail_pesanan/bindings/detail_pesanan_binding.dart';
import '../modules/detail_pesanan/views/detail_pesanan_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/info_tiket/bindings/info_tiket_binding.dart';
import '../modules/info_tiket/views/info_tiket_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/menu_page/bindings/menu_page_binding.dart';
import '../modules/menu_page/views/menu_page_view.dart';
import '../modules/pemesanan_tiket/bindings/pemesanan_tiket_binding.dart';
import '../modules/pemesanan_tiket/views/pemesanan_tiket_view.dart';
import '../modules/pesanan/bindings/pesanan_binding.dart';
import '../modules/pesanan/views/pesanan_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.MENU_PAGE,
      page: () => const MenuPageView(),
      binding: MenuPageBinding(),
    ),
    GetPage(
      name: _Paths.PEMESANAN_TIKET,
      page: () => const PemesananTiketView(),
      binding: PemesananTiketBinding(),
    ),
    GetPage(
      name: _Paths.INFO_TIKET,
      page: () => const InfoTiketView(),
      binding: InfoTiketBinding(),
    ),
    GetPage(
      name: _Paths.BOOKING,
      page: () => const BookingView(),
      binding: BookingBinding(),
    ),
    GetPage(
      name: _Paths.PESANAN,
      page: () => const PesananView(),
      binding: PesananBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_PESANAN,
      page: () => const DetailPesananView(),
      binding: DetailPesananBinding(),
    ),
  ];
}
