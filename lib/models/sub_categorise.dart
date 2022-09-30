class SubCategorise {
 late int id;
 late String title;
 late String description;
 late bool status;
 late int categoryId;
 late String imageUrl;

  SubCategorise();

  SubCategorise.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
    categoryId = json['category_id'];
    imageUrl = json['image_url'];
  }
}
