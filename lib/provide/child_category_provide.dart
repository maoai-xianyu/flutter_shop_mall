import 'package:flutter/material.dart';
import '../model/categoryConvert.dart';

class ChildCategoryProvide with ChangeNotifier {
  List<BxMallSubDto> bxMallSubDtoList = [];
  int childIndex = 0;

  // 获取右边上层分类
  getChildListCategory(List<BxMallSubDto> bxMallSubDto) {
    childIndex = 0;
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
