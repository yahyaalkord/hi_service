class Profession {
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

  Profession();

  Profession.fromJson(Map<String, dynamic> json) {
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
  }

}