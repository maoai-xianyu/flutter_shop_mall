import 'package:flutter/material.dart';
import 'package:flutter_shop_mall/service/service_method.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // 适配
import '../model/CategoryListModel.dart';
import '../model/CategoryConvert.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('商品分类'),
      ),
      body: Container(
        child: Row(
          children: <Widget>[
            LeftCategoryNav(),
            Text('分类页面'),
          ],

        ),
      ),
    );
  }
}

class LeftCategoryNav extends StatefulWidget {
  @override
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  List<CategoryConvertData> categoryConvertListData = [];

  @override
  void initState() {
    // 获取数据
    _getCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
          border: Border(
              right: BorderSide(
                color: Colors.black12,
                width: 1,
                style: BorderStyle.solid,
              ))),
      child: ListView.builder(
          itemCount: categoryConvertListData.length,
          itemBuilder: (content, index) {
            return _leftNavInkWell(index);
          }),
    );
  }

  Widget _leftNavInkWell(index) {
    return InkWell(
      onTap: () {
        debugPrint("点击左侧导航");
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 10, top: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(
                width: 1,
                color: Colors.black12,
                style: BorderStyle.solid,
              )),
        ),
        child: Text(
          categoryConvertListData[index].mallCategoryName,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(28),
          ),
        ),
      ),
    );
  }

  void _getCategory() async {
    await getCategoryContent().then((value) {
      debugPrint(value);
      var data = json.decode(value.toString());
//      var categoryListModel = CategoryListModel.fromJson(data['data']);
//      categoryListModel.categoryListModel
//          .forEach((item) => {debugPrint(item.mallCategoryName)});

      var categoryConvertModel = CategoryConvert.fromJson(data);
      setState(() {
        categoryConvertListData = categoryConvertModel.data;
      });

      // 数据打印
      categoryConvertModel.data
          .forEach((item) => {debugPrint(item.mallCategoryName)});
    });
  }
}
