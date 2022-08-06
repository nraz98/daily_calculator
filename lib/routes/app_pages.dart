import 'package:get/get.dart';

import '../bindings/earnings_binding.dart';
import '../screen/homscreen/home_screen.dart';
import 'app_routes.dart';

class AppPages {
  static const initialPage = AppRoutes.homescreen;

  static final pageList = [
    GetPage(
      name: AppRoutes.homescreen,
      binding: AppBindings(),
      page: () =>  HomeScreen(),
    ),
  
  ];
}
