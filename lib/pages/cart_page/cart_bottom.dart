import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.all(5.0),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          _checkBoxAll(),
          _allPrice(),
          _allPayAll(),
          //_goPayAll(),
        ],
      ),
    );
  }

  // 全选
  Widget _checkBoxAll() {
    return Container(
      child: Row(
        children: <Widget>[
          Checkbox(
            onChanged: (value) {
              debugPrint('点击全选');
            },
            value: true,
            activeColor: Colors.pink,
            checkColor: Colors.white,
          ),
          Text(
            '全选',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: ScreenUtil().setSp(24),
            ),
          ),
        ],
      ),
    );
  }

  // 价格
  Widget _allPrice() {
    return Container(
      width: ScreenUtil().setWidth(400),
      alignment: Alignment.centerRight,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                child: Text(
                  '合计：',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(24),
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: Text(
                  '￥1992',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(30),
                    color: Colors.redAccent,
                  ),
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              '满10元免配送费，预购免配送费',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(22),
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 结算
  Widget _allPayAll() {
    return Container(
      width: ScreenUtil().setWidth(150),
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 10),
      child: MaterialButton(
        onPressed: () {},
        child: Text(
          '结算(6)',
        ),
        color: Colors.red,
        textColor: Colors.white,
      ),
    );
  }

  // 或者自己做button
  Widget _goPayAll() {
    return Container(
      width: ScreenUtil().setWidth(150),
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 10),
      child: InkWell(
        onTap: () {
          debugPrint('自己画button');
        },
        child: Container(
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.all(
              Radius.circular(3),
            ),
          ),
          child: Text(
            '结算(6)',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
