import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderDetailTap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
        top: 20,
        bottom: 20,
      ),
      height: ScreenUtil().setHeight(180),
      child: GridView.count(
        crossAxisCount: 4,
        children: <Widget>[
          InkWell(
            child: Container(
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.payment,
                    size: 32,
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
                  Text(
                    "待付款",
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(24),
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            child: Container(
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.timer,
                    size: 32,
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
                  Text(
                    "待发货",
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(24),
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            child: Container(
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.flight_takeoff,
                    size: 32,
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
                  Text(
                    "待收货",
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(24),
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            child: Container(
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.comment,
                    size: 32,
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
                  Text(
                    "待评价",
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(24),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
