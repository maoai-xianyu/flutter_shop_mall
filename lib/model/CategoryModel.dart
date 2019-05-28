class CategoryModel {
  String mallCategoryId;
  String mallCategoryName;
  List<dynamic> bxMallSubDto;
  Null comments;
  String image;

  CategoryModel(
      {this.mallCategoryId,
      this.mallCategoryName,
      this.bxMallSubDto,
      this.image,
      this.comments});

  factory CategoryModel.fromJson(dynamic json) {
    return CategoryModel(
        mallCategoryId: json['mallCategoryId'],
        mallCategoryName: json['mallCategoryName'],
        bxMallSubDto: json['bxMallSubDto'],
        comments: json['comments'],
        image: json['image']);
  }
}

