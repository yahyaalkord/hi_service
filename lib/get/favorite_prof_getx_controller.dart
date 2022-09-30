
import 'package:get/get.dart';
import 'package:hi_service/api/profession_api_controller.dart';
import 'package:hi_service/models/profession.dart';


class FavoriteProfController extends GetxController{

  static FavoriteProfController get to =>Get.find();
  final ProfessionApiController _favoriteProfController = ProfessionApiController();

  RxBool loading = false.obs;
  RxList<Profession> favorite =<Profession>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void read() async {
    loading.value = true;
    favorite.value = await _favoriteProfController.getFavoriteProfession();
    loading.value = false;
  }
}