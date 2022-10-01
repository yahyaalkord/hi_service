class FavoriteProfessios {
 late int id;
 late String name;
 late String mobile;
 late String email;
 late String location;
 late int age;
 late String specialization;
 late String description;
 late bool status;
 late String gender;
 late int subCategoryId;
 late String imageUrl;
  Pivot? pivot;

  FavoriteProfessios();

  FavoriteProfessios.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    location = json['location'];
    age = json['age'];
    specialization = json['specialization'];
    description = json['description'];
    status = json['status'];
    gender = json['gender'];
    subCategoryId = json['sub_category_id'];
    imageUrl = json['image_url'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']): null;

  }

}

class Pivot {
 late int userId;
 late int professionId;
 late int id;

  Pivot();

  Pivot.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    professionId = json['profession_id'];
    id = json['id'];
  }

}