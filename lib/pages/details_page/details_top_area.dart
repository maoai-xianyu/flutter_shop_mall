import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop_mall/provide/details_goods_provide.dart';
import 'package:provide/provide.dart';

class DetailsTopArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<DetailsGoodsProvide>(
      builder: (context, child, detailsGoodsProvide) {
        debugPrint("ssss${detailsGoodsProvide.detailsGoods.data}");
        var goodInfo = detailsGoodsProvide.detailsGoods.data.goodInfo;
        if (goodInfo != null) {
          return Container(
            color: Colors.white,
            padding: EdgeInsets.all(2.0),
            child: Column(
              children: <Widget>[
                _goodsImage(goodInfo.image1),
                _goodsName(goodInfo.goodsName),
                _goodsSerialNumber(goodInfo.goodsSerialNumber),
                _goodsPrice(goodInfo.oriPrice,goodInfo.presentPrice),
              ],
            ),
          );
        } else {
          return Text('当前详细页面没有数据....');
        }
      },
    );
  }

  // 商品图片
  Widget _goodsImage(String imageUrl) {
    return Image.network(
      imageUrl,
      width: ScreenUtil().setWidth(740),
    );
  }

  // 名字
  Widget _goodsName(String name) {
    return Container(
      width: ScreenUtil().setWidth(730),
      margin: EdgeInsets.only(left: 10),
      child: Text(
        name,
        style: TextStyle(
          color: Colors.black,
          fontSize: ScreenUtil().setSp(30),
        ),
      ),
    );
  }

  // 编码
  Widget _goodsSerialNumber(String num) {
    return Container(
      width: ScreenUtil().setWidth(750),
      margin: EdgeInsets.fromLTRB(10, 5, 0, 0),
      child: Text(
        "编号：$num",
        style: TextStyle(
          color: Colors.black26,
          fontSize: ScreenUtil().setSp(24),
        ),
      ),
    );
  }

  // 价钱
  Widget _goodsPrice(double oriPrice, double presentPrice) {
    return Container(
      width: ScreenUtil().setWidth(750),
      margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
      child: Row(
        children: <Widget>[
          Text(
            "￥$oriPrice",
            style: TextStyle(
              color: Colors.pinkAccent,
              fontSize: ScreenUtil().setSp(40),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Text(
              "市场价：",
              style: TextStyle(
                color: Colors.black,
                fontSize: ScreenUtil().setSp(26),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Text(
              "￥$presentPrice",
              style: TextStyle(
                color: Colors.black26,
                fontSize: ScreenUtil().setSp(24),
                decoration: TextDecoration.lineThrough,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
