
import 'package:get/get.dart';
import 'package:hi_service/api/profession_api_controller.dart';
import 'package:hi_service/models/api_response.dart';
import 'package:hi_service/models/favorite_professions.dart';
import 'package:hi_service/models/profession.dart';


class FavoriteProfGetxController extends GetxController{

  static FavoriteProfGetxController get to =>Get.find();
  final ProfessionApiController _favoriteProfController = ProfessionApiController();

  bool loading = false;
  List<Profession> favorite =<Profession>[];

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
    update();
  }

  Future<ApiResponse> addFavorite({required String id,}) async {
    var response = await ProfessionApiController().addFavoriteProfessions(id: id);
    return response;
  }

/*  Future<ApiResponse> deleteFavorite({required int index}) async{
    ApiResponse apiResponse = await _favoriteProfController.deleteFavoriteProfession(id: favorite[index]);
    if(apiResponse.success){
      favorite.removeAt(index);
    }
    return apiResponse;
  }*/
}