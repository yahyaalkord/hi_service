
import 'package:get/get.dart';
import 'package:hi_service/api/categorise_api_controller.dart';
import 'package:hi_service/api/home_api_controller.dart';

import '../models/categorise.dart';
import '../models/home.dart';

class HomeGetController extends GetxController {
  Home? home;
  bool loading = false;

  static HomeGetController get to => Get.find<HomeGetController>();

  @override
  void onInit() {
    read();
    super.onInit();
  } // List<Product> products = <Product>[];


  void read() async {
    loading = true;
    home = await HomeApiController().getHomeData();
    loading = false;
    update();
  }

}
