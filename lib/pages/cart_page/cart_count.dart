import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop_mall/model/cartInfoModel.dart';
import 'package:flutter_shop_mall/provide/cart_provide.dart';
import 'package:provide/provide.dart';

class CartCount extends StatelessWidget {
  final CartInfoModel cartInfoModel;

  CartCount(this.cartInfoModel);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(165),
      margin: EdgeInsets.only(top: 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.black12,
          width: 1,
        ),
      ),
      child: Row(
        children: <Widget>[
          _reduceBtn(context),
          _addNumCount(),
          _addBtn(context),
        ],
      ),
    );
  }

  // 减少
  Widget _reduceBtn(BuildContext context) {
    return InkWell(
      onTap: () {
        if (cartInfoModel.count > 1) {
          debugPrint('减少数据');
          Provide.value<CartProvide>(context)
              .goodsCountReduceAndAdd(cartInfoModel, 'reduce');
        }
      },
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setWidth(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: cartInfoModel.count > 1 ? Colors.white : Colors.black12,
          border: Border(
            right: BorderSide(
              color: Colors.black12,
              width: 1,
            ),
          ),
        ),
        child: cartInfoModel.count > 1 ? Text('-') : Text(' '),
      ),
    );
  }

  // 增加
  Widget _addBtn(BuildContext context) {
    return InkWell(
      onTap: () {
        debugPrint('增加数据');
        Provide.value<CartProvide>(context)
            .goodsCountReduceAndAdd(cartInfoModel, 'add');
      },
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setWidth(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.black12,
          border: Border(
            left: BorderSide(
              color: Colors.white,
              width: 1,
            ),
          ),
        ),
        child: Text('+'),
      ),
    );
  }

  // 数字
  Widget _addNumCount() {
    return Container(
      width: ScreenUtil().setWidth(71),
      height: ScreenUtil().setWidth(45),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Text('${cartInfoModel.count}'),
    );
  }
}
