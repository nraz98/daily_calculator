import 'package:get/get.dart';
import 'package:income_calculator/controller/earnings_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<EarningsController>(EarningsController());
    // Get.lazyPut(() => EarningsController(), fenix: true);
  }
}
