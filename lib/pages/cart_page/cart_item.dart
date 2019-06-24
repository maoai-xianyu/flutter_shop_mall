import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop_mall/model/cartInfoModel.dart';

import 'cart_count.dart';

class CartItem extends StatelessWidget {
  CartInfoModel cartInfoModel;

  CartItem(this.cartInfoModel);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 2.0, 5.0, 2.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.black12,
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
      ),
      child: Row(
        children: <Widget>[
          _checkBoxCartGoods(),
          _imageCartGoods(),
          _cartGoodsNameCount(),
          _cartGoodsPrice(),
        ],
      ),
    );
  }

  // 复选框
  Widget _checkBoxCartGoods() {
    return Container(
      child: Checkbox(
        value: true,
        onChanged: (value) {
          debugPrint('点击$value');
        },
        checkColor: Colors.white,
        activeColor: Colors.pink,
      ),
    );
  }

  // 图片
  Widget _imageCartGoods() {
    return Container(
      width: ScreenUtil().setWidth(150),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.black12),
      ),
      child: Image.network(cartInfoModel.images),
    );
  }

  // 商品名称
  Widget _cartGoodsNameCount() {
    return Container(
      width: ScreenUtil().setWidth(300),
      padding: EdgeInsets.all(10),
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            cartInfoModel.goodsName,
            style: TextStyle(
              fontSize: ScreenUtil().setSp(28),
              color: Colors.black,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.left,
          ),
          CartCount(),
        ],
      ),
    );
  }

  // 商品价钱
  Widget _cartGoodsPrice() {
    return Container(
      width: ScreenUtil().setWidth(150),
      child: Column(
        children: <Widget>[
          Text(
            '￥${cartInfoModel.price}',
            style: TextStyle(
              fontSize: ScreenUtil().setSp(24),
              color: Colors.black,
            ),
          ),
          Text(
            '￥${cartInfoModel.oriPrice}',
            style: TextStyle(
              fontSize: ScreenUtil().setSp(24),
              color: Colors.black26,
              decoration: TextDecoration.lineThrough,
            ),
          ),
          InkWell(
            onTap: () {},
            child: Icon(
              Icons.delete,
              color: Colors.black12,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
