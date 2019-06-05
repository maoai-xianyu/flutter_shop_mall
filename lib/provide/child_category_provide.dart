import 'package:flutter/material.dart';
import '../model/categoryConvert.dart';

class ChildCategoryProvide with ChangeNotifier {
  List<BxMallSubDto> bxMallSubDtoList = [];
  int childIndex = 0;
  // 提供当前左边导航的id
  String currentCategoryId;

  // 获取右边上层分类
  getChildListCategory(List<BxMallSubDto> bxMallSubDto,String categoryId) {
    childIndex = 0;
    currentCategoryId = categoryId;
    BxMallSubDto addmallsubdto = BxMallSubDto();
    addmallsubdto.mallSubId = '00';
    addmallsubdto.mallSubName = '全部';
    addmallsubdto.mallCategoryId = '00';
    addmallsubdto.comments = 'null';
    bxMallSubDtoList = [addmallsubdto];
    bxMallSubDtoList.addAll(bxMallSubDto);
    notifyListeners();
  }

  // 更新当前选择的二级分类
  void getCategoryChildIndex(int index) {
    childIndex = index;
    notifyListeners();
  }
}
