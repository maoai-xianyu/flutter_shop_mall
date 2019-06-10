import 'package:flutter/material.dart';
import 'package:flutter_shop_mall/model/detailsGoodsModel.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shop_mall/service/service_method.dart';
import 'dart:convert';

class DetailsGoodsProvide with ChangeNotifier {
  DetailsGoodsModel detailsGoods;

  getDetailsGoods(String goodsId) {
    getDetailGoods(goodsId).then((value) {
      debugPrint("----$value");
      var data = json.decode(value.toString());
      detailsGoods = DetailsGoodsModel.fromJson(data);
      notifyListeners();
    });
  }
}
