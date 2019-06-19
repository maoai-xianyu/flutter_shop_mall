import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(100),
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: () {
              debugPrint('点击购物车');
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
          InkWell(
            onTap: () {
              debugPrint('加入购物车');
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
            onTap: () {
              debugPrint('立即购买');
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
