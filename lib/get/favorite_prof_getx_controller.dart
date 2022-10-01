
import 'package:get/get.dart';
import 'package:hi_service/api/profession_api_controller.dart';
import 'package:hi_service/models/favorite_professions.dart';
import 'package:hi_service/models/profession.dart';


class FavoriteProfController extends GetxController{

  static FavoriteProfController get to =>Get.find();
  final ProfessionApiController _favoriteProfController = ProfessionApiController();

  bool loading = false;
  List<FavoriteProfessios> favorite =<FavoriteProfessios>[];

  @override
  void onInit() {
    read();
    // TODO: implement onInit
    super.onInit();
  }

  void read() async {
    loading = true;
    favorite = await _favoriteProfController.getFavoriteProfession();
    loading = false;
  }
}