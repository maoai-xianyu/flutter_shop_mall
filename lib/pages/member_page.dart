import 'package:flutter/material.dart';
import 'member_page/member_header.dart';
import 'member_page/order_detail.dart';
import 'member_page/order_detail_tap.dart';

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
        ],
      ),
    );
  }
}
