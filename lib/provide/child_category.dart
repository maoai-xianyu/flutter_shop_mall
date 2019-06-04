import 'package:flutter/material.dart';
import '../model/CategoryConvert.dart';

class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> bxMallSubDtoList = [];

  // 获取右边上层分类
  getChildListCategory(List<BxMallSubDto> bxMallSubDto) {
    bxMallSubDtoList = bxMallSubDto;
    notifyListeners();
  }
}
