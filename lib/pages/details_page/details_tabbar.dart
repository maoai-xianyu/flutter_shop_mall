import 'package:flutter/material.dart';
import 'package:flutter_shop_mall/provide/details_goods_provide.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<DetailsGoodsProvide>(
      builder: (context, child, detailsGoodsProvide) {
        return Provide<DetailsGoodsProvide>(
          builder: (context, child, detailsGoodsProvide) {
            var isLeft = detailsGoodsProvide.isLeft;
            var isRight = detailsGoodsProvide.isRight;
            return Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                children: <Widget>[
                  _leftTabBar(context, isLeft),
                  _rightTabBar(context, isRight),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _leftTabBar(BuildContext context, bool isLeft) {
    return _tabBar(context, '详情', 'left', isLeft);
  }

  Widget _rightTabBar(BuildContext context, bool isLeft) {
    return _tabBar(context, '评论', 'right', isLeft);
  }

  Widget _tabBar(
      BuildContext context, String desc, String type, bool changeState) {
    return InkWell(
      onTap: () {
        debugPrint('点击tab');
        Provide.value<DetailsGoodsProvide>(context).changeTabState(type);
      },
      child: Container(
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(375),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: changeState ? Colors.pink : Colors.black12,
              width: 1,
              style: BorderStyle.solid,
            ),
          ),
        ),
        child: Text(
          desc,
          style: TextStyle(
            color: changeState ? Colors.pink : Colors.black,
            fontSize: ScreenUtil().setSp(28),
          ),
        ),
      ),
    );
  }
}
