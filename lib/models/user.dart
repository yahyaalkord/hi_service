class User {
 late int id;
 late String name;
 late String email;
 late String mobile;
 // late String emailVerifiedAt;
 late String token;
  String? imageUrl;
 // late List<FavoriteProfessions> favoriteProfessions;
 late String password;



  User();

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    // emailVerifiedAt = json['email_verified_at'];
    token = json['token'];
    imageUrl = json['image_url'];
/*    if (json['favorite_professions'] != null) {
      favoriteProfessions = <FavoriteProfessions>[];
      json['favorite_professions'].forEach((v) {
        favoriteProfessions.add(new FavoriteProfessions.fromJson(v));
      });
    }*/
  }


}

/*class FavoriteProfessions {
 late int id;
 late int professionId;
 late int userId;

  FavoriteProfessions();

  FavoriteProfessions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    professionId = json['profession_id'];
    userId = json['user_id'];
  }


}*/
