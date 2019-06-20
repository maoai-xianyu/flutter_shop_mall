import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvide extends ChangeNotifier {
  String cartGoodsStr = "[]";

  void save(String goodsId, String goodsName, int count, double presentPrice,
      String images) async {
    // 初始化SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // 获取数据
    cartGoodsStr = prefs.getString('cartInfo');
    debugPrint('cartGoodsStr 值  $cartGoodsStr');
    // 判断cartString是否为空，为空说明是第一次添加，或者被key被清除了。
    // 如果有值进行decode操作
    var temp = cartGoodsStr == null ? [] : json.decode(cartGoodsStr.toString());
    List<Map> tampList = (temp as List).cast();

    // 判断是否存在当前商品
    bool isHaveThisGoods = false;

    // 用于进行循环的索引使用
    int ival = 0;
    // 进行循环，找出是否已经存在该商品
    tampList.forEach((item) {
      // 如果存在，数量进行+1操作
      if (item['goodsId'] == goodsId) {
        tampList[ival]['count'] = item['count'] + 1;
        isHaveThisGoods = true;
      }
      ival++;
    });

    //  如果没有，进行增加
    if (!isHaveThisGoods) {
      tampList.add({
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': presentPrice,
        'images': images
      });
    }

    //把字符串进行encode操作，
    cartGoodsStr = json.encode(tampList).toString();
    debugPrint('持久化数据  $cartGoodsStr');
    prefs.setString('cartInfo', cartGoodsStr); //进行持久化
  }

  void remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.clear();//清空键值对
    prefs.remove('cartInfo');
    debugPrint('清空完成-----------------');
    notifyListeners();
  }
}
