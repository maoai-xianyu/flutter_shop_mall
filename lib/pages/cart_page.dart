import 'package:flutter/material.dart';
import 'package:flutter_shop_mall/model/cartInfoModel.dart';
import 'package:flutter_shop_mall/provide/cart_provide.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
              return ListView.builder(
                itemCount: listCartGoods.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(listCartGoods[index].goodsName),
                  );
                },
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
