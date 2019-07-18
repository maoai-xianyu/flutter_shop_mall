import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        debugPrint('我的订单');
      },
      child: Container(
        margin: EdgeInsets.only(top: 10),
        width: ScreenUtil().setWidth(750),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: Colors.black12,
              style: BorderStyle.solid,
              width: 1,
            ),
          ),
        ),
        child: ListTile(
          leading: Icon(Icons.payment),
          title: Text('我的订单'),
          trailing: Icon(Icons.arrow_right),
        ),
      ),
    );
  }
}
