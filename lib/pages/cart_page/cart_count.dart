import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartCount extends StatelessWidget {
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
          _reduceBtn(),
          _addNumCount(),
          _addBtn(),
        ],
      ),
    );
  }

  // 减少
  Widget _reduceBtn() {
    return InkWell(
      onTap: () {
        debugPrint('减少数据');
      },
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setWidth(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.black12,
          border: Border(
            right: BorderSide(
              color: Colors.white,
              width: 1,
            ),
          ),
        ),
        child: Text('-'),
      ),
    );
  }

  // 增加
  Widget _addBtn() {
    return InkWell(
      onTap: () {
        debugPrint('增加数据');
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
      child: Text('1'),
    );
  }
}
