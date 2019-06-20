import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/counter_provide.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<String> listDatas = [];

  @override
  Widget build(BuildContext context) {
    showGoodsNames();
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: ScreenUtil().setHeight(500),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(listDatas[index]),
                  );
                },
                itemCount: listDatas.length,
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(20),
            ),
            Row(
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    addGoodsName();
                  },
                  child: Text('添加'),
                ),
                OutlineButton(
                  onPressed: () {
                    clearGoodsNames();
                  },
                  child: Text('删除'),
                ),
                RaisedButton(
                  onPressed: () {
                    addGoodsName();
                  },
                  child: Text('添加1'),
                ),
                MaterialButton(
                  onPressed: () {
                    clearGoodsNames();
                  },
                  child: Text('删除2'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void addGoodsName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String temp = 'this is codingtk coding';
    listDatas.add(temp);
    prefs.setStringList('cart_goods_name', listDatas);
    showGoodsNames();
  }

  void showGoodsNames() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var stringList = prefs.getStringList('cart_goods_name');
    if (stringList != null) {
      setState(() {
        listDatas = stringList;
      });
    }
  }

  void clearGoodsNames() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // 删除所有
    //prefs.clear();
    // 删除指定所有
    prefs.remove('cart_goods_name');
    setState(() {
      listDatas = [];
    });
  }
}
