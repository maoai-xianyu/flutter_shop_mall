import 'package:flutter/material.dart';
import '../model/categoryConvert_1.dart';

class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> bxMallSubDtoList = [];

  // 获取右边上层分类
  getChildListCategory(List<BxMallSubDto> bxMallSubDto) {
    BxMallSubDto addmallsubdto = BxMallSubDto();
    addmallsubdto.mallSubId = '00';
    addmallsubdto.mallSubName = '全部';
    addmallsubdto.mallCategoryId = '00';
    addmallsubdto.comments = 'null';
    bxMallSubDtoList=[addmallsubdto];
    bxMallSubDtoList.addAll(bxMallSubDto);
    notifyListeners();
  }
}
