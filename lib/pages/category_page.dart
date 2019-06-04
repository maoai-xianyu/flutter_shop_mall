import 'package:flutter/material.dart';
import 'package:flutter_shop_mall/provide/child_category.dart';
import 'package:flutter_shop_mall/service/service_method.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // 适配
import '../model/categoryListModel.dart';
import '../model/categoryConvert.dart';
import '../model/categoryGoodsListModel.dart';
import 'package:provide/provide.dart';

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
            Column(
              children: <Widget>[
                RightCategoryNav(),
                CategoryGoodsList(),
              ],
            ),
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

  // 用于交互效果
  var listIndex = 0;

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
          ),
        ),
      ),
      child: ListView.builder(
        itemCount: categoryConvertListData.length,
        itemBuilder: (content, index) {
          return _leftNavInkWell(index);
        },
      ),
    );
  }

  Widget _leftNavInkWell(index) {
    bool isClick = false;
    isClick = (index == listIndex) ? true : false;
    return InkWell(
      onTap: () {
        // 用于交互效果
        setState(() {
          listIndex = index;
        });
        debugPrint("点击左侧导航，左边显示");
        // 点击赋值
        var childList = categoryConvertListData[index].bxMallSubDto;
        Provide.value<ChildCategory>(context).getChildListCategory(childList);
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 10, top: 20),
        decoration: BoxDecoration(
          // 用于交互效果
          color: isClick ? Color.fromRGBO(236, 236, 236, 1.0) : Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Colors.black12,
              style: BorderStyle.solid,
            ),
          ),
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

      // 默认选中第一个时，显示对应的二级分类
      Provide.value<ChildCategory>(context)
          .getChildListCategory(categoryConvertListData[0].bxMallSubDto);
    });
  }
}

class RightCategoryNav extends StatefulWidget {
  @override
  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<RightCategoryNav> {
  @override
  Widget build(BuildContext context) {
    // 状态管理
    return Provide<ChildCategory>(builder: (context, child, childCategory) {
      return Container(
        height: ScreenUtil().setHeight(80),
        width: ScreenUtil().setWidth(570),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Colors.black12,
              style: BorderStyle.solid,
            ),
          ),
        ),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) =>
              _rightNavItemInkWell(childCategory.bxMallSubDtoList[index]),
          itemCount: childCategory.bxMallSubDtoList.length,
        ),
      );
    });
  }

  Widget _rightNavItemInkWell(BxMallSubDto item) {
    return InkWell(
      onTap: () {
        debugPrint('点击');
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
        child: Text(
          item.mallSubName,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(28),
          ),
        ),
      ),
    );
  }
}

//商品列表 可以上拉加载
class CategoryGoodsList extends StatefulWidget {
  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {
  List<CategoryGoodsListModelData> categoryGoodsList = [];

  @override
  void initState() {
    _getGoodsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(570),
      height: ScreenUtil().setHeight(999),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return _goodsItemInkWell(index);
        },
        itemCount: categoryGoodsList.length,
      ),
    );
  }

  void _getGoodsList() async {
    await getCategoryGoods('4', "", 1).then((value) {
      var data = json.decode(value.toString());
      debugPrint('分类：$data');
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);

      // 赋值
      setState(() {
        categoryGoodsList = goodsList.data;
      });

      // 数据打印
      goodsList.data.forEach((item) => {debugPrint(item.goodsName)});
    });
  }

  Widget _goodsImage(int index) {
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(categoryGoodsList[index].image),
    );
  }

  Widget _goodsName(int index) {
    return Container(
      padding: EdgeInsets.all(5),
      width: ScreenUtil().setWidth(370),
      child: Text(
        categoryGoodsList[index].goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(28),
        ),
      ),
    );
  }

  Widget _goodsPrice(int index) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: ScreenUtil().setWidth(370),
      child: Row(
        children: <Widget>[
          Text(
            '价格：￥${categoryGoodsList[index].presentPrice}',
            style: TextStyle(
              color: Colors.pink,
              fontSize: ScreenUtil().setSp(30),
            ),
          ),
          Text(
            '￥${categoryGoodsList[index].oriPrice}',
            style: TextStyle(
              color: Colors.black12,
              fontSize: ScreenUtil().setSp(28),
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ],
      ),
    );
  }

  Widget _goodsItemInkWell(int index) {
    return InkWell(
      onTap: () {
        debugPrint("点击商品");
      },
      child: Container(
        padding: EdgeInsets.only(top: 8, bottom: 8),
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
        child: Row(
          children: <Widget>[
            _goodsImage(index),
            Column(
              children: <Widget>[
                _goodsName(index),
                _goodsPrice(index),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
