import 'package:flutter/material.dart';
import 'package:flutter_shop_mall/provide/details_goods_provide.dart';
import 'package:provide/provide.dart';

class DetailsPage extends StatelessWidget {
  final String goodsId;

  DetailsPage(this.goodsId);

  @override
  Widget build(BuildContext context) {
    Provide.value<DetailsGoodsProvide>(context).getDetailsGoods(goodsId);
    debugPrint(".....测试");
    return Container(
      child: Text('商品id $goodsId'),
    );
  }
}
