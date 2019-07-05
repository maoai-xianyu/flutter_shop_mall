import 'package:flutter/material.dart';
import 'package:flutter_shop_mall/model/cartInfoModel.dart';
import 'package:flutter_shop_mall/provide/cart_provide.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop_mall/pages/cart_page/cart_item.dart';

import 'cart_page/cart_bottom.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品购物车'),
      ),
      body: FutureBuilder(
        future: _getCartGoods(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            debugPrint('购物车 有数据');
            List<CartInfoModel> listCartGoods =
                Provide.value<CartProvide>(context).cartInfoList;
            if (listCartGoods != null && listCartGoods.length > 0) {
              debugPrint('购物车 有数据 不为空');
              return Stack(
                children: <Widget>[
                  Provide<CartProvide>(
                    builder: (context, child, cartProvide) {
                      listCartGoods =
                          Provide.value<CartProvide>(context).cartInfoList;
                      if (listCartGoods != null && listCartGoods.length > 0) {
                        return Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.black12,
                                    width: 1,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                              ),
                              height: ScreenUtil().setHeight(1),
                            ),
                            Expanded(
                              flex: 2,
                              child: ListView.builder(
                                itemCount: listCartGoods.length,
                                itemBuilder: (context, index) {
                                  return CartItem(listCartGoods[index]);
                                },
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Center(
                          child: Text(
                            '当前购物车为空',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(30),
                              color: Colors.black12,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: CartBottom(),
                  ),
                ],
              );
            } else {
              debugPrint('购物车 有数据 为空');
              return Center(
                child: Text(
                  '当前购物车为空',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(30),
                    color: Colors.black12,
                  ),
                ),
              );
            }
          } else {
            debugPrint('购物车 没有数据');
            return Center(
              child: Text(
                '当前购物车为空',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(30),
                  color: Colors.black12,
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Future<String> _getCartGoods(BuildContext context) async {
    await Provide.value<CartProvide>(context).getCartInfoGoods();
    return "完成加载";
  }
}
