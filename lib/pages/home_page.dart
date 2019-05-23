import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert'; // 导入json
import 'package:flutter_screenutil/flutter_screenutil.dart'; // 适配
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

// 保持页面状态
class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  String homePageContent = '正在获取数据';

  int page = 1;
  List<Map> _hotGoods = [];
  GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    debugPrint('初始化页面');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('百姓生活+'),
      ),
      body: FutureBuilder(
        future: getHomePageContent(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // 有数据
            // json反编译
            var data = json.decode(snapshot.data.toString());
            // 数据转换
            List<Map> swiperList = (data['data']['slides'] as List).cast();
            // 获取grid
            List<Map> navigatorList = (data['data']['category'] as List).cast();
            // 获取广告
            String adPicture =
                data['data']['advertesPicture']['PICTURE_ADDRESS'];
            // 获取店长信息
            String leaderImage = data['data']['shopInfo']['leaderImage'];
            String leaderPhone = data['data']['shopInfo']['leaderPhone'];
            // 获取商品项目
            List<Map> recommendList =
                (data['data']['recommend'] as List).cast();

            // 获取楼层
            String picture1Address =
                data['data']['floor1Pic']['PICTURE_ADDRESS'];
            String picture2Address =
                data['data']['floor2Pic']['PICTURE_ADDRESS'];
            String picture3Address =
                data['data']['floor3Pic']['PICTURE_ADDRESS'];
            // 获取楼层商品
            List<Map> floor1GoodsList = (data['data']['floor1'] as List).cast();
            List<Map> floor2GoodsList = (data['data']['floor2'] as List).cast();
            List<Map> floor3GoodsList = (data['data']['floor3'] as List).cast();

            return EasyRefresh(
              child: ListView(
                children: <Widget>[
                  SwiperDiy(swiperList),
                  TopNavigator(navigatorList),
                  AdBanner(adPicture),
                  LeaderPhone(leaderImage, leaderPhone),
                  Recommend(recommendList),
                  FloorTitle(picture1Address),
                  FloorContent(floor1GoodsList),
                  FloorTitle(picture2Address),
                  FloorContent(floor2GoodsList),
                  FloorTitle(picture3Address),
                  FloorContent(floor3GoodsList),
                  _HotGoods(),
                ],
              ),
              // 上拉加载，footer设置
              refreshFooter: ClassicsFooter(
                key: _footerKey,
                bgColor: Colors.white,
                textColor: Colors.pink,
                moreInfoColor: Colors.pink,
                showMore: true,
                noMoreText: '',
                moreInfo: '加载中...',
                loadReadyText: '上拉加载...',
              ),
              // 上拉加载
              loadMore: () async {
                debugPrint('获取火爆专区的数据，开始加载更多....');
                await getHomePageHotContent(page).then((value) {
                  debugPrint(value);
                  var data = json.decode(value.toString());
                  List<Map> newGoodList = (data['data'] as List).cast();
                  this.setState(() {
                    _hotGoods.addAll(newGoodList);
                    page++;
                  });
                });
              },
            );
          } else {
            // 没有数据
            return Center(
              child: Text(
                '加载中....',
              ),
            );
          }
        },
      ),
    );
  }

  Widget _HotGoods() {
    return Container(
      child: Column(
        children: <Widget>[
          _hotGoodTitle(),
          _hotGoodsShow(),
        ],
      ),
    );
  }

  // 火爆专区
  Widget _hotGoodTitle() {
    return Container(
      padding: EdgeInsets.all(8.0),
      alignment: Alignment.center,
      color: Colors.grey[100],
      child: Container(
        width: ScreenUtil().setWidth(150),
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 5),
              child: Image.asset(
                'images/hot_fire.png',
                fit: BoxFit.cover,
                width: ScreenUtil().setWidth(30),
                height: ScreenUtil().setWidth(30),
              ),
            ),
            Text(
              '火爆专区',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(20),
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }

  // 火爆专区商品
  Widget _hotGoodsShow() {
    if (_hotGoods.length != 0) {
      List<Widget> _hotGoodsList = _hotGoods.map((value) {
        return InkWell(
          onTap: () {
            debugPrint('点击火爆商品');
          },
          child: Container(
            width: ScreenUtil().setWidth(372),
            padding: EdgeInsets.all(5),
            color: Colors.white,
            margin: EdgeInsets.only(bottom: 3),
            child: Column(
              children: <Widget>[
                Image.network(
                  value['image'],
                  width: ScreenUtil().setWidth(370),
                ),
                Text(
                  value['name'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(26),
                    color: Colors.pink,
                  ),
                ),
                Row(
                  children: <Widget>[
                    Text('￥${value['mallPrice']}'),
                    Container(
                      margin: EdgeInsets.only(left: 50),
                      child: Text(
                        '￥${value['price']}',
                        style: TextStyle(
                          color: Colors.black26,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      }).toList();

      return Wrap(
        spacing: 2,
        children: _hotGoodsList,
      );
    } else {
      return Text('');
    }
  }
}

// 首页轮播组件
class SwiperDiy extends StatelessWidget {
  final List swiperDataList;

  SwiperDiy(this.swiperDataList);

  @override
  Widget build(BuildContext context) {
    print('设备的像素密度${ScreenUtil.pixelRatio}');
    print('设备的高 px ${ScreenUtil.screenHeight}');
    print('设备的宽 px ${ScreenUtil.screenWidth}');
    print('设备的高 dp ${ScreenUtil.screenHeightDp}');
    print('设备的宽 dp ${ScreenUtil.screenWidthDp}');
    return Container(
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            "${swiperDataList[index]['image']}",
            fit: BoxFit.fill,
          );
        },
        itemCount: swiperDataList.length,
        pagination: new SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}

// 首页gridView显示种类
class TopNavigator extends StatelessWidget {
  final List navigatorList;

  TopNavigator(this.navigatorList);

  Widget _gridViewItemUI(BuildContext content, item) {
    // 可以添加点击事件
    return InkWell(
      onTap: () {
        debugPrint('点击导航');
      },
      child: Column(
        children: <Widget>[
          Image.network(
            item['image'],
            width: ScreenUtil().setWidth(95),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(10),
          ),
          Text(
            item['mallCategoryName'],
            style: TextStyle(
              fontSize: ScreenUtil().setSp(24),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 截取数据
    if (this.navigatorList.length > 10) {
      this.navigatorList.removeRange(10, this.navigatorList.length);
    }
    return Container(
      height: ScreenUtil().setHeight(320),
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
        crossAxisCount: 5,
        padding: EdgeInsets.all(4.0),
        children: navigatorList.map((item) {
          return _gridViewItemUI(context, item);
        }).toList(),
      ),
    );
  }
}

// 首页广告页面
class AdBanner extends StatelessWidget {
  final String adPicture;

  AdBanner(this.adPicture);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(adPicture),
    );
  }
}

// 首页获取店长电话
class LeaderPhone extends StatelessWidget {
  final String leaderImage;
  final String leaderPhone;

  LeaderPhone(this.leaderImage, this.leaderPhone);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: _launchURL,
        child: Image.network(leaderImage),
      ),
    );
  }

  void _launchURL() async {
    String url = 'tel:' + leaderPhone; // 打开电话
    //String url = 'https://flutter.io'; // 打开网页
    print('url $url');
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'url不能进行访问，异常 $url';
    }
  }
}

// 商品推荐
class Recommend extends StatelessWidget {
  final List recommendList;

  Recommend(this.recommendList);

  // 标题
  Widget _recommedTitle() {
    return Container(
      height: ScreenUtil().setHeight(50),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10, 2, 0, 5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: 0.5,
            color: Colors.black12,
          ),
        ),
      ),
      child: Text(
        '商品推荐',
        style: TextStyle(
          color: Colors.pink,
          fontSize: 14,
        ),
      ),
    );
  }

  // 商品单独项
  Widget _goodsItem(index) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: ScreenUtil().setHeight(330),
        width: ScreenUtil().setWidth(250),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(
              width: 0.5,
              color: Colors.black12,
            ),
          ),
        ),
        child: Column(
          children: <Widget>[
            Image.network(recommendList[index]['image']),
            Text('￥${recommendList[index]['mallPrice']}'),
            Text(
              '￥${recommendList[index]['price']}',
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 横向列表
  Widget _recommendList() {
    return Container(
      height: ScreenUtil().setHeight(330),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: recommendList.length,
          itemBuilder: (context, index) {
            return _goodsItem(index);
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(380),
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          _recommedTitle(),
          _recommendList(),
        ],
      ),
    );
  }
}

// 楼层标题
class FloorTitle extends StatelessWidget {
  final String pictureAddress;

  FloorTitle(this.pictureAddress);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Image.network(pictureAddress),
    );
  }
}

// 楼层商品
class FloorContent extends StatelessWidget {
  final List floorGoodsList;

  FloorContent(this.floorGoodsList);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _firstRow(),
          _otherGoods(),
        ],
      ),
    );
  }

  Widget _otherGoods() {
    return Row(
      children: <Widget>[
        _goodsItems(floorGoodsList[3]),
        _goodsItems(floorGoodsList[4]),
      ],
    );
  }

  Widget _firstRow() {
    return Row(
      children: <Widget>[
        _goodsItems(floorGoodsList[0]),
        Column(
          children: <Widget>[
            _goodsItems(floorGoodsList[1]),
            _goodsItems(floorGoodsList[2]),
          ],
        ),
      ],
    );
  }

  Widget _goodsItems(Map goods) {
    return Container(
      width: ScreenUtil().setWidth(375),
      child: InkWell(
        onTap: () {
          debugPrint("点击");
        },
        child: Image.network(goods['image']),
      ),
    );
  }
}
