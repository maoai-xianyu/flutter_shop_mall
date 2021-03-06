import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop_mall/provide/cart_provide.dart';
import 'package:flutter_shop_mall/provide/current_index_provide.dart';
import 'package:flutter_shop_mall/provide/details_goods_provide.dart';
import 'package:provide/provide.dart';

class DetailsBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var goodsInfo =
        Provide.value<DetailsGoodsProvide>(context).detailsGoods.data.goodInfo;
    var goodsId = goodsInfo.goodsId;
    var goodsName = goodsInfo.goodsName;
    var count = 1;
    var presentPrice = goodsInfo.presentPrice;
    var oriPrice = goodsInfo.oriPrice;
    var images = goodsInfo.image1;

    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(100),
      child: Row(
        children: <Widget>[
          Stack(
            children: <Widget>[
              InkWell(
                onTap: () {
                  debugPrint('点击购物车');
                  Provide.value<CurrentIndexProvide>(context)
                      .changeCurrentIndex(2);
                  Navigator.pop(context);
                },
                child: Container(
                  height: ScreenUtil().setHeight(100),
                  width: ScreenUtil().setHeight(110),
                  color: Colors.white,
                  child: Icon(
                    Icons.shopping_cart,
                    size: 30,
                    color: Colors.pink,
                  ),
                ),
              ),
              Provide<CartProvide>(
                builder: (context, child, cartProvide) {
                  var allGoodsCount = cartProvide.allGoodsCount;
                  return Positioned(
                    top: 2,
                    right: 12,
                    child: Container(
                      padding:EdgeInsets.fromLTRB(6, 3, 6, 3),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        border: Border.all(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '$allGoodsCount',
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(16),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
          InkWell(
            onTap: () async {
              debugPrint('加入购物车');
              Provide.value<CartProvide>(context).save(
                  goodsId, goodsName, count, presentPrice, oriPrice, images);
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('添加购物车成功！'),
                action: SnackBarAction(
                  label: 'ok',
                  onPressed: () {},
                ),
              ));
            },
            child: Container(
              height: ScreenUtil().setHeight(100),
              width: ScreenUtil().setHeight(320),
              color: Colors.green,
              alignment: Alignment(0, 0),
              child: Text(
                '加入购物车',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(30),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              debugPrint('立即购买');
              Provide.value<CartProvide>(context).remove();
            },
            child: Container(
              height: ScreenUtil().setHeight(100),
              width: ScreenUtil().setHeight(320),
              color: Colors.red,
              alignment: Alignment(0, 0),
              child: Text(
                '立即购买',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(30),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
