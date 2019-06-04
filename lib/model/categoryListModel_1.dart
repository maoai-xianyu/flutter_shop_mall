import 'categoryModel_1.dart';

class CategoryListModel {
  List<CategoryModel> categoryListModel;

  CategoryListModel(this.categoryListModel);

  factory CategoryListModel.fromJson(List json) {
    return CategoryListModel(
        json.map((index) => CategoryModel.fromJson(index)).toList());
  }
}
