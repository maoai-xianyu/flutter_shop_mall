import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop_mall/provide/details_goods_provide.dart';
import 'package:provide/provide.dart';
import 'package:flutter_html/flutter_html.dart';

class DetailsWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var goodsDetail = Provide.value<DetailsGoodsProvide>(context)
        .detailsGoods
        .data
        .goodInfo
        .goodsDetail;
    debugPrint(' goodsDetail  $goodsDetail');
    return Container(
      child: Html(data: goodsDetail),
    );
  }
}
