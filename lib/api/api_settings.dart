class ApiSettings {
  static const String _baseUrl = "http://profession.tmooh-dev.com/api/";
  static const String login ='${_baseUrl}auth/login';
  static const String logout ='${_baseUrl}auth/logout';
  static const String register ='${_baseUrl}auth/register';
  static const String forget ='${_baseUrl}auth/forget-password';
  static const String reset ='${_baseUrl}auth/reset-password';
  static const String home ='${_baseUrl}home';
  static const String categories ='${_baseUrl}categories';
  static const String subCategories ='${_baseUrl}subCategories';
  static const String professions ='${_baseUrl}professions';
  static const String categorySubCategory ='${_baseUrl}category/subCategory/{id}';
  static const String searchCategories ='${_baseUrl}category/search/{name}';
  static const String searchSubCategory ='${_baseUrl}subCategory/search/{name}';
  static const String searchProfession ='${_baseUrl}profession/search/{name}';
  static const String professionsSub ='${_baseUrl}subCategory/profession/{id}';
  static const String professionsShow ='${_baseUrl}profession/profession/{id}';
  static const String favoriteProfession ='${_baseUrl}favorite-profession';
  static const String edit ='${_baseUrl}auth/profile-{name}';
  static const String changePassword ='${_baseUrl}auth/change-password';
}