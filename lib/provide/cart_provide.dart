import 'package:flutter/material.dart';
import 'package:flutter_shop_mall/model/cartInfoModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartProvide extends ChangeNotifier {
  String cartGoodsStr = "[]";
  List<CartInfoModel> cartInfoList = [];
  double allPrice = 0;
  int allGoodsCount = 0;

  void save(String goodsId, String goodsName, int count, double presentPrice,
      double oriPrice, String images) async {
    // 初始化SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // 获取数据
    cartGoodsStr = prefs.getString('cartInfo');
    debugPrint('cartGoodsStr 值  $cartGoodsStr');
    // 判断cartString是否为空，为空说明是第一次添加，或者被key被清除了。
    // 如果有值进行decode操作
    var temp = cartGoodsStr == null ? [] : json.decode(cartGoodsStr.toString());
    List<Map> tampList = (temp as List).cast();
    // 如果数据不为空，那么需要给 cartInfoList 添加数据
    if (tampList != null && tampList.length > 0) {
      tampList.forEach((item) {
        cartInfoList.add(new CartInfoModel.fromJson(item));
      });
    }

    // 判断是否存在当前商品
    bool isHaveThisGoods = false;

    // 用于进行循环的索引使用
    int ival = 0;
    // 进行循环，找出是否已经存在该商品
    tampList.forEach((item) {
      debugPrint('ival 前 $ival');
      // 如果存在，数量进行+1操作
      if (item['goodsId'] == goodsId) {
        debugPrint('有一样的数据，+1');
        tampList[ival]['count'] = item['count'] + 1;
        cartInfoList[ival].count++;
        isHaveThisGoods = true;
      }
      ival++;
    });

    debugPrint('ival 后 $ival');

    //  如果没有，进行增加
    if (!isHaveThisGoods) {
      Map<String, dynamic> newGoods = {
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': presentPrice,
        'oriPrice': oriPrice,
        'images': images,
        'isCheck': true
      };
      tampList.add(newGoods);
      cartInfoList.add(CartInfoModel.fromJson(newGoods));
    }

    //把字符串进行encode操作，
    cartGoodsStr = json.encode(tampList).toString();
    debugPrint('持久化数据 字符串 $cartGoodsStr');
    debugPrint('持久化数据 列表 $cartInfoList');
    prefs.setString('cartInfo', cartGoodsStr); //进行持久化
  }

  // 清空
  void remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.clear();//清空键值对
    prefs.remove('cartInfo');
    // 置空数据
    cartInfoList = [];
    debugPrint('清空完成-----------------');
    notifyListeners();
  }

  // 得到购物车中的商品
  getCartInfoGoods() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var cartInfoStr = prefs.getString('cartInfo');
    //把cartList进行初始化，防止数据混乱
    cartInfoList = [];

    // 判断得到的字符串是否有值，如果不判断会报错
    if (cartInfoStr == null) {
      cartInfoList = [];
    } else {
      allPrice = 0;
      allGoodsCount = 0;
      var cartInfoJson = json.decode(cartInfoStr.toString());
      List<Map> tampList = (cartInfoJson as List).cast();
      tampList.forEach((item) {
        if(item['isCheck']){
          allPrice+= item['count']*item['price'];
          allGoodsCount += item['count'];
        }
        cartInfoList.add(new CartInfoModel.fromJson(item));
      });
    }
    notifyListeners();
  }

  // 删除购物车数据
  deleteCartInfoGoods(String goodsId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var cartInfoStr = prefs.getString('cartInfo');
    var cartInfoJson = json.decode(cartInfoStr.toString());
    List<Map> tampList = (cartInfoJson as List).cast();

    // 用于进行循环的索引使用
    int ival = 0;
    int delIndex = 0;
    // 进行循环，找出是否已经存在该商品
    tampList.forEach((item) {
      // 如果存在，数量进行+1操作
      if (item['goodsId'] == goodsId) {
        delIndex = ival;
      }
      ival++;
    });
    tampList.removeAt(delIndex);
    cartGoodsStr = json.encode(tampList).toString();
    prefs.setString('cartInfo', cartGoodsStr); //进行持久化
    await getCartInfoGoods();
  }
}
