import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/counter_provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('会员中心'),
        ),
        body: ListView(
          children: <Widget>[
            _headerWidget(),
          ],
        ));
  }

  // "https://timgsa.baidu.com/timg?image&quality=80&size=b10000_10000&sec=1551581454&di=5892d496faa80ab30acefe701c117a96&src=http://pic.58pic.com/58pic/16/83/80/16J58PICXdP_1024.jpg",

  Widget _headerWidget() {
    return Container(
      width: ScreenUtil().setWidth(750),
      color: Colors.redAccent,
      child: Column(
        children: <Widget>[
          Container(
            child: ClipOval(
              child: Image.network(
                "https://timgsa.baidu.com/timg?image&quality=80&size=b10000_10000&sec=1551581454&di=5892d496faa80ab30acefe701c117a96&src=http://pic.58pic.com/58pic/16/83/80/16J58PICXdP_1024.jpg",
                fit: BoxFit.cover,
                width: ScreenUtil().setWidth(160),
                height: ScreenUtil().setHeight(160),
              ),
            ),
            margin: EdgeInsets.only(top: 30, bottom: 30),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
                width: 3.0,
                style: BorderStyle.solid,
              ),
              shape: BoxShape.circle,
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 30),
            child: Text(
              '楠楠',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(36),
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
