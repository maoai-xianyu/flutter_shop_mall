import 'package:flutter/material.dart';
import 'member_page/member_common_tap.dart';
import 'member_page/member_header.dart';
import 'member_page/order_detail.dart';
import 'member_page/order_detail_tap.dart';
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
          MemberHeader(),
          OrderDetail(),
          OrderDetailTap(),
          SizedBox(
            height: ScreenUtil().setHeight(30),
          ),
          MemberCommonTap(Icons.headset, '领取优惠卷', '', '1', false),
          SizedBox(
            height: ScreenUtil().setHeight(1),
            child: Container(
              color: Colors.black12,
            ),
          ),
          MemberCommonTap(Icons.hearing, '已领取优惠卷', '', '2', false),
          SizedBox(
            height: ScreenUtil().setHeight(1),
            child: Container(
              color: Colors.black12,
            ),
          ),
          MemberCommonTap(Icons.add_location, '地址管理', '', '3', false),
          SizedBox(
            height: ScreenUtil().setHeight(30),
          ),
          MemberCommonTap(Icons.contact_phone, '客服电话', '0392-8800315', '4', true),
          SizedBox(
            height: ScreenUtil().setHeight(1),
            child: Container(
              color: Colors.black12,
            ),
          ),
          MemberCommonTap(Icons.shop, '关于商城', '', '5', false),
        ],
      ),
    );
  }
}
