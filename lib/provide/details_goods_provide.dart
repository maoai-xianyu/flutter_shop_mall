import 'package:flutter/material.dart';
import 'package:flutter_shop_mall/model/detailsGoodsModel.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shop_mall/service/service_method.dart';
import 'dart:convert';

class DetailsGoodsProvide with ChangeNotifier {
  DetailsGoodsModel detailsGoods;

  bool isLeft = false;
  bool isRight = false;

  changeTabState(String type) {
    if (type == 'left') {
      isLeft = true;
      isRight = false;
    } else {
      isLeft = false;
      isRight = true;
    }
    notifyListeners();
  }


  getDetailsGoods(String goodsId) {
    getDetailGoods(goodsId).then((value) {
      debugPrint("----$value");
      var data = json.decode(value.toString());
      detailsGoods = DetailsGoodsModel.fromJson(data);
      notifyListeners();
    });
  }
}
