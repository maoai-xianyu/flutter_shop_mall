import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_shop_mall/pages/details_page.dart';

Handler detailsHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  String goodsId = parameters['id'].first;
  debugPrint('商品路由传入的id 是 $goodsId');
  return DetailsPage(goodsId);
});
