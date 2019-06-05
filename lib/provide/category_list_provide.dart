import 'package:flutter/material.dart';
import 'package:flutter_shop_mall/model/categoryGoodsListModel.dart';

class CategoryListProvide with ChangeNotifier {
  List<CategoryGoodsListModelData> categoryGoodsListModel = [];

  getCateGoryGoodsList(List<CategoryGoodsListModelData> list) {
    categoryGoodsListModel = list;
    notifyListeners();
  }
}
