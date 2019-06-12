import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsExplain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.all(10),
      color: Colors.white,
      child: Text(
        '说明：>急速送达 >正品保证',
        style: TextStyle(
          color: Colors.redAccent,
          fontSize: ScreenUtil().setSp(26),
        ),
      ),
    );
  }
}
