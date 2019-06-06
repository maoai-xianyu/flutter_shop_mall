import 'package:flutter/material.dart';
import '../model/categoryConvert.dart';

class ChildCategoryProvide with ChangeNotifier {
  List<BxMallSubDto> bxMallSubDtoList = [];
  int childIndex = 0;

  // 提供当前左边导航的id
  String currentCategoryId = '4'; // 默认给4 这是根据数据
  // 二级分类id
  String currentCategorySubId = '';

  // 上拉加载page
  int page = 1;

  // 上拉加载没有数据提示文案
  String noMoreText = '';

  // 获取右边上层分类
  getChildListCategory(List<BxMallSubDto> bxMallSubDto, String categoryId) {
    childIndex = 0;
    currentCategoryId = categoryId;
    page = 1;
    noMoreText = '';
    BxMallSubDto addmallsubdto = BxMallSubDto();
    addmallsubdto.mallSubId = '';
    addmallsubdto.mallSubName = '全部';
    addmallsubdto.mallCategoryId = categoryId;
    addmallsubdto.comments = 'null';
    bxMallSubDtoList = [addmallsubdto];
    bxMallSubDtoList.addAll(bxMallSubDto);
    notifyListeners();
  }

  // 更新当前选择的二级分类
  void getCategoryChildIndex(int index, String categorySubId) {
    childIndex = index;
    currentCategorySubId = categorySubId;
    page = 1;
    noMoreText = '';
    notifyListeners();
  }

  // 增加当前页面数 page, 不改变页面不用 notifyListeners();
  void addCurrentPage() {
    page++;
  }

  // 显示当前没有数据提示文案
  void changeCurrentNoMoreText(String currentNoMoreText) {
    noMoreText = currentNoMoreText;
    notifyListeners();
  }
}
