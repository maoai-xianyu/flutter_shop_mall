import 'package:flutter/material.dart';
import 'package:flutter_shop_mall/provide/details_goods_provide.dart';
import 'package:provide/provide.dart';

import 'details_page/details_top_area.dart';

class DetailsPage extends StatelessWidget {
  final String goodsId;

  DetailsPage(this.goodsId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品详情页'),
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
            return Container(
              child: Column(
                children: <Widget>[
                  DetailsTopArea(),
                ],
              ),
            );
          } else {
            return Text('加载中.....');
          }
        },
      ),
    );
  }

  Future _getGoodDetail(BuildContext context) async {
    Provide.value<DetailsGoodsProvide>(context).getDetailsGoods(goodsId);
    return "完成加载";
  }
}
