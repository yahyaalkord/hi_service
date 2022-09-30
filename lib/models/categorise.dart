class Categorise {
 late int id;
 late String title;
 late String description;
 late bool status;
  int? subCategoriesCount;
 late String imageUrl;

  Categorise();

  Categorise.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
    subCategoriesCount = json['sub_categories_count'];
    imageUrl = json['image_url'];
  }

}
