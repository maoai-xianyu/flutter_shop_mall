import 'package:flutter/material.dart';
import 'package:flutter_shop_mall/pages/details_page/details_tabbar.dart';
import 'package:flutter_shop_mall/provide/details_goods_provide.dart';
import 'package:provide/provide.dart';

import 'details_page/details_bottom.dart';
import 'details_page/details_explain.dart';
import 'details_page/details_top_area.dart';
import 'details_page/details_web.dart';

class DetailsPage extends StatelessWidget {
  final String goodsId;

  DetailsPage(this.goodsId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Provide<DetailsGoodsProvide>(
            builder: (context, child, detailsGoodsProvide) {
          var goodInfo = detailsGoodsProvide.detailsGoods.data.goodInfo;
          if (goodInfo != null) {
            return Text(goodInfo.goodsName);
          } else {
            return Text('商品详情');
          }
        }),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder(
        future: _getGoodDetail(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Stack(
              children: <Widget>[
                Container(
                  child: ListView(
                    children: <Widget>[
                      DetailsTopArea(),
                      DetailsExplain(),
                      DetailsTabBar(),
                      DetailsWeb(),
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  bottom: 0,
                  child: DetailsBottom(),
                )
              ],
            );
          } else {
            return Text('加载中.....');
          }
        },
      ),
    );
  }

  Future _getGoodDetail(BuildContext context) async {
    await Provide.value<DetailsGoodsProvide>(context).getDetailsGoods(goodsId);
    Provide.value<DetailsGoodsProvide>(context).changeTabState('left');
    return "完成加载";
  }
}
