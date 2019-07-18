# flutter_shop_mall

A new Flutter application.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.io/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.io/docs/cookbook)

For help getting started with Flutter, view our 
[online documentation](https://flutter.io/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.

## 第02节 入口文件的编写

```
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        title: '百姓生活+',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.pink,
        ),
        home: IndexPage(),
      ),
    );
  }
}

```

## 第03节: 底部导航栏制作

* cupertino_IOS风格介绍

在Flutter里是有两种内置风格的：

1. material.dart风格： Material Design 是由Google推出的全新设计语言，这种设计语言是为手机、平板电脑、台式机和其他平台提供一致，更广泛的外观和感觉。我喜欢称它为纸墨设计。Material Design 风格是一种非常有质感的设计风格，并会提供一些默认的交互动画。
2. cupertino.dart风格：即IOS风格组件，它重现了很多经典的有IOS特性的交互和界面风格，让适用于IOS的人感觉亲切和友好。


* 使用动态StatefulWidget

1. Flutter两种UI风格的区别和如何一起使用。
2. Flutter动态小部件的基本使用-StatefulWidget。
3. 声明一个BottomNavigationBarItem类型的List，并设置文字和图标


# 第04节：打通底部导航栏

> 在pages目录下，我们新建下面四个dart文件。

1. home_page.dart :商城首页UI页面，首页相关的UI我们都会放到这个文件里。
2. category_page.dart: 商城分类UI页面，这个页面会有复杂的动态组件切换。
3. cart_page.dart：商城购物车UI页面，这个页面会包括购物车的全套功能。
4. member_page.dart：商城会员中心页面，这个页面我们会制作会员中心的全部UI效果。

* 声明两个变量，并进行initState初始化：

1. currentIndex： int类型，负责tabBodies的List索引，改变索引就相当于改变了页面。
2. currentPage: 利用currentIndex得到当前选择的页面，并进行呈现出来。

```
@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
      bottomNavigationBar: BottomNavigationBar(
        type:BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items:bottomTabs,
        onTap: (index){
          setState(() {
           currentIndex = index;
           currentPage = tabBodies[currentIndex]; 
          });
        },
      ),
      body:currentPage
    );
  }
```

> type:BottomNavigationBarType.fixed,这个是设置底部tab的样式，它有两种样式fixed和shifting


# 第05节:dio基础_引入和简单的Get请求

### Dart的第三方Http请求库dio

> dio是一个强大的Dart Http请求库，支持Restful API、 FormData、拦截器、请求取消、Cookie管理、文件上传/下载、超时和自定义适配器等。

### 添加dio依赖：

其实Flutter或者说Dart也为我们提供了第三方包管理工具，就和前端经常使用的npm包管理类似。Dart的包管理文件叫做pubspec.yaml，其实它统管整个项目，操作最多的就是第三方插件和静态文件（文件在项目根目录下）,如果我们要引入第三方包需要在dependencies里写明。例如我们要加入dio,代码如下

```
dependencies:
  dio: 2.1.x  #latest version
```

```
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class DemoDio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    getHttp();
    return Center(
      child: Text('商城获取数据'),
    );
  }

  // 异步
  void getHttp() async {
    try {
      Response response;
      response = await Dio().get(
          'https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/dabaojian?name=大胸美女');
      return print(response);
    } catch (e) {
      print(e);
    }
  }
}


{
    "success":true,
    "data":{
        "default":"jspang",
        "_req":{
            "method":"GET",
            "url":"/mock/5c60131a4bed3a6342711498/baixing/dabaojian?name=%E5%A4%A7%E8%83%B8%E7%BE%8E%E5%A5%B3",
            "header":{
                "host":"www.easy-mock.com",
                "x-forwarded-for":"219.142.225.18",
                "x-forwarded-proto":"https",
                "connection":"close",
                "content-length":"0",
                "user-agent":"Dart/2.1 (dart:io)",
                "accept-encoding":"gzip"
            }
        },
        "name":"大胸美女走进了房间，来为你亲情服务"
    }
}

```

**总结：** 本节课学会的知识点：

1. 认识Dio库：dio是一个dart的 http请求通用库，目前也是大陆使用最广泛的库，国人开发，完全开源。
2. flutter的插件包管理：学了引入dio包，并简单的学习了pubspec.yaml的结构和编写注意事项。
3. get请求的编写：我们以一个充满正能量的小Demo讲述了get请求的实现，并成功的返回了结果。


# 第06节:dio基础_Get请求和动态组件协作

### 生成动态组件

可以使用stful的快捷方式，在VSCode里快速生成StatefulWidget的基本结构，我们只需要改一下类的名字就可以了，就会得到如下代码.

### 加入文本框Widget


### Dio的get方法
布局完成后，可以先编写一下远程接口的调用方法，跟上节课的内容类似，不过这里返回值为一个Future,这个对象支持一个等待回掉方法then

```
Future getHttp(String TypeText)async{
    try{
      Response response;
      var data={'name':TypeText};
      response = await Dio().get(
        "https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/dabaojian",
          queryParameters:data
      );
      return response.data;
    }catch(e){
      return print(e);
    }
  }
```

### 得到数据后的处理

当我们写完内容后，要点击按钮，按钮会调用方法，并进行一定的判断。比如判断文本框是不是为空。然后当后端返回数据时，我们用setState方法更新了数据

```
void _choiceAction(){
    print('开始选择你喜欢的类型............');
    if(typeController.text.toString()==''){
      showDialog(
        context: context,
        builder: (context)=>AlertDialog(title:Text('美女类型不能为空'))
      );
    }else{
        getHttp(typeController.text.toString()).then((val){
         setState(() {
           showText=val['data']['name'].toString();
         });
        });
    }

  }
```

eg
```
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final textEditingController = TextEditingController();

  String showText = '您选择的是什么样美女..';

  @override
  void initState() {
    super.initState();
    textEditingController.addListener(() {
      debugPrint('input 美女类型${textEditingController.text.toString()}');
    });
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('美好人间'),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              TextField(
                controller: textEditingController,
                decoration: InputDecoration(
                  labelText: '美女类型',
                  helperText: '请选择你要的类型',
                ),
                autofocus: false,
              ),
              SizedBox(
                height: 10.0,
              ),
              RaisedButton(
                onPressed: () {
                  _choiceActionGirl();
                },
                child: Text('点击你选择'),
              ),
              SizedBox(
                height: 10.0,
              ),
              // 显示你选择的
              Text(
                showText,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _choiceActionGirl() {
    debugPrint('点击选择美女');
    var typeText = textEditingController.text.toString();
    if (typeText == '') {
    } else {
      getHttp(typeText).then((value) {
        setState(() {
          showText = value['data']['name'].toString();
        });
        debugPrint('选择美女是${value['data']['name'].toString()}');
      });
    }
  }

  // 请求返回数据
  Future getHttp(String typeText) async {
    try {
      Response response;
      // 参数
      var param = {'name': typeText};
      response = await Dio().get(
        'https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/dabaojian',
        queryParameters: param,
      );
      return response.data;
    } catch (e) {
      return print(e);
    }
  }
}

```

**总结:** 通过这节课的学习，我们应该掌握如下知识点

1. 对Flutter动态组件的深入了解
2. Future对象的使用
3. 改变状态和界面的setState的方法应用
4. TextField Widget的基本使用

# 第07节:dio基础_POST请求的使用

### EasyMock动态参数的实现

EasyMock在工作中我使用的也是比较多，因为要和后台同步开发，后台编写慢的时候，就需要我们先自己设置（应该说是模拟）需要的数据

```
{
  success: true,
  data: {
    default: "jspang",
    _req: function({
      _req
    }) {
      return _req
    },
    name: function({
      _req,
      Mock
    }) {
      if (_req.query.name) {
        return _req.query.name + '走进了房间，来为你亲情服务';
      } else {
        return '随便来个妹子，服务就好';
      }
    }
  }
}
```

### Dio的POST使用

其实Post的使用非常简单，主题代码并没有什么改动，只是把原来的get换成Post就可以了

```
Future postHttp(String typeText) async {
    try {
      Response response;
      // 参数
      var param = {'name': typeText};
      response = await Dio().post(
        'https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/post_dabaojian',
        queryParameters: param,
      );
      return response.data;
    } catch (e) {
      return print(e);
    }
  }
```

**本节总结:** 这节课程所学到的知识点.

1. SingleChildScrollView： SingleChildScrollView小部件的使用技巧。
2. EasyMock动态参数的实现：我们讲解了一个EasyMock动态参数的实现方法。
3. Dio的Post请求： 学会利用dio的post请求。

# 第08节:dio基础_伪造请求头获取数据

在很多时候，后端为了安全都会有一些请求头的限制，只有请求头对了，才能正确返回数据

### 伪造请求头

新建一个文件夹，起名叫作config，然后在里边新建一个文件httpHeaders.dart,把请求头设置好，请求头可以在浏览器中轻松获得，获得后需要进行改造。

```

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../config/http_headers.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String showText = '获取极客数据..';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('伪造请求头'),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                RaisedButton(
                  child: Text('获取数据'),
                  onPressed: () {
                    _showJiKeContent();
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                // 显示你选择的
                Text(
                  showText,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showJiKeContent() {
    debugPrint('开始请求极客数据');
    postHttp().then((value) {
      setState(() {
        showText = value['data']['nav'].toString();
      });
      debugPrint('得到的数据是 ${value['data']['nav'].toString()}');
    });
  }

  Future postHttp() async {
    try {
      Response response;
      Dio dio = new Dio();
      // 设置请求头
      dio.options.headers = httpHeadersJK;
      // 参数
      response = await dio.post(
        'https://time.geekbang.org/serv/v1/column/newAll',
      );
      debugPrint(response.toString());
      return response.data;
    } catch (e) {
      return print(e);
    }
  }
}

// 请求头

const httpHeadersJK= {
  'Accept': 'application/json, text/plain, */*',
  'Accept-Encoding': 'gzip, deflate, br',
  'Accept-Language': 'zh-CN,zh;q=0.9,en;q=0.8',
  'Connection': 'keep-alive',
  'Content-Type': 'application/json',
  'Cookie': '_ga=GA1.2.1699630603.1550114169; _gid=GA1.2.859327148.1557211766; Hm_lvt_022f847c4e3acd44d4a2481d9187f1e6=1557211767; SERVERID=1fa1f330efedec1559b3abbcb6e30f50|1557211842|1557211764; _gat=1; Hm_lpvt_022f847c4e3acd44d4a2481d9187f1e6=1557211843',
  'Host': 'time.geekbang.org',
  'Origin': 'https://time.geekbang.org',
  'Referer': 'https://time.geekbang.org/',
  'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.131 Safari/537.36',
};

```

### 工具推荐  Fiddler 抓包工具

# 第09节：移动商城数据请求实战（好戏开始）

> [首页获取数据Post http://v.jspang.com:8088/baixing/wxmini/homePageContent](http://v.jspang.com:8088/baixing/wxmini/homePageContent)

```
参数 

dio.options.contentType = ContentType.parse(
      "application/x-www-form-urlencoded",
    );
    var formData = {
      'lon': '115.02932',
      'lat': '35.76189',
    };
    
```

### 建立网络请求


* 在/lib/config文件夹下，建立一个service_url.dart文件,网络配置

```
const serviceUrl = 'http://v.jspang.com:8088/baixing/';
const servicePath = {
  'homePageContent':serviceUrl + 'wxmini/homePageContent', // 商店首页信息
  'homePageBelowConten':serviceUrl + 'wxmini/homePageBelowConten', // 首页热卖商品
  'getCategory':serviceUrl + 'wxmini/getCategory',  // 商品类别信息
  'getMallGoods':serviceUrl + 'wxmini/getMallGoods',  // 商品分类页面商品列表
  'getGoodDetailById':serviceUrl + 'wxmini/getGoodDetailById',  // 商品详情
};
```

* 在/lib/service文件夹下，建立一个service_method.dart文件，网络请求

```
import "package:dio/dio.dart";
import 'dart:async';
import 'dart:io';
import '../config/service_url.dart';
// 获取首页主体内容

Future getHomePageContent() async {
  try {
    print('开始获取首页数据....');
    Response response;
    Dio dio = new Dio();
    // 表单
    dio.options.contentType = ContentType.parse(
      "application/x-www-form-urlencoded",
    );
    var formData = {
      'lon': '115.02932',
      'lat': '35.76189',
    };
    response = await dio.post(servicePath['homePageContent'], data: formData);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口出现异常。');
    }
  } catch (e) {
    return print('Error: =======>$e');
  }
}


```

**本节总结:** 

1. 和后端接口对接的一些实战技巧，这些技巧可以大大增加项目的灵活性和减少维护成本。
2. 真实项目接口数据的获取，为我们的项目提供后端数据支持。

# 第10节:使用FlutterSwiper制作轮播效果


### 引入flutter_swiper插件

> flutter最强大的siwiper, 多种布局方式，无限轮播，Android和IOS双端适配.

[Flutter_swiper的GitHub地址](https://github.com/best-flutter/flutter_swiper)

新写了一个SwiperDiy的类，当然这个类用静态类就完全可以了,这个类是需要接受一个List参数的

```

// 首页轮播组件编写
class SwiperDiy extends StatelessWidget {
  final List swiperDataList;
  SwiperDiy({Key key,this.swiperDataList}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 333.0,
      child: Swiper(
        itemBuilder: (BuildContext context,int index){
          return Image.network("${swiperDataList[index]['image']}",fit:BoxFit.fill);
        },
        itemCount: swiperDataList.length,
        pagination: new SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}
```

### FutureBuilder Widget

这是一个Flutter内置的组件，是用来等待异步请求的。同时拿掉initState() 的请求

```
import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert'; // 导入json

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String homePageContent = '正在获取数据';

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
            return Column(
              children: <Widget>[
                SwiperDiy(swiperList),
              ],
            );
          } else {
            // 没有数据
            return Center(
              child: Text('加载中....'),
            );
          }
        },
      ),
    );
  }
}
```

**课程总结：**

1. flutter_Swiper:学习了flutter_swiper组件的简单使用方法，当然你还可以自己学习。
2. FutureBuilder: 这个布局可以很好的解决异步渲染的问,实战中我们讲了很多使用的技巧，注意反复学习。
3. 自定义类接受参数：我们复习了类接受参数的方法。学会了这个技巧就可以把我们的页面分成很多份，让很多人来进行编写，最后再整合到一起。


# 第11节：首页_屏幕适配方案和制作

移动端的屏幕大小不一，IOS端就有很多种，Android端更是多如牛毛。屏幕适配
### flutter_ScreenUtil插件简介

插件会让你先设置一个UI稿的尺寸，他会根据这个尺寸，根据不同屏幕进行缩放，能满足大部分屏幕场景。
[flutter_ScreenUtil](https://github.com/OpenFlutter/flutter_screenutil)


```
pubspec.yaml

dependencies:
     flutter_screenutil: ^0.5.1

Iphone6的，预先设置尺寸
ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);

```

### 这时候我们使用的尺寸是px.

1. 根据屏幕宽度适配：width:ScreenUtil().setWidth(540);
2. 根据屏幕高度适配：height:ScreenUtil().setHeight(200);
3. 适配字体大小：fontSize：ScreenUtil().setSp(28,false);


# 第12节:首页导航区域编写


### 导航单元素的编写 和 GridView制作导航
```

class TopNavigator extends StatelessWidget {
  final List navigatorList;

  TopNavigator(this.navigatorList);

  Widget _gridViewItemUI(BuildContext content, item) {
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


```


# 第13节：ADBanner组件的编写


```
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

```


### flutter upgrade 新版升级


# 第14节：首页_拨打电话操作


### url_launcher的简介

[url_launcher](https://github.com/flutter/plugins/tree/master/packages/url_launcher)

```
url_launcher: ^5.0.2


import 'package:url_launcher/url_launcher.dart';

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
```



```
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

```


# 第15节：商品推荐区域制作

### 超出边界的处理方法

SingleChildScrollView

```
SingleChildScrollView(
   child: Column(
        children: <Widget>[
             SwiperDiy(swiperList),
             TopNavigator(navigatorList),
             AdBanner(adPicture),
             LeaderPhone(leaderImage, leaderPhone),
             Recommend(recommendList),
        ],
   ),
);
```
### 推荐标题内部方法的编写

```
// 标题
  Widget _recommedTitle() {
    return Container(
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
          fontSize: 12,
        ),
      ),
    );
  }
```


### 推荐商品单独项编写

InkWell 组件用于点击事件

```
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

```

### 横向列表组件的编写

```
 // 横向列表
  Widget _recommendList() {
    return Container(
      height: ScreenUtil().setHeight(330),
      margin: EdgeInsets.only(top: 10),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: recommendList.length,
          itemBuilder: (context, index) {
            return _goodsItem(index);
          }),
    );
  }
```

**本节总结**

1. 这节主要制作了商品推荐区域的制作，知识点可能都是我们以前学过的，但是要重点练习一下如何练习对组件的拆分能力。
2. 当你掌握了这种能力后，你会发现Flutter真的很好用，我们只需要Dart这一种语言，就可以编写页面和前台的业务逻辑


# 第16节：补充_切换后页面状态的保持

###  AutomaticKeepAliveClientMixin

AutomaticKeepAliveClientMixin这个Mixin就是Flutter为了保持页面设置的。哪个页面需要保持页面状态，就在这个页面进行混入。

> 不过使用使用这个Mixin是有几个先决条件的：

1. 使用的页面必须是StatefulWidget,如果是StatelessWidget是没办法办法使用的。
2. 其实只有两个前置组件才能保持页面状态：PageView和IndexedStack。
3. 重写wantKeepAlive方法，如果不重写也是实现不了的。

### 修改index_page.dart

IndexedStack包裹在tabBodies外边

```
index_page.dart

final List<Widget> tabBodies = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage(),
  ];
  
 // 保持页面状态
body: IndexedStack(
        children: tabBodies,
        index: _currentIndex,
      ),  
```

###  加入Mixin保持页面状态

```

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {'
    
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    debugPrint('初始化页面');
  }
  
  
}
```

# 第17节：首页_楼层区域的编写

* 楼层标题

```

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

```

* 楼层商品
```

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

```

## 第18节：火爆专区接口整理

> [获取首页火爆商品Post http://v.jspang.com:8088/baixing/wxmini/homePageBelowConten](http://v.jspang.com:8088/baixing/wxmini/homePageBelowConten)

```
service_url.dart  定义接口

const serviceUrl = 'http://v.jspang.com:8088/baixing/';
const servicePath = {
  'homePageContent':serviceUrl + 'wxmini/homePageContent', // 商店首页信息
  'homePageBelowConten':serviceUrl + 'wxmini/homePageBelowConten', // 首页热卖商品
  'getCategory':serviceUrl + 'wxmini/getCategory',  // 商品类别信息
  'getMallGoods':serviceUrl + 'wxmini/getMallGoods',  // 商品分类页面商品列表
  'getGoodDetailById':serviceUrl + 'wxmini/getGoodDetailById',  // 商品详情
};

```

```
service_method.dart

import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../config/service_url.dart';

// 获取首页主体内容
Future getHomePageContent() {
  print('开始获取首页数据....');
  var formData = {
    'lon': '115.02932',
    'lat': '35.76189',
  };
  return request('homePageContent', formData);
}

// 获取火爆专区的商品
Future getHomePageHotContent(page) {
  print('开始火爆专区的数据....');
  return request('homePageBelowConten', page);
}


// 方法
Future request(url, formData) async {
  try {
    print('开始获取数据....');
    Response response;
    Dio dio = new Dio();
    // 表单
    dio.options.contentType = ContentType.parse(
      "application/x-www-form-urlencoded",
    );
    if (formData == null) {
      response = await dio.post(servicePath[url]);
    } else {
      response = await dio.post(servicePath[url], data: formData);
    }
    if (response.statusCode == 200) {
      print('数据返回 ${response.data}');
      return response.data;
    } else {
      throw Exception('后端接口出现异常。');
    }
  } catch (e) {
    return print('Error: =======>$e');
  }
}


```

## 第19节：火爆专区界面布局

### Dart中可选参数的设置

我们的参数使用了一个必选参数，其实我们可以使用一个可选参数。Dart中的可选参数，直接使用“{}”(大括号)就可以了。
可选参数在调用的时候必须使用paramName:value的形式。

```
service_method.dart

import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../config/service_url.dart';

// 获取首页主体内容
Future getHomePageContent() {
  print('开始获取首页数据....');
  var formData = {
    'lon': '115.02932',
    'lat': '35.76189',
  };
  return request('homePageContent',formData:formData);
}

// 获取火爆专区的商品
Future getHomePageHotContent(page) {
  print('开始火爆专区的数据....');
  var formData= {
    'page':page,
  };
  return request('homePageBelowConten', formData:formData);
}


// 方法
Future request(url, {formData}) async {
  try {
    print('开始获取数据....');
    Response response;
    Dio dio = new Dio();
    // 表单
    dio.options.contentType = ContentType.parse(
      "application/x-www-form-urlencoded",
    );
    if (formData == null) {
      response = await dio.post(servicePath[url]);
    } else {
      response = await dio.post(servicePath[url], data: formData);
    }
    if (response.statusCode == 200) {
      print('数据返回 ${response.data}');
      return response.data;
    } else {
      throw Exception('后端接口出现异常。');
    }
  } catch (e) {
    return print('Error: =======>$e');
  }
}

```

### 火爆专区标题编写

火爆专区，我们先采用State的原始方法，来进行制作，因为这也是很多小伙伴要求的，所以我们主要讲解一下StatefulWidget的使用。
下次我们写分类页面的时候会用Redux的方法，以为StatefulWidget的方法会让程序耦合性很强，不利于以后程序的维护。

下面展示部分代码，没有的可以看以前的写的。主要是火爆专区的

```

import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert'; // 导入json
import 'package:flutter_screenutil/flutter_screenutil.dart'; // 适配
import 'package:url_launcher/url_launcher.dart';


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

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    debugPrint('初始化页面');
    _getHotGoods();
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

            return SingleChildScrollView(
              child: Column(
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

  // 获取火爆专区数据
  void _getHotGoods() {
    getHomePageHotContent(page).then((value) {
      debugPrint(value);
      var data = json.decode(value.toString());
      List<Map> newGoodList = (data['data'] as List).cast();
      this.setState(() {
        _hotGoods.addAll(newGoodList);
        page++;
      });
    });
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
                  width: ScreenUtil().setWidth(375),
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

```

## 第20节：火爆专区界面上拉加载

### flutter_easyrefresh简介

EasyRefresh中集成了多种风格的Header和Footer，但是它并没有局限性，你可以很轻松的自定义。使用Flutter强大的动画，甚至随便一个简单的控件也可以完成。EasyRefresh的目标是为Flutter打造一个强大，稳定，成熟的下拉刷新框架。

[flutter_easyrefresh](https://github.com/xuelongqy/flutter_easyrefresh)

如下: 使用 flutter_easyrefresh

```
dependencies:
  flutter_easyrefresh: ^1.2.7


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


```

## 第21节：分类页面 类别信息接口调试

> [获取分类Post http://v.jspang.com:8088/baixing/wxmini/getCategory]

### 禁止滑动的设置 

首页导航区域采用了GridView，这个和我们的ListView上拉加载是冲突的，我们的组件没有智能到为我们辨认，所以我们可以直接禁用GridView的滚动。

```
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
        // 禁止回弹
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 5,
        padding: EdgeInsets.all(4.0),
        children: navigatorList.map((item) {
          return _gridViewItemUI(context, item);
        }).toList(),
      ),
    );
  }
}
```

### 分类接口文件编写

```

void _getCategory() async {
    await getCategoryContent().then((value) {
      debugPrint(value);
      var data = json.decode(value.toString());
    });
  }
  
  // 获取分类页面的数据
  Future getCategoryContent() {
    print('开始获取分类页面数据....');
    return request('getCategory');
  }
```


## 第22节：Json解析和复杂数据模型转换

### model 类


>  [获取分类Post http://v.jspang.com:8088/baixing/wxmini/getCategory](http://v.jspang.com:8088/baixing/wxmini/getCategory)

```
CategoryModel.dart

class CategoryModel {
  String mallCategoryId;
  String mallCategoryName;
  List<dynamic> bxMallSubDto;
  Null comments;
  String image;

  CategoryModel(
      {this.mallCategoryId,
      this.mallCategoryName,
      this.bxMallSubDto,
      this.image,
      this.comments});

  factory CategoryModel.fromJson(dynamic json) {
    return CategoryModel(
        mallCategoryId: json['mallCategoryId'],
        mallCategoryName: json['mallCategoryName'],
        bxMallSubDto: json['bxMallSubDto'],
        comments: json['comments'],
        image: json['image']);
  }
}

CategoryListModel.dart

import 'CategoryModel.dart';

class CategoryListModel {
  List<CategoryModel> categoryListModel;

  CategoryListModel(this.categoryListModel);

  factory CategoryListModel.fromJson(List json) {
    return CategoryListModel(
        json.map((index) => CategoryModel.fromJson(index)).toList());
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_shop_mall/service/service_method.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // 适配
import '../model/CategoryListModel.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    _getCategory();
    return Container(
      child: Center(
        child: Text('分类页面'),
      ),
    );
  }

  void _getCategory() async {
    await getCategoryContent().then((value) {
      debugPrint(value);
      var data = json.decode(value.toString());
      var categoryListModel = CategoryListModel.fromJson(data['data']);
      categoryListModel.categoryListModel
          .forEach((item) => {debugPrint(item.mallCategoryName)});
    });
  }
}


```


### 工具

> [https://javiercbk.github.io/json_to_dart/](https://javiercbk.github.io/json_to_dart/)

```

CategoryConvert.dart

class CategoryConvert {
  String code;
  String message;
  List<CategoryConvertData> data;

  CategoryConvert({this.code, this.message, this.data});

  CategoryConvert.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<CategoryConvertData>();
      json['data'].forEach((v) {
        data.add(new CategoryConvertData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryConvertData {
  String mallCategoryId;
  String mallCategoryName;
  List<BxMallSubDto> bxMallSubDto;
  Null comments;
  String image;

  CategoryConvertData(
      {this.mallCategoryId,
      this.mallCategoryName,
      this.bxMallSubDto,
      this.comments,
      this.image});

  CategoryConvertData.fromJson(Map<String, dynamic> json) {
    mallCategoryId = json['mallCategoryId'];
    mallCategoryName = json['mallCategoryName'];
    if (json['bxMallSubDto'] != null) {
      bxMallSubDto = new List<BxMallSubDto>();
      json['bxMallSubDto'].forEach((v) {
        bxMallSubDto.add(new BxMallSubDto.fromJson(v));
      });
    }
    comments = json['comments'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mallCategoryId'] = this.mallCategoryId;
    data['mallCategoryName'] = this.mallCategoryName;
    if (this.bxMallSubDto != null) {
      data['bxMallSubDto'] = this.bxMallSubDto.map((v) => v.toJson()).toList();
    }
    data['comments'] = this.comments;
    data['image'] = this.image;
    return data;
  }
}

class BxMallSubDto {
  String mallSubId;
  String mallCategoryId;
  String mallSubName;
  String comments;

  BxMallSubDto(
      {this.mallSubId, this.mallCategoryId, this.mallSubName, this.comments});

  BxMallSubDto.fromJson(Map<String, dynamic> json) {
    mallSubId = json['mallSubId'];
    mallCategoryId = json['mallCategoryId'];
    mallSubName = json['mallSubName'];
    comments = json['comments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mallSubId'] = this.mallSubId;
    data['mallCategoryId'] = this.mallCategoryId;
    data['mallSubName'] = this.mallSubName;
    data['comments'] = this.comments;
    return data;
  }
}

// 调用

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
    _getCategory();
    return Container(
      child: Center(
        child: Text('分类页面'),
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
      categoryConvertModel.data
          .forEach((item) => {debugPrint(item.mallCategoryName)});
    });
  }
}



```


## 第23节：左侧类别导航制作


### 分类左侧布局

```

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

```


## 第24节：Provide状态管理基础


项目的商品类别页面将大量的出现类和类中间的状态变化，这就需要状态管理。现在Flutter的状态管理方案很多，redux、bloc、state、Provide。


1. Scoped Model : 最早的状态管理方案，我刚学Flutter的时候就使用的这个，虽然还有公司在用，但是大部分已经选用其它方案了。
2. Redux：现在国内用的最多，因为咸鱼团队一直在用，还出了自己fish redux。
3. bloc：比Redux简单，而且好用，特别是一个页面里的状态管理，用起来很爽。
4. state：我们首页里已经简单接触，缺点是耦合太强，如果是大型应用，管理起来非常混乱。
5. Provide：是在Google的Github下的一个项目，刚出现不久，所以可以推测他是Google的亲儿子，用起来也是相当的爽。


```
dependencies:
  provide: ^1.0.2
  

Counter.dart

import 'package:flutter/material.dart';

class Counter with ChangeNotifier {
  int _value;

  int get value => _value;

  Counter(this._value);

  void increment() {
    _value++;
    notifyListeners();
  }
}


main.dart

import 'package:flutter/material.dart';
import './pages/index_page.dart';
import 'package:provide/provide.dart';
import 'provide/Counter.dart';

void main() {
  var counter = Counter(0);
  var providers = Providers()..provide(Provider<Counter>.value(counter));
  runApp(ProviderNode(
    child: MyApp(),
    providers: providers,
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        title: '百姓生活+',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.pink,
        ),
        home: IndexPage(),
      ),
    );
  }
}

cart_page.dart

import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/Counter.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 200),
          child: Column(
            children: <Widget>[
              NumberWidget(),
              AddButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class NumberWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Provide<Counter>(builder: (context, child, counter) {
        return Text(
          '${counter.value}',
          style: Theme.of(context).textTheme.display1,
        );
      }),
    );
  }
}

class AddButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: RaisedButton(
        onPressed: () {
          Provide.value<Counter>(context).increment();
        },
        child: Text('增加'),
      ),
    );
  }
}


member_page.dart

import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/Counter.dart';

class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('会员中心'),
      ),
      body: Center(
        child: Provide<Counter>(builder: (context, child, counter) {
          return Text(
            '${counter.value}',
            style: Theme.of(context).textTheme.display1,
          );
        }),
      ),
    );
  }
}



```


## 第25节 列表页_使用Provide控制子类-1


分类右侧种类导航


```


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
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RightCategoryNav extends StatefulWidget {
  @override
  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<RightCategoryNav> {
  List<String> listWire = [
    '全部',
    '名酒',
    '宝丰',
    '红星二锅头',
    '北京二锅头',
    '五粮液',
    '汾酒',
    '茅台'
  ];

  @override
  Widget build(BuildContext context) {
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
        itemBuilder: (context, index) => _rightNavItemInkWell(listWire[index]),
        itemCount: listWire.length,
      ),
    );
  }

  Widget _rightNavItemInkWell(item) {
    return InkWell(
      onTap: () {
        debugPrint('点击');
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
        child: Text(
          item,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(28),
          ),
        ),
      ),
    );
  }
}


```

## 第26节 列表页_使用Provide控制子类-2

### 交互效果的设置
高亮显示，使用最简单的setState来实现了。 这个变化主要在_leftNavInkWell，所以操作也基本在这个里边。

1. 先声明一个变量，用于控制是否高亮显示bool isClick=false;。
2. 让_leftNavInkWell，变量是ListView传递过来的Widget _leftNavInkWell(int index)
3. 声明一个全局的变量var listIndex = 0; //索引
4. 对比index和listIndex  Click=(index==listIndex)?true:false;.
5. 修改为动态显示背景颜色color: isClick?Colors.black26:Colors.white,

```
// 状态管理
import 'package:flutter/material.dart';
import '../model/CategoryConvert.dart';

class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> bxMallSubDtoList = [];

  // 获取右边上层分类
  getChildListCategory(List<BxMallSubDto> bxMallSubDto) {
    bxMallSubDtoList = bxMallSubDto;
    notifyListeners();
  }
}

main.dart

void main() {
  var counter = Counter(0);
  var childCategory = ChildCategory();
  var providers = Providers()
    ..provide(Provider<Counter>.value(counter))
    ..provide(Provider<ChildCategory>.value(childCategory));
  runApp(ProviderNode(
    child: MyApp(),
    providers: providers,
  ));
}


import 'package:flutter/material.dart';
import 'package:flutter_shop_mall/provide/child_category.dart';
import 'package:flutter_shop_mall/service/service_method.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // 适配
import '../model/CategoryListModel.dart';
import '../model/CategoryConvert.dart';
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
          color: isClick ? Colors.black26 : Colors.white,
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


```

## 第27节 列表页_现有Bug修复和完善

### 添加全部

```
import 'package:flutter/material.dart';
import '../model/CategoryConvert.dart';

class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> bxMallSubDtoList = [];

  // 获取右边上层分类
  getChildListCategory(List<BxMallSubDto> bxMallSubDto) {
    BxMallSubDto addmallsubdto = BxMallSubDto();
    addmallsubdto.mallSubId = '00';
    addmallsubdto.mallSubName = '全部';
    addmallsubdto.mallCategoryId = '00';
    addmallsubdto.comments = 'null';
    bxMallSubDtoList=[addmallsubdto];
    bxMallSubDtoList.addAll(bxMallSubDto);
    notifyListeners();
  }
}


LeftCategoryNav.dart

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


```

## 第28节 列表页_商品列表后台接口调试

```

Future getCategoryGoods(categoryId, categorySubId, page) {
  print('开始获取分类页面商品数据....');
  var formData = {
    'categoryId': categoryId,
    'categorySubId': categorySubId,
    'page': page
  };
  return request('getMallGoods', formData: formData);
}

// 方法
Future request(url, {formData}) async {
  try {
    print('开始获取数据....');
    Response response;
    Dio dio = new Dio();
    // 表单
    dio.options.contentType = ContentType.parse(
      "application/x-www-form-urlencoded",
    );
    print('url ${servicePath[url]}');
    if (formData == null) {
      response = await dio.post(servicePath[url]);
    } else {
      response = await dio.post(servicePath[url], data: formData);
    }
    if (response.statusCode == 200) {
      print('数据返回 ${response.data}');
      return response.data;
    } else {
      throw Exception('后端接口出现异常。');
    }
  } catch (e) {
    return print('Error: =======>$e');
  }
}


// 获取分类商品列表 可以上拉加载

class CategoryGoodsList extends StatefulWidget {
  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {
  @override
  void initState() {
    _getGoodsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('商品显示'),
    );
  }

  void _getGoodsList() async {
    await getCategoryGoods('4', "", 1).then((value) {
      var data = json.decode(value.toString());
      debugPrint('分类：$data');
    });
  }
}

```

## 第28节 商品列表数据模型建立

```

// 数据模型建立

 void _getGoodsList() async {
    await getCategoryGoods('4', "", 1).then((value) {
      var data = json.decode(value.toString());
      debugPrint('分类：$data');
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);

      // 数据打印
      goodsList.data
          .forEach((item) => {debugPrint(item.goodsName)});

    });
  }
  
  

class CategoryGoodsListModel {
  String code;
  String message;
  List<CategoryGoodsListModelData> data;

  CategoryGoodsListModel({this.code, this.message, this.data});

  CategoryGoodsListModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<CategoryGoodsListModelData>();
      json['data'].forEach((v) {
        data.add(new CategoryGoodsListModelData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryGoodsListModelData {
  String image;
  double oriPrice;
  double presentPrice;
  String goodsName;
  String goodsId;

  CategoryGoodsListModelData(
      {this.image,
      this.oriPrice,
      this.presentPrice,
      this.goodsName,
      this.goodsId});

  CategoryGoodsListModelData.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    oriPrice = json['oriPrice'];
    presentPrice = json['presentPrice'];
    goodsName = json['goodsName'];
    goodsId = json['goodsId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['oriPrice'] = this.oriPrice;
    data['presentPrice'] = this.presentPrice;
    data['goodsName'] = this.goodsName;
    data['goodsId'] = this.goodsId;
    return data;
  }
}

```

## 第30节：列表页_商品列表UI布局

```

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


```

## 第31节: 列表页_列表切换交互制作


### 制作商品列表的Provide
```
import 'package:flutter/material.dart';
import 'package:flutter_shop_mall/model/categoryGoodsListModel.dart';

class CategoryListProvide with ChangeNotifier {
  List<CategoryGoodsListModelData> categoryGoodsListModel = [];

  getCateGoryGoodsList(List<CategoryGoodsListModelData> list) {
    categoryGoodsListModel = list;
    notifyListeners();
  }
}

```

### 将状态放入顶层

```
import 'package:flutter/material.dart';
import './pages/index_page.dart';
import 'package:provide/provide.dart';
import 'provide/counter_provide.dart';
import 'provide/child_category_provide.dart';
import 'provide/category_list_provide.dart';

void main() {
  var counter = CounterProvide(0);
  var childCategory = ChildCategoryProvide();
  var categoryGoodsListProvide = CategoryListProvide();
  var providers = Providers()
    ..provide(Provider<CounterProvide>.value(counter))
    ..provide(Provider<ChildCategoryProvide>.value(childCategory))
    ..provide(Provider.function((context) => categoryGoodsListProvide));
  runApp(ProviderNode(
    child: MyApp(),
    providers: providers,
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        title: '百姓生活+',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.pink,
        ),
        home: IndexPage(),
      ),
    );
  }
}
```

### 修改category_page.dart页面

> 将商品列表的接口放入左侧导航栏的组件中进行请求，利用状态管理

```

import 'package:flutter/material.dart';
import 'package:flutter_shop_mall/provide/category_list_provide.dart';
import 'package:flutter_shop_mall/provide/child_category_provide.dart';
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
        Provide.value<ChildCategoryProvide>(context)
            .getChildListCategory(childList);
        // 点击之后获取当前分类下的数据
        var mallCategoryId = categoryConvertListData[index].mallCategoryId;
        _getGoodsList(categoryId: mallCategoryId);
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

  // 获取左边导航栏数据
  void _getCategory() async {
    await getCategoryContent().then((value) {
      var data = json.decode(value.toString());
      debugPrint('左边数据----->$data');
//      var categoryListModel = CategoryListModel.fromJson(data['data']);
//      categoryListModel.categoryListModel
//          .forEach((item) => {debugPrint(item.mallCategoryName)});

      var categoryConvertModel = CategoryConvert.fromJson(data);
      setState(() {
        categoryConvertListData = categoryConvertModel.data;
      });

      // 数据打印
      categoryConvertListData.forEach(
          (item) => {debugPrint('左边列表数据----> ${item.mallCategoryName}')});

      // 默认选中第一个时，显示对应的二级分类
      Provide.value<ChildCategoryProvide>(context)
          .getChildListCategory(categoryConvertListData[0].bxMallSubDto);
      // 获取第一个选中的数据的数据
      _getGoodsList(categoryId: categoryConvertListData[0].mallCategoryId);
    });
  }

  // 获取右边分类商品数据
  void _getGoodsList({String categoryId}) async {
    await getCategoryGoods(categoryId == null ? '4' : categoryId, "", 1)
        .then((value) {
      var data = json.decode(value.toString());
      debugPrint('分类：$data');
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      Provide.value<CategoryListProvide>(context)
          .getCateGoryGoodsList(goodsList.data);
      // 数据打印
      goodsList.data
          .forEach((item) => {debugPrint('右边分类列表数据---->${item.goodsName}')});
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
    return Provide<ChildCategoryProvide>(
        builder: (context, child, childCategory) {
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
  Widget build(BuildContext context) {
    return Provide<CategoryListProvide>(
      builder: (context, child, categoryListProvide) {
        categoryGoodsList = categoryListProvide.categoryGoodsListModel;
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
      },
    );
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

```

## 第32节：列表页_小类高亮交互效果制作

### Expanded Widget的使用
    
Expanded Widget 是让子Widget有伸缩能力的小部件，它继承自Flexible,用法也差不多。 防止溢出

```

//商品列表 可以上拉加载
class CategoryGoodsList extends StatefulWidget {
  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {
  List<CategoryGoodsListModelData> categoryGoodsList = [];

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryListProvide>(
      builder: (context, child, categoryListProvide) {
        categoryGoodsList = categoryListProvide.categoryGoodsListModel;
        return Expanded(
          child: Container(
            width: ScreenUtil().setWidth(570),
            child: ListView.builder(
              itemBuilder: (context, index) {
                return _goodsItemInkWell(index);
              },
              itemCount: categoryGoodsList.length,
            ),
          ),
        );
      },
    );
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


```


### 添加分类二级分类index

```
import 'package:flutter/material.dart';
import '../model/categoryConvert.dart';

class ChildCategoryProvide with ChangeNotifier {
  List<BxMallSubDto> bxMallSubDtoList = [];
  int childIndex = 0;

  // 获取右边上层分类
  getChildListCategory(List<BxMallSubDto> bxMallSubDto) {
    childIndex = 0;
    BxMallSubDto addmallsubdto = BxMallSubDto();
    addmallsubdto.mallSubId = '00';
    addmallsubdto.mallSubName = '全部';
    addmallsubdto.mallCategoryId = '00';
    addmallsubdto.comments = 'null';
    bxMallSubDtoList = [addmallsubdto];
    bxMallSubDtoList.addAll(bxMallSubDto);
    notifyListeners();
  }

  // 更新当前选择的二级分类
  void getCategoryChildIndex(int index) {
    childIndex = index;
    notifyListeners();
  }
}

```

### 修改二级分类字体颜色和逻辑
```
category_page.dart

// 二级导航
class RightCategoryNav extends StatefulWidget {
  @override
  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<RightCategoryNav> {
  @override
  Widget build(BuildContext context) {
    // 状态管理
    return Provide<ChildCategoryProvide>(
        builder: (context, child, childCategory) {
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
          itemBuilder: (context, index) => _rightNavItemInkWell(
              index, childCategory.bxMallSubDtoList[index]),
          itemCount: childCategory.bxMallSubDtoList.length,
        ),
      );
    });
  }

  Widget _rightNavItemInkWell(int index, BxMallSubDto item) {
    bool isClick = false;
    isClick = (index == Provide.value<ChildCategoryProvide>(context).childIndex)
        ? true
        : false;
    return InkWell(
      onTap: () {
        debugPrint('点击更新分类商品数据');
        Provide.value<ChildCategoryProvide>(context)
            .getCategoryChildIndex(index);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
        child: Text(
          item.mallSubName,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(28),
            color: isClick ? Colors.pink : Colors.black,
          ),
        ),
      ),
    );
  }
}

```

## 第33节: 列表页_子类和商品列表切换


```
category_page.dart

// 二级导航
class RightCategoryNav extends StatefulWidget {
  @override
  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<RightCategoryNav> {
  @override
  Widget build(BuildContext context) {
    // 状态管理
    return Provide<ChildCategoryProvide>(
        builder: (context, child, childCategory) {
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
          itemBuilder: (context, index) => _rightNavItemInkWell(
              index, childCategory.bxMallSubDtoList[index]),
          itemCount: childCategory.bxMallSubDtoList.length,
        ),
      );
    });
  }

  Widget _rightNavItemInkWell(int index, BxMallSubDto item) {
    bool isClick = false;
    isClick = (index == Provide.value<ChildCategoryProvide>(context).childIndex)
        ? true
        : false;
    return InkWell(
      onTap: () {
        debugPrint('点击更新分类商品数据');
        Provide.value<ChildCategoryProvide>(context)
            .getCategoryChildIndex(index);

        //获取当前分类下子类的数据
        _getGoodsList(item.mallSubId);

      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
        child: Text(
          item.mallSubName,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(28),
            color: isClick ? Colors.pink : Colors.black,
          ),
        ),
      ),
    );
  }

  // 获取二级分类当前分类的商品数据
  void _getGoodsList(String categorySubId) async {
    await getCategoryGoods(
      Provide.value<ChildCategoryProvide>(context).currentCategoryId,
      categorySubId,
      1,
    ).then((value) {
      var data = json.decode(value.toString());
      debugPrint('分类：$data');
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      Provide.value<CategoryListProvide>(context)
          .getCateGoryGoodsList(goodsList.data);
    });
  }
}


import 'package:flutter/material.dart';
import '../model/categoryConvert.dart';

class ChildCategoryProvide with ChangeNotifier {
  List<BxMallSubDto> bxMallSubDtoList = [];
  int childIndex = 0;
  // 提供当前左边导航的id
  String currentCategoryId;

  // 获取右边上层分类
  getChildListCategory(List<BxMallSubDto> bxMallSubDto,String categoryId) {
    childIndex = 0;
    currentCategoryId = categoryId;
    BxMallSubDto addmallsubdto = BxMallSubDto();
    addmallsubdto.mallSubId = '00';
    addmallsubdto.mallSubName = '全部';
    addmallsubdto.mallCategoryId = '00';
    addmallsubdto.comments = 'null';
    bxMallSubDtoList = [addmallsubdto];
    bxMallSubDtoList.addAll(bxMallSubDto);
    notifyListeners();
  }

  // 更新当前选择的二级分类
  void getCategoryChildIndex(int index) {
    childIndex = index;
    notifyListeners();
  }
}

```

## 第34节：列表页_小Bug的修复

```
// 添加二级分类的状态管理id

import 'package:flutter/material.dart';
import '../model/categoryConvert.dart';

class ChildCategoryProvide with ChangeNotifier {
  List<BxMallSubDto> bxMallSubDtoList = [];
  int childIndex = 0;

  // 提供当前左边导航的id
  String currentCategoryId = '4'; // 默认给4 这是根据数据
  // 二级分类id
  String currentCategorySubId = '';

  // 获取右边上层分类
  getChildListCategory(List<BxMallSubDto> bxMallSubDto, String categoryId) {
    childIndex = 0;
    currentCategoryId = categoryId;
    BxMallSubDto addmallsubdto = BxMallSubDto();
    addmallsubdto.mallSubId = '00';
    addmallsubdto.mallSubName = '全部';
    addmallsubdto.mallCategoryId = '00';
    addmallsubdto.comments = 'null';
    bxMallSubDtoList = [addmallsubdto];
    bxMallSubDtoList.addAll(bxMallSubDto);
    notifyListeners();
  }

  // 更新当前选择的二级分类
  void getCategoryChildIndex(int index, String categorySubId) {
    childIndex = index;
    currentCategorySubId = categorySubId;
    notifyListeners();
  }
}


// 二级导航 分类下数据的状态处理
class RightCategoryNav extends StatefulWidget {
  @override
  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<RightCategoryNav> {
  @override
  Widget build(BuildContext context) {
    // 状态管理
    return Provide<ChildCategoryProvide>(
        builder: (context, child, childCategory) {
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
          itemBuilder: (context, index) => _rightNavItemInkWell(
              index, childCategory.bxMallSubDtoList[index]),
          itemCount: childCategory.bxMallSubDtoList.length,
        ),
      );
    });
  }

  Widget _rightNavItemInkWell(int index, BxMallSubDto item) {
    bool isClick = false;
    isClick = (index == Provide.value<ChildCategoryProvide>(context).childIndex)
        ? true
        : false;
    return InkWell(
      onTap: () {
        debugPrint('点击更新分类商品数据');
        var mallSubId = item.mallSubId;
        Provide.value<ChildCategoryProvide>(context)
            .getCategoryChildIndex(index, mallSubId);

        //获取当前分类下子类的数据
        _getGoodsList(mallSubId);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
        child: Text(
          item.mallSubName,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(28),
            color: isClick ? Colors.pink : Colors.black,
          ),
        ),
      ),
    );
  }

  // 获取二级分类当前分类的商品数据
  void _getGoodsList(String categorySubId) async {
    await getCategoryGoods(
      Provide.value<ChildCategoryProvide>(context).currentCategoryId,
      categorySubId,
      1,
    ).then((value) {
      var data = json.decode(value.toString());
      debugPrint('分类：$data');
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      var subGoodsList = goodsList.data;
      if (subGoodsList == null) {
        Provide.value<CategoryListProvide>(context).getCateGoryGoodsList([]);
      } else {
        Provide.value<CategoryListProvide>(context)
            .getCateGoryGoodsList(subGoodsList);
      }
    });
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
  Widget build(BuildContext context) {
    return Provide<CategoryListProvide>(
        builder: (context, child, categoryListProvide) {
      if (categoryListProvide.categoryGoodsListModel.length > 0) {
        categoryGoodsList = categoryListProvide.categoryGoodsListModel;
        return Expanded(
          child: Container(
            width: ScreenUtil().setWidth(570),
            child: ListView.builder(
              itemBuilder: (context, index) {
                return _goodsItemInkWell(index);
              },
              itemCount: categoryGoodsList.length,
            ),
          ),
        );
      } else {
        return Text('暂时没有数据');
      }
    });
  }
}
```

## 第35节: 列表页_上拉加载功能的制作

### 增加page和noMoreText到Provide里

1. page 用于分页加载
2. noMoreText 用于显示没有更多数据

```
import 'package:flutter/material.dart';
import '../model/categoryConvert.dart';

class ChildCategoryProvide with ChangeNotifier {
  List<BxMallSubDto> bxMallSubDtoList = [];
  int childIndex = 0;

  // 提供当前左边导航的id
  String currentCategoryId = '4'; // 默认给4 这是根据数据
  // 二级分类id
  String currentCategorySubId = '';

  // 上拉加载page
  int page = 1;

  // 上拉加载没有数据提示文案
  String noMoreText = '';

  // 获取右边上层分类
  getChildListCategory(List<BxMallSubDto> bxMallSubDto, String categoryId) {
    childIndex = 0;
    currentCategoryId = categoryId;
    page = 1;
    noMoreText = '';
    BxMallSubDto addmallsubdto = BxMallSubDto();
    addmallsubdto.mallSubId = '';
    addmallsubdto.mallSubName = '全部';
    addmallsubdto.mallCategoryId = categoryId;
    addmallsubdto.comments = 'null';
    bxMallSubDtoList = [addmallsubdto];
    bxMallSubDtoList.addAll(bxMallSubDto);
    notifyListeners();
  }

  // 更新当前选择的二级分类
  void getCategoryChildIndex(int index, String categorySubId) {
    childIndex = index;
    currentCategorySubId = categorySubId;
    page = 1;
    noMoreText = '';
    notifyListeners();
  }

  // 增加当前页面数 page, 不改变页面不用 notifyListeners();
  void addCurrentPage() {
    page++;
  }

  // 显示当前没有数据提示文案
  void changeCurrentNoMoreText(String currentNoMoreText) {
    noMoreText = currentNoMoreText;
    notifyListeners();
  }
}

```

### 增加EasyRefresh组件，切换类别返回顶部

1. 增加EasyRefresh组件
2. 切换类别返回顶部 需要添加组件对应的控制器  listview 的是 ScrollController() _scrollController.jumpTo(0);

```
ListView.builder(
     controller: _scrollController,
     itemBuilder: (context, index) {
        return _goodsItemInkWell(index);
     },
    itemCount: categoryGoodsList.length,
)

```
3. 注意接口的修改  _getGoodsMoreList();

```
//商品列表 可以上拉加载
class CategoryGoodsList extends StatefulWidget {
  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {
  List<CategoryGoodsListModelData> categoryGoodsList = [];
  GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();

  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();

  var _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryListProvide>(
        builder: (context, child, categoryListProvide) {
      try {
        if (Provide.value<ChildCategoryProvide>(context).page == 1) {
          _scrollController.jumpTo(0);
        }
      } catch (e) {
        debugPrint('第一次进入页面防错$e');
      }

      if (categoryListProvide.categoryGoodsListModel.length > 0) {
        categoryGoodsList = categoryListProvide.categoryGoodsListModel;

        return Expanded(
          child: Container(
            width: ScreenUtil().setWidth(570),
            child: EasyRefresh(
              child: ListView.builder(
                controller: _scrollController,
                itemBuilder: (context, index) {
                  return _goodsItemInkWell(index);
                },
                itemCount: categoryGoodsList.length,
              ),
              key: _easyRefreshKey,
              // 上拉加载，footer设置
              refreshFooter: ClassicsFooter(
                key: _footerKey,
                bgColor: Colors.white,
                textColor: Colors.pink,
                moreInfoColor: Colors.pink,
                showMore: true,
                noMoreText:
                    Provide.value<ChildCategoryProvide>(context).noMoreText,
                //moreInfo: '加载...',
                moreInfo: '...',
                loadReadyText: '上拉加载开始',
                loadingText: '加载中',
                //loadedText: '加载完成...',
                //loadText: '上拉加载...',
              ),
              loadMore: () async {
                debugPrint('上拉获取更多数据');
                _getGoodsMoreList();
              },
            ),
          ),
        );
      } else {
        return Text('暂时没有数据');
      }
    });
  }

  // 获取二级分类当前分类的商品数据
  void _getGoodsMoreList() async {
    // 增加page++
    Provide.value<ChildCategoryProvide>(context).addCurrentPage();
    await getCategoryGoods(
            Provide.value<ChildCategoryProvide>(context).currentCategoryId,
            Provide.value<ChildCategoryProvide>(context).currentCategorySubId,
            Provide.value<ChildCategoryProvide>(context).page)
        .then((value) {
      var data = json.decode(value.toString());
      debugPrint('分类商品more：$data');
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      var subGoodsList = goodsList.data;
      if (subGoodsList == null) {
        Provide.value<ChildCategoryProvide>(context)
            .changeCurrentNoMoreText('没有更多数据了');
      } else {
        Provide.value<CategoryListProvide>(context)
            .getCateGoryGoodsMoreList(subGoodsList);
      }
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

```

### 二级横向分类中全部的数据判断

问题：如果二级分类下没有数据，显示暂时没有数据，这是切换到全部，则显示不了数据

解决：需要添加全部tab栏的处理

```
// 获取二级分类当前分类的商品数据
  void _getGoodsList(String categorySubId, String mallSubName) async {
    await getCategoryGoods(
      Provide.value<ChildCategoryProvide>(context).currentCategoryId,
      mallSubName == '全部' ? "" : categorySubId,
      1,
    ).then((value) {
      var data = json.decode(value.toString());
      debugPrint('分类：$data');
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      var subGoodsList = goodsList.data;
      if (subGoodsList == null) {
        Provide.value<CategoryListProvide>(context).getCateGoryGoodsList([]);
      } else {
        Provide.value<CategoryListProvide>(context)
            .getCateGoryGoodsList(subGoodsList);
      }
    });
  }
```

## 第36节：FlutterToast 组件的介绍

> [FlutterToast](https://github.com/PonnamKarthik/FlutterToast)


### FlutterToast

1. msg：提示的文字，String类型。
2. toastLength: 提示的样式，主要是长度，有两个值可以选择：Toast.LENGTH_SHORT ：短模式，就是比较短。Toast.LENGTH_LONG : 长模式，就是比较长。
3. gravity：提示出现的位置，分别是上中下，三个选项。ToastGravity.TOP顶部提示，ToastGravit.CENTER中部提示，ToastGravity.BOTTOM底部提示。
4. bgcolor: 背景颜色，跟从Flutter颜色。
5. textcolor：文字的颜色。
6. fontSize： 文字的大小。

```
pubspec.yaml
fluttertoast: ^3.1.0

Fluttertoast.showToast(
        msg: "This is Center Short Toast",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );

```

```

// 获取二级分类当前分类的商品数据
  void _getGoodsMoreList() async {
    // 增加page++
    Provide.value<ChildCategoryProvide>(context).addCurrentPage();
    await getCategoryGoods(
            Provide.value<ChildCategoryProvide>(context).currentCategoryId,
            Provide.value<ChildCategoryProvide>(context).currentCategorySubId,
            Provide.value<ChildCategoryProvide>(context).page)
        .then((value) {
      var data = json.decode(value.toString());
      debugPrint('分类商品more：$data');
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      var subGoodsList = goodsList.data;
      if (subGoodsList == null) {
        Fluttertoast.showToast(
          msg: '没有更多数据了',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.pink,
          textColor: Colors.white,
          fontSize: ScreenUtil().setSp(16),
        );
        Provide.value<ChildCategoryProvide>(context)
            .changeCurrentNoMoreText('没有更多数据了');
      } else {
        Provide.value<CategoryListProvide>(context)
            .getCateGoryGoodsMoreList(subGoodsList);
      }
    });
```

## 第37节：路由 fluro 引入和商品详细页建立

> [fluro https://github.com/theyakka/fluro](https://github.com/theyakka/fluro)

fluro简化了Flutter的路由开发，也是目前Flutter生态中最成熟的路由框架。

```
dependencies:
  fluro: ^1.4.0               
```

### 搭建商品详情页面

```
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final String goodsId;

  DetailsPage(this.goodsId);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('商品id $goodsId'),
    );
  }
}

```


## 第38节：路由 fluro 中Handler文件编写

handler就是每个路由的规则，编写handler就是配置路由规则，比如我们要传递参数，参数的值是什么，这些都需要在Handler中完成。

### 初始化Fluro

```
final router = Router();
```

### 编写rotuer_handler

handler相当于一个路由的规则，比如我们要到详细页面，这时候就需要传递商品的ID，那就要写一个handler。

```
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_shop_mall/pages/details_page.dart';

Handler detailsHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  String goodsId = parameters['id'].first;
  debugPrint('商品路由传入的id 是 $goodsId');
  return DetailsPage(goodsId);
});

```

## 第39节：路由 fluro 的路由配置和静态化

Hanlder只是对每个路由的独立配置文件，fluro当然还需要一个总体配置文件

### 配置路由

我们还需要对路由有一个总体的配置，比如跟目录，出现不存在的路径如何显示，工作中我们经常把这个文件单独写一个文件。在routes.dart里，新建一个routes.dart文件。

```

import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'router_handler.dart';

class Routers {
  static String root = '/';
  static String detailPage = '/details';

  static void configureRouters(Router router) {
    router.notFoundHandler = new Handler(handlerFunc:
        (BuildContext context, Map<String, List<String>> parameters) {
      debugPrint('没有发现对应要跳转的页面');
    });

    router.define(detailPage, handler: detailsHandler);
  }

}

```


### 把Fluro的Router静态化

这一步就是为了使用方便，直接把Router进行静态化，这样在任何一个页面都可以直接进行使用了

```
import 'package:fluro/fluro.dart';

class Application{
  static Router router;
}

```

## 第40节：路由 fluro 的全局注入和使用

需要在main.dart文件里进行全局注入。注入后就可以爽快的使用了，配置好后的使用方法也是非常简单的。

### 把路由注册到顶层

```
import 'package:flutter/material.dart';
import 'package:flutter_shop_mall/routers/application.dart';
import 'package:flutter_shop_mall/routers/routers.dart';
import './pages/index_page.dart';
import 'package:provide/provide.dart';
import 'provide/counter_provide.dart';
import 'provide/child_category_provide.dart';
import 'provide/category_list_provide.dart';
import 'package:fluro/fluro.dart';

void main() {
  var counter = CounterProvide(0);
  var childCategory = ChildCategoryProvide();
  var categoryGoodsListProvide = CategoryListProvide();
  var providers = Providers()
    ..provide(Provider<CounterProvide>.value(counter))
    ..provide(Provider<ChildCategoryProvide>.value(childCategory))
    ..provide(Provider.function((context) => categoryGoodsListProvide));
  runApp(ProviderNode(
    child: MyApp(),
    providers: providers,
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 路由配置
    var router = new Router();
    Routers.configureRouters(router);
    Application.router = router;

    return Container(
      child: MaterialApp(
        title: '百姓生活+',
        // 配置路由
        onGenerateRoute: Application.router.generator,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.pink,
        ),
        home: IndexPage(),
      ),
    );
  }
}

```

### 在首页使用

```
debugPrint('点击火爆商品');
Application.router.navigateTo(
                context, Routers.detailPage + '?id=${value['goodsId']}',
                transition: TransitionType.inFromRight);
```

### 分类中使用

```
debugPrint("分类点击商品");
Application.router.navigateTo(context,
            Routers.detailPage + '?id=${categoryGoodsList[index].goodsId}',
            transition: TransitionType.inFromRight);
```


## 第41节：详细页_后台数据接口调试

### 接口编写

```
import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../config/service_url.dart';

// 获取首页主体内容
Future getHomePageContent() {
  print('开始获取首页数据....');
  var formData = {
    'lon': '115.02932',
    'lat': '35.76189',
  };
  return request('homePageContent', formData: formData);
}

// 获取火爆专区的商品
Future getHomePageHotContent(page) {
  print('开始火爆专区的数据....');
  var formData = {
    'page': page,
  };
  return request('homePageBelowConten', formData: formData);
}

// 获取分类页面的数据
Future getCategoryContent() {
  print('开始获取分类页面数据....');
  return request('getCategory');
}

// 获取右边分类的商品数据
Future getCategoryGoods(String categoryId, String categorySubId, int page) {
  print('开始获取分类页面商品数据....');
  var formData = {
    'categoryId': categoryId,
    'categorySubId': categorySubId,
    'page': page
  };
  return request('getMallGoods', formData: formData);
}

// 获取商品详情
Future getDetailGoods(String goodsId) {
  print('开始获取分类页面商品数据....');
  var formData = {
    'goodId': goodsId,
  };
  return request('getGoodDetailById', formData: formData);
}

// 方法
Future request(url, {formData}) async {
  try {
    print('开始获取数据....');
    Response response;
    Dio dio = new Dio();
    // 表单
    dio.options.contentType = ContentType.parse(
      "application/x-www-form-urlencoded",
    );
    print('url ${servicePath[url]} + fromdata$formData');
    if (formData == null) {
      response = await dio.post(servicePath[url]);
    } else {
      response = await dio.post(servicePath[url], data: formData);
    }
    if (response.statusCode == 200) {
      print('数据返回 ${response.data}');
      return response.data;
    } else {
      throw Exception('后端接口出现异常。');
    }
  } catch (e) {
    return print('Error: =======>$e');
  }
}

```

### 模型层编写

```
class DetailsGoodsModel {
  String code;
  String message;
  DetailsGoodsModelData data;

  DetailsGoodsModel({this.code, this.message, this.data});

  DetailsGoodsModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new DetailsGoodsModelData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class DetailsGoodsModelData {
  GoodInfo goodInfo;
  List<GoodComments> goodComments;
  AdvertesPicture advertesPicture;

  DetailsGoodsModelData({this.goodInfo, this.goodComments, this.advertesPicture});

  DetailsGoodsModelData.fromJson(Map<String, dynamic> json) {
    goodInfo = json['goodInfo'] != null
        ? new GoodInfo.fromJson(json['goodInfo'])
        : null;
    if (json['goodComments'] != null) {
      goodComments = new List<GoodComments>();
      json['goodComments'].forEach((v) {
        goodComments.add(new GoodComments.fromJson(v));
      });
    }
    advertesPicture = json['advertesPicture'] != null
        ? new AdvertesPicture.fromJson(json['advertesPicture'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.goodInfo != null) {
      data['goodInfo'] = this.goodInfo.toJson();
    }
    if (this.goodComments != null) {
      data['goodComments'] = this.goodComments.map((v) => v.toJson()).toList();
    }
    if (this.advertesPicture != null) {
      data['advertesPicture'] = this.advertesPicture.toJson();
    }
    return data;
  }
}

class GoodInfo {
  String image5;
  int amount;
  String image3;
  String image4;
  String goodsId;
  String isOnline;
  String image1;
  String image2;
  String goodsSerialNumber;
  int oriPrice;
  double presentPrice;
  String comPic;
  int state;
  String shopId;
  String goodsName;
  String goodsDetail;

  GoodInfo(
      {this.image5,
        this.amount,
        this.image3,
        this.image4,
        this.goodsId,
        this.isOnline,
        this.image1,
        this.image2,
        this.goodsSerialNumber,
        this.oriPrice,
        this.presentPrice,
        this.comPic,
        this.state,
        this.shopId,
        this.goodsName,
        this.goodsDetail});

  GoodInfo.fromJson(Map<String, dynamic> json) {
    image5 = json['image5'];
    amount = json['amount'];
    image3 = json['image3'];
    image4 = json['image4'];
    goodsId = json['goodsId'];
    isOnline = json['isOnline'];
    image1 = json['image1'];
    image2 = json['image2'];
    goodsSerialNumber = json['goodsSerialNumber'];
    oriPrice = json['oriPrice'];
    presentPrice = json['presentPrice'];
    comPic = json['comPic'];
    state = json['state'];
    shopId = json['shopId'];
    goodsName = json['goodsName'];
    goodsDetail = json['goodsDetail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image5'] = this.image5;
    data['amount'] = this.amount;
    data['image3'] = this.image3;
    data['image4'] = this.image4;
    data['goodsId'] = this.goodsId;
    data['isOnline'] = this.isOnline;
    data['image1'] = this.image1;
    data['image2'] = this.image2;
    data['goodsSerialNumber'] = this.goodsSerialNumber;
    data['oriPrice'] = this.oriPrice;
    data['presentPrice'] = this.presentPrice;
    data['comPic'] = this.comPic;
    data['state'] = this.state;
    data['shopId'] = this.shopId;
    data['goodsName'] = this.goodsName;
    data['goodsDetail'] = this.goodsDetail;
    return data;
  }
}

class GoodComments {
  int sCORE;
  String comments;
  String userName;
  int discussTime;

  GoodComments({this.sCORE, this.comments, this.userName, this.discussTime});

  GoodComments.fromJson(Map<String, dynamic> json) {
    sCORE = json['SCORE'];
    comments = json['comments'];
    userName = json['userName'];
    discussTime = json['discussTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SCORE'] = this.sCORE;
    data['comments'] = this.comments;
    data['userName'] = this.userName;
    data['discussTime'] = this.discussTime;
    return data;
  }
}

class AdvertesPicture {
  String pICTUREADDRESS;
  String tOPLACE;

  AdvertesPicture({this.pICTUREADDRESS, this.tOPLACE});

  AdvertesPicture.fromJson(Map<String, dynamic> json) {
    pICTUREADDRESS = json['PICTURE_ADDRESS'];
    tOPLACE = json['TO_PLACE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PICTURE_ADDRESS'] = this.pICTUREADDRESS;
    data['TO_PLACE'] = this.tOPLACE;
    return data;
  }
}

```

### 状态管理编写

将业务逻辑和UI表现分开的，所以线建立一个Provide文件，所有业务逻辑将写在Provide里，然后pages文件夹里只写UI层面的东西

```
import 'package:flutter/material.dart';
import 'package:flutter_shop_mall/model/detailsGoodsModel.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shop_mall/service/service_method.dart';
import 'dart:convert';

class DetailsGoodsProvide with ChangeNotifier {
  DetailsGoodsModel detailsGoods;

  getDetailsGoods(String goodsId) {
    getDetailGoods(goodsId).then((value) {
      debugPrint("----$value");
      var data = json.decode(value.toString());
      detailsGoods = DetailsGoodsModel.fromJson(data);
      notifyListeners();
    });
  }
}

```

### 顶层注入

```
import 'package:flutter/material.dart';
import 'package:flutter_shop_mall/provide/details_goods_provide.dart';
import 'package:flutter_shop_mall/routers/application.dart';
import 'package:flutter_shop_mall/routers/routers.dart';
import './pages/index_page.dart';
import 'package:provide/provide.dart';
import 'provide/counter_provide.dart';
import 'provide/child_category_provide.dart';
import 'provide/category_list_provide.dart';
import 'package:fluro/fluro.dart';

void main() {
  var counter = CounterProvide(0);
  var childCategory = ChildCategoryProvide();
  var categoryGoodsListProvide = CategoryListProvide();
  var detailsGoodsProvide = DetailsGoodsProvide();
  var providers = Providers()
    ..provide(Provider<CounterProvide>.value(counter))
    ..provide(Provider<ChildCategoryProvide>.value(childCategory))
    ..provide(Provider.function((context) => categoryGoodsListProvide))
    ..provide(Provider.function((context) => detailsGoodsProvide));
  runApp(ProviderNode(
    child: MyApp(),
    providers: providers,
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 路由配置
    var router = new Router();
    Routers.configureRouters(router);
    Application.router = router;

    return Container(
      child: MaterialApp(
        title: '百姓生活+',
        // 配置路由
        onGenerateRoute: Application.router.generator,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.pink,
        ),
        home: IndexPage(),
      ),
    );
  }
}

```

### 商品详情调用

```
import 'package:flutter/material.dart';
import 'package:flutter_shop_mall/provide/details_goods_provide.dart';
import 'package:provide/provide.dart';

class DetailsPage extends StatelessWidget {
  final String goodsId;

  DetailsPage(this.goodsId);

  @override
  Widget build(BuildContext context) {
    Provide.value<DetailsGoodsProvide>(context).getDetailsGoods(goodsId);
    debugPrint(".....测试");
    return Container(
      child: Text('商品id $goodsId'),
    );
  }
}

```

## 第42节：详细页UI主页面架构搭建


```
import 'package:flutter/material.dart';
import 'package:flutter_shop_mall/provide/details_goods_provide.dart';
import 'package:provide/provide.dart';

class DetailsPage extends StatelessWidget {
  final String goodsId;

  DetailsPage(this.goodsId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品详情页'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder(
        future: _getGoodDetail(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              child: Column(
                children: <Widget>[
                  Text('商品id+$goodsId'),
                ],
              ),
            );
          } else {
            return Text('加载中.....');
          }
        },
      ),
    );
  }

  Future _getGoodDetail(BuildContext context) async {
    Provide.value<DetailsGoodsProvide>(context).getDetailsGoods(goodsId);
    return "完成加载";
  }
}

```


## 第43节：路由_补充首页跳转到详细页


### 首页轮播模块添加路由

```
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
          return InkWell(
            onTap: () {
              debugPrint('点击轮播图');
              Application.router.navigateTo(
                context,
                Routers.detailPage + '?id=${swiperDataList[index]['goodsId']}',
                transition: TransitionType.inFromRight,
              );
            },
            child: Image.network(
              "${swiperDataList[index]['image']}",
              fit: BoxFit.fill,
            ),
          );
        },
        itemCount: swiperDataList.length,
        pagination: new SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}
```

### 商品推荐模块添加路由

```
 // 商品单独项
Widget _goodsItem(index, BuildContext context) {
    return InkWell(
      onTap: () {
        debugPrint('商品推荐');
        Application.router.navigateTo(
          context,
          Routers.detailPage + '?id=${recommendList[index]['goodsId']}',
          transition: TransitionType.inFromRight,
        );
      },
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
```


### 楼层模块添加路由

```
Widget _goodsItems(Map goods, BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(375),
      child: InkWell(
        onTap: () {
          debugPrint("楼层模块");
          Application.router.navigateTo(
            context,
            Routers.detailPage + '?id=${goods['goodsId']}',
            transition: TransitionType.inFromRight,
          );
        },
        child: Image.network(goods['image']),
      ),
    );
  }
```

## 第44节：详细页_首屏自定义Widget编写

页面整合和抽离，让页面更加工整

```

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop_mall/provide/details_goods_provide.dart';
import 'package:provide/provide.dart';

class DetailsTopArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<DetailsGoodsProvide>(
      builder: (context, child, detailsGoodsProvide) {
        debugPrint("ssss${detailsGoodsProvide.detailsGoods.data}");
        var goodInfo = detailsGoodsProvide.detailsGoods.data.goodInfo;
        if (goodInfo != null) {
          return Container(
            color: Colors.white,
            padding: EdgeInsets.all(2.0),
            child: Column(
              children: <Widget>[
                _goodsImage(goodInfo.image1),
                _goodsName(goodInfo.goodsName),
                _goodsSerialNumber(goodInfo.goodsSerialNumber),
                _goodsPrice(goodInfo.oriPrice,goodInfo.presentPrice),
              ],
            ),
          );
        } else {
          return Text('当前详细页面没有数据....');
        }
      },
    );
  }

  // 商品图片
  Widget _goodsImage(String imageUrl) {
    return Image.network(
      imageUrl,
      width: ScreenUtil().setWidth(740),
    );
  }

  // 名字
  Widget _goodsName(String name) {
    return Container(
      width: ScreenUtil().setWidth(730),
      margin: EdgeInsets.only(left: 10),
      child: Text(
        name,
        style: TextStyle(
          color: Colors.black,
          fontSize: ScreenUtil().setSp(30),
        ),
      ),
    );
  }

  // 编码
  Widget _goodsSerialNumber(String num) {
    return Container(
      width: ScreenUtil().setWidth(750),
      margin: EdgeInsets.fromLTRB(10, 5, 0, 0),
      child: Text(
        "编号：$num",
        style: TextStyle(
          color: Colors.black26,
          fontSize: ScreenUtil().setSp(24),
        ),
      ),
    );
  }

  // 价钱
  Widget _goodsPrice(double oriPrice, double presentPrice) {
    return Container(
      width: ScreenUtil().setWidth(750),
      margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
      child: Row(
        children: <Widget>[
          Text(
            "￥$oriPrice",
            style: TextStyle(
              color: Colors.pinkAccent,
              fontSize: ScreenUtil().setSp(40),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Text(
              "市场价：",
              style: TextStyle(
                color: Colors.black,
                fontSize: ScreenUtil().setSp(26),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Text(
              "￥$presentPrice",
              style: TextStyle(
                color: Colors.black26,
                fontSize: ScreenUtil().setSp(24),
                decoration: TextDecoration.lineThrough,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

```

### 商品页面调用

```
import 'package:flutter/material.dart';
import 'package:flutter_shop_mall/provide/details_goods_provide.dart';
import 'package:provide/provide.dart';

import 'details_page/details_top_area.dart';

class DetailsPage extends StatelessWidget {
  final String goodsId;

  DetailsPage(this.goodsId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品详情页'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder(
        future: _getGoodDetail(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              child: Column(
                children: <Widget>[
                  DetailsTopArea(),
                ],
              ),
            );
          } else {
            return Text('加载中.....');
          }
        },
      ),
    );
  }

  Future _getGoodDetail(BuildContext context) async {
    Provide.value<DetailsGoodsProvide>(context).getDetailsGoods(goodsId);
    return "完成加载";
  }
}

```

## 第45节：详细页_说明区域UI编写

```
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

```

## 第46节：详细页_自建TabBar Widget

### 自定义tabBar状态管理
```
import 'package:flutter/material.dart';
import 'package:flutter_shop_mall/model/detailsGoodsModel.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shop_mall/service/service_method.dart';
import 'dart:convert';

class DetailsGoodsProvide with ChangeNotifier {
  DetailsGoodsModel detailsGoods;

  bool isLeft = false;
  bool isRight = false;

  changeTabState(String type) {
    if (type == 'left') {
      isLeft = true;
      isRight = false;
    } else {
      isLeft = false;
      isRight = true;
    }
    notifyListeners();
  }


  getDetailsGoods(String goodsId) {
    getDetailGoods(goodsId).then((value) {
      debugPrint("----$value");
      var data = json.decode(value.toString());
      detailsGoods = DetailsGoodsModel.fromJson(data);
      notifyListeners();
    });
  }
}

```

### 自己定义 tabBar
```
import 'package:flutter/material.dart';
import 'package:flutter_shop_mall/provide/details_goods_provide.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<DetailsGoodsProvide>(
      builder: (context, child, detailsGoodsProvide) {
        return Provide<DetailsGoodsProvide>(
          builder: (context, child, detailsGoodsProvide) {
            var isLeft = detailsGoodsProvide.isLeft;
            var isRight = detailsGoodsProvide.isRight;
            return Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                children: <Widget>[
                  _leftTabBar(context, isLeft),
                  _rightTabBar(context, isRight),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _leftTabBar(BuildContext context, bool isLeft) {
    return _tabBar(context, '详情', 'left', isLeft);
  }

  Widget _rightTabBar(BuildContext context, bool isLeft) {
    return _tabBar(context, '评论', 'right', isLeft);
  }

  Widget _tabBar(
      BuildContext context, String desc, String type, bool changeState) {
    return InkWell(
      onTap: () {
        debugPrint('点击tab');
        Provide.value<DetailsGoodsProvide>(context).changeTabState(type);
      },
      child: Container(
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(375),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: changeState ? Colors.pink : Colors.black12,
              width: 1,
              style: BorderStyle.solid,
            ),
          ),
        ),
        child: Text(
          desc,
          style: TextStyle(
            color: changeState ? Colors.pink : Colors.black,
            fontSize: ScreenUtil().setSp(28),
          ),
        ),
      ),
    );
  }
}

```

### 商品详细页面

设置选中状态，同时获取商品的页面

```
import 'package:flutter/material.dart';
import 'package:flutter_shop_mall/pages/details_page/details_tabbar.dart';
import 'package:flutter_shop_mall/provide/details_goods_provide.dart';
import 'package:provide/provide.dart';

import 'details_page/details_explain.dart';
import 'details_page/details_top_area.dart';

class DetailsPage extends StatelessWidget {
  final String goodsId;

  DetailsPage(this.goodsId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Provide<DetailsGoodsProvide>(
            builder: (context, child, detailsGoodsProvide) {
          var goodInfo = detailsGoodsProvide.detailsGoods.data.goodInfo;
          if (goodInfo != null) {
            return Text(goodInfo.goodsName);
          } else {
            return Text('商品详情');
          }
        }),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder(
        future: _getGoodDetail(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              child: ListView(
                children: <Widget>[
                  DetailsTopArea(),
                  DetailsExplain(),
                  DetailsTabBar(),
                ],
              ),
            );
          } else {
            return Text('加载中.....');
          }
        },
      ),
    );
  }

  Future _getGoodDetail(BuildContext context) async {
    Provide.value<DetailsGoodsProvide>(context).getDetailsGoods(goodsId);
    Provide.value<DetailsGoodsProvide>(context).changeTabState('left');
    return "完成加载";
  }
}

```

## 第47节：详细页_Flutter_html插件的使用

### flutter_html介绍 [flutter_html](https://github.com/Sub6Resources/flutter_html)

flutter_html是一个可以解析静态html标签的Flutter Widget，现在支持超过70种不同的标签。

```
flutter_html: ^0.9.6


Html(
  data: """
    <!--For a much more extensive example, look at example/main.dart-->
    <div>
      <h1>Demo Page</h1>
      <p>This is a fantastic nonexistent product that you should buy!</p>
      <h2>Pricing</h2>
      <p>Lorem ipsum <b>dolor</b> sit amet.</p>
      <h2>The Team</h2>
      <p>There isn't <i>really</i> a team...</p>
      <h2>Installation</h2>
      <p>You <u>cannot</u> install a nonexistent product!</p>
      <!--You can pretty much put any html in here!-->
    </div>
  """,
  //Optional parameters:
  padding: EdgeInsets.all(8.0),
  backgroundColor: Colors.white70,
  defaultTextStyle: TextStyle(fontFamily: 'serif'),
  linkStyle: const TextStyle(
    color: Colors.redAccent,
  ),
  onLinkTap: (url) {
    // open url in a webview
  },
  customRender: (node, children) {
    if(node is dom.Element) {
      switch(node.localName) {
        case "video": return Chewie(...);
        case "custom_tag": return CustomWidget(...);
      }
    }
  },
)

```
### 网页

```
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop_mall/provide/details_goods_provide.dart';
import 'package:provide/provide.dart';
import 'package:flutter_html/flutter_html.dart';

class DetailsWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var goodsDetail = Provide.value<DetailsGoodsProvide>(context)
        .detailsGoods
        .data
        .goodInfo
        .goodsDetail;
    debugPrint(' goodsDetail  $goodsDetail');
    return Container(
      child: Html(data: goodsDetail),
    );
  }
}

```

### 解决报错  The getter 'data' was called on null.  但是目前还是没有解决问题。

```
import 'package:flutter/material.dart';
import 'package:flutter_shop_mall/model/detailsGoodsModel.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shop_mall/service/service_method.dart';
import 'dart:convert';

class DetailsGoodsProvide with ChangeNotifier {
  DetailsGoodsModel detailsGoods;

  bool isLeft = false;
  bool isRight = false;

  changeTabState(String type) {
    if (type == 'left') {
      isLeft = true;
      isRight = false;
    } else {
      isLeft = false;
      isRight = true;
    }
    notifyListeners();
  }


  getDetailsGoods(String goodsId) async {
    await getDetailGoods(goodsId).then((value) {
      debugPrint("----$value");
      var data = json.decode(value.toString());
      detailsGoods = DetailsGoodsModel.fromJson(data);
      notifyListeners();
    });
  }
}

```

## 第48节：详细页_详情和评论切换效果制作

### 现在存在问题，就是在colum 种放listview 有问题,

如果不写固定高度 height: ScreenUtil().setHeight(140) 那么就会报错

```
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop_mall/model/detailsGoodsModel.dart';
import 'package:flutter_shop_mall/provide/details_goods_provide.dart';
import 'package:provide/provide.dart';
import 'package:flutter_html/flutter_html.dart';

class DetailsWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var goodsDetail = Provide.value<DetailsGoodsProvide>(context)
        .detailsGoods
        .data
        .goodInfo
        .goodsDetail;

    debugPrint(' goodsDetail  $goodsDetail');

    var goodsComment = Provide.value<DetailsGoodsProvide>(context)
        .detailsGoods
        .data
        .goodComments;

    if (goodsComment != null && goodsComment.length > 0) {
      debugPrint(' goodsComment  ${goodsComment[0].userName}');
    }

    var advertesPicture = Provide.value<DetailsGoodsProvide>(context)
        .detailsGoods
        .data
        .advertesPicture;

    debugPrint(' advertesPicture  ${advertesPicture.pICTUREADDRESS}');

    return Provide<DetailsGoodsProvide>(
      builder: (context, child, detailsGoodsProvide) {
        var isLeft = Provide.value<DetailsGoodsProvide>(context).isLeft;
        if (isLeft) {
          return Container(
            child: Html(data: goodsDetail),
          );
        } else {
          if (goodsComment != null && goodsComment.length > 0) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: ScreenUtil().setHeight(140),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                  ),
                  width: ScreenUtil().setWidth(750),
                  child: ListView.builder(
                    itemCount: goodsComment.length,
                    itemBuilder: (context, index) {
                      return _showComments(goodsComment[index]);
                    },
                  ),
                ),
                Image.network(advertesPicture.pICTUREADDRESS),
              ],
            );
          } else {
            if (advertesPicture != null) {
              return Image.network(advertesPicture.pICTUREADDRESS);
            } else {
              return Container(
                width: ScreenUtil().setWidth(750),
                margin: EdgeInsets.only(top: 15),
                padding: EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: Text("当前还没有评论哦"),
              );
            }
          }
        }
      },
    );
  }

  Widget _showComments(GoodComments comment) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              comment.userName,
              style: TextStyle(
                color: Colors.black,
                fontSize: ScreenUtil().setSp(24),
              ),
            ),
          ),
          Container(
            child: Text(
              comment.comments,
              style: TextStyle(
                color: Colors.black26,
                fontSize: ScreenUtil().setSp(24),
              ),
            ),
          ),
          Text(
            '${comment.discussTime}',
            style: TextStyle(
              color: Colors.black45,
              fontSize: ScreenUtil().setSp(24),
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(1),
          )
        ],
      ),
    );
  }
}


```


## 第49节：详细页页_Stack作底部操作栏


### Stack组件介绍

Stack组件是层叠组件，里边的每一个子控件都是定位或者不定位，定位的子控件是被Positioned Widget进行包裹的。

```
import 'package:flutter/material.dart';
import 'package:flutter_shop_mall/pages/details_page/details_tabbar.dart';
import 'package:flutter_shop_mall/provide/details_goods_provide.dart';
import 'package:provide/provide.dart';

import 'details_page/details_bottom.dart';
import 'details_page/details_explain.dart';
import 'details_page/details_top_area.dart';
import 'details_page/details_web.dart';

class DetailsPage extends StatelessWidget {
  final String goodsId;

  DetailsPage(this.goodsId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Provide<DetailsGoodsProvide>(
            builder: (context, child, detailsGoodsProvide) {
          var goodInfo = detailsGoodsProvide.detailsGoods.data.goodInfo;
          if (goodInfo != null) {
            return Text(goodInfo.goodsName);
          } else {
            return Text('商品详情');
          }
        }),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder(
        future: _getGoodDetail(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Stack(
              children: <Widget>[
                Container(
                  child: ListView(
                    children: <Widget>[
                      DetailsTopArea(),
                      DetailsExplain(),
                      DetailsTabBar(),
                      DetailsWeb(),
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  bottom: 0,
                  child: DetailsBottom(),
                )
              ],
            );
          } else {
            return Text('加载中.....');
          }
        },
      ),
    );
  }

  Future _getGoodDetail(BuildContext context) async {
    await Provide.value<DetailsGoodsProvide>(context).getDetailsGoods(goodsId);
    Provide.value<DetailsGoodsProvide>(context).changeTabState('left');
    return "完成加载";
  }
}


```
    
### 底部标签添加

```
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(100),
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: () {
              debugPrint('点击购物车');
            },
            child: Container(
              height: ScreenUtil().setHeight(100),
              width: ScreenUtil().setHeight(110),
              color: Colors.white,
              child: Icon(
                Icons.shopping_cart,
                size: 30,
                color: Colors.pink,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              debugPrint('加入购物车');
            },
            child: Container(
              height: ScreenUtil().setHeight(100),
              width: ScreenUtil().setHeight(320),
              color: Colors.green,
              alignment: Alignment(0, 0),
              child: Text(
                '加入购物车',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(30),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              debugPrint('立即购买');
            },
            child: Container(
              height: ScreenUtil().setHeight(100),
              width: ScreenUtil().setHeight(320),
              color: Colors.red,
              alignment: Alignment(0, 0),
              child: Text(
                '立即购买',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(30),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

```

## 第50节:持久化_shared_preferences基础1

* sqflite
* shared_preferences
* file

### shared_preferences  [shared_preferences](https://github.com/flutter/plugins/tree/master/packages/shared_preferences)

> https://github.com/flutter/plugins/tree/master/packages/shared_preferences

是一个Flutter官方出的插件，它的主要作用就是可以key-value的形式来进行APP可客户端的持久化。


```
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

```

## 第51节：购物车_添加商品

### 定义状态管理，持久化数据

```
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvide extends ChangeNotifier {
  String cartGoodsStr = "[]";

  void save(String goodsId, String goodsName, int count, double presentPrice,
      String images) async {
    // 初始化SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // 获取数据
    cartGoodsStr = prefs.getString('cartInfo');
    debugPrint('cartGoodsStr 值  $cartGoodsStr');
    // 判断cartString是否为空，为空说明是第一次添加，或者被key被清除了。
    // 如果有值进行decode操作
    var temp = cartGoodsStr == null ? [] : json.decode(cartGoodsStr.toString());
    List<Map> tampList = (temp as List).cast();

    // 判断是否存在当前商品
    bool isHaveThisGoods = false;

    // 用于进行循环的索引使用
    int ival = 0;
    // 进行循环，找出是否已经存在该商品
    tampList.forEach((item) {
      // 如果存在，数量进行+1操作
      if (item['goodsId'] == goodsId) {
        tampList[ival]['count'] = item['count'] + 1;
        isHaveThisGoods = true;
      }
      ival++;
    });

    //  如果没有，进行增加
    if (!isHaveThisGoods) {
      tampList.add({
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': presentPrice,
        'images': images
      });
    }

    //把字符串进行encode操作，
    cartGoodsStr = json.encode(tampList).toString();
    debugPrint('持久化数据  $cartGoodsStr');
    prefs.setString('cartInfo', cartGoodsStr); //进行持久化
  }

  void remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.clear();//清空键值对
    prefs.remove('cartInfo');
    debugPrint('清空完成-----------------');
    notifyListeners();
  }
}

```

### 加入购物车调用

```
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop_mall/provide/cart_provide.dart';
import 'package:flutter_shop_mall/provide/details_goods_provide.dart';
import 'package:provide/provide.dart';

class DetailsBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var goodsInfo =
        Provide.value<DetailsGoodsProvide>(context).detailsGoods.data.goodInfo;
    var goodsId = goodsInfo.goodsId;
    var goodsName = goodsInfo.goodsName;
    var count = 1;
    var presentPrice = goodsInfo.presentPrice;
    var images = goodsInfo.image1;

    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(100),
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: () {
              debugPrint('点击购物车');
            },
            child: Container(
              height: ScreenUtil().setHeight(100),
              width: ScreenUtil().setHeight(110),
              color: Colors.white,
              child: Icon(
                Icons.shopping_cart,
                size: 30,
                color: Colors.pink,
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              debugPrint('加入购物车');
              Provide.value<CartProvide>(context)
                  .save(goodsId, goodsName, count, presentPrice, images);
            },
            child: Container(
              height: ScreenUtil().setHeight(100),
              width: ScreenUtil().setHeight(320),
              color: Colors.green,
              alignment: Alignment(0, 0),
              child: Text(
                '加入购物车',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(30),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              debugPrint('立即购买');
              Provide.value<CartProvide>(context).remove();
            },
            child: Container(
              height: ScreenUtil().setHeight(100),
              width: ScreenUtil().setHeight(320),
              color: Colors.red,
              alignment: Alignment(0, 0),
              child: Text(
                '立即购买',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(30),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

```

### 主入口注册

```
void main() {
  var counter = CounterProvide(0);
  var childCategory = ChildCategoryProvide();
  var categoryGoodsListProvide = CategoryListProvide();
  var detailsGoodsProvide = DetailsGoodsProvide();
  var cartProvide = CartProvide();
  var providers = Providers()
    ..provide(Provider<CounterProvide>.value(counter))
    ..provide(Provider<ChildCategoryProvide>.value(childCategory))
    ..provide(Provider.function((context) => categoryGoodsListProvide))
    ..provide(Provider.function((context) => detailsGoodsProvide))
    ..provide(Provider.function((context) => cartProvide));
  runApp(ProviderNode(
    child: MyApp(),
    providers: providers,
  ));
}
```


## 第52节：购物车_建立数据模型

### 添加购物model类

```
class CartInfoModel {
  String goodsId;
  String goodsName;
  int count;
  double price;
  String images;

  CartInfoModel(
      {this.goodsId, this.goodsName, this.count, this.price, this.images});

  CartInfoModel.fromJson(Map<String, dynamic> json) {
    goodsId = json['goodsId'];
    goodsName = json['goodsName'];
    count = json['count'];
    price = json['price'];
    images = json['images'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['goodsId'] = this.goodsId;
    data['goodsName'] = this.goodsName;
    data['count'] = this.count;
    data['price'] = this.price;
    data['images'] = this.images;
    return data;
  }
}

```

### 修改购物状态管理类，注意有数据，需要把数据拿出来，不然会数组越界

```
import 'package:flutter/material.dart';
import 'package:flutter_shop_mall/model/cartInfoModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartProvide extends ChangeNotifier {
  String cartGoodsStr = "[]";
  List<CartInfoModel> cartInfoList = [];

  void save(String goodsId, String goodsName, int count, double presentPrice,
      String images) async {
    // 初始化SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // 获取数据
    cartGoodsStr = prefs.getString('cartInfo');
    debugPrint('cartGoodsStr 值  $cartGoodsStr');
    // 判断cartString是否为空，为空说明是第一次添加，或者被key被清除了。
    // 如果有值进行decode操作
    var temp = cartGoodsStr == null ? [] : json.decode(cartGoodsStr.toString());
    List<Map> tampList = (temp as List).cast();
    // 如果数据不为空，那么需要给 cartInfoList 添加数据
    if (tampList != null && tampList.length > 0) {
      tampList.forEach((item) {
        cartInfoList.add(new CartInfoModel.fromJson(item));
      });
    }

    // 判断是否存在当前商品
    bool isHaveThisGoods = false;

    // 用于进行循环的索引使用
    int ival = 0;
    // 进行循环，找出是否已经存在该商品
    tampList.forEach((item) {
      debugPrint('ival 前 $ival');
      // 如果存在，数量进行+1操作
      if (item['goodsId'] == goodsId) {
        debugPrint('有一样的数据，+1');
        tampList[ival]['count'] = item['count'] + 1;
        cartInfoList[ival].count++;
        isHaveThisGoods = true;
      }
      ival++;
    });

    debugPrint('ival 后 $ival');

    //  如果没有，进行增加
    if (!isHaveThisGoods) {
      Map<String, dynamic> newGoods = {
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': presentPrice,
        'images': images
      };
      tampList.add(newGoods);
      cartInfoList.add(CartInfoModel.fromJson(newGoods));
    }

    //把字符串进行encode操作，
    cartGoodsStr = json.encode(tampList).toString();
    debugPrint('持久化数据 字符串 $cartGoodsStr');
    debugPrint('持久化数据 列表 $cartInfoList');
    prefs.setString('cartInfo', cartGoodsStr); //进行持久化
  }

  void remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.clear();//清空键值对
    prefs.remove('cartInfo');
    // 置空数据
    cartInfoList = [];
    debugPrint('清空完成-----------------');
    notifyListeners();
  }

  // 得到购物车中的商品
  getCartInfoGoods() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var cartInfoStr = prefs.getString('cartInfo');
    //把cartList进行初始化，防止数据混乱
    cartInfoList = [];

    // 判断得到的字符串是否有值，如果不判断会报错
    if (cartInfoStr == null) {
      cartInfoList = [];
    } else {
      var cartInfoJson = json.decode(cartInfoStr.toString());
      List<Map> tampList = (cartInfoJson as List).cast();
      tampList.forEach((item) {
        cartInfoList.add(new CartInfoModel.fromJson(item));
      });
    }
    notifyListeners();
  }
}

```

## 第53节：购物车_大体结构布局

### 购物车页面获取数据

```

import 'package:flutter/material.dart';
import 'package:flutter_shop_mall/model/cartInfoModel.dart';
import 'package:flutter_shop_mall/provide/cart_provide.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品购物车'),
      ),
      body: FutureBuilder(
        future: _getCartGoods(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<CartInfoModel> listCartGoods =
                Provide.value<CartProvide>(context).cartInfoList;
            if (listCartGoods != null && listCartGoods.length > 0) {
              return ListView.builder(
                itemCount: listCartGoods.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(listCartGoods[index].goodsName),
                  );
                },
              );
            } else {
              return Center(
                child: Text(
                  '当前购物车为空',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(30),
                    color: Colors.black12,
                  ),
                ),
              );
            }
          } else {
            return Center(
              child: Text(
                '当前购物车为空',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(30),
                  color: Colors.black12,
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Future<String> _getCartGoods(BuildContext context) async {
    await Provide.value<CartProvide>(context).getCartInfoGoods();
    return "完成加载";
  }
}

```

## 第54节：购物车_商品列表子项组件编写

### 编写购物车单项方法

```
import 'package:flutter/material.dart';
import 'package:flutter_shop_mall/model/cartInfoModel.dart';
import 'package:flutter_shop_mall/provide/cart_provide.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'cart_item_page.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品购物车'),
      ),
      body: FutureBuilder(
        future: _getCartGoods(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            debugPrint('购物车 有数据');
            List<CartInfoModel> listCartGoods =
                Provide.value<CartProvide>(context).cartInfoList;
            if (listCartGoods != null && listCartGoods.length > 0) {
              debugPrint('购物车 有数据 不为空');
              return Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black12,
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                    height: ScreenUtil().setHeight(1),
                  ),
                  Expanded(
                    flex: 2,
                    child: ListView.builder(
                      itemCount: listCartGoods.length,
                      itemBuilder: (context, index) {
                        return CartItemPage(listCartGoods[index]);
                      },
                    ),
                  ),
                ],
              );
            } else {
              debugPrint('购物车 有数据 为空');
              return Center(
                child: Text(
                  '当前购物车为空',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(30),
                    color: Colors.black12,
                  ),
                ),
              );
            }
          } else {
            debugPrint('购物车 没有数据');
            return Center(
              child: Text(
                '当前购物车为空',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(30),
                  color: Colors.black12,
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Future<String> _getCartGoods(BuildContext context) async {
    await Provide.value<CartProvide>(context).getCartInfoGoods();
    return "完成加载";
  }
}

```

### 调用购物的item列表

```
import 'package:flutter/material.dart';
import 'package:flutter_shop_mall/model/cartInfoModel.dart';
import 'package:flutter_shop_mall/provide/cart_provide.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'cart_item_page.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品购物车'),
      ),
      body: FutureBuilder(
        future: _getCartGoods(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            debugPrint('购物车 有数据');
            List<CartInfoModel> listCartGoods =
                Provide.value<CartProvide>(context).cartInfoList;
            if (listCartGoods != null && listCartGoods.length > 0) {
              debugPrint('购物车 有数据 不为空');
              return Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black12,
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                    height: ScreenUtil().setHeight(1),
                  ),
                  Expanded(
                    flex: 2,
                    child: ListView.builder(
                      itemCount: listCartGoods.length,
                      itemBuilder: (context, index) {
                        return CartItemPage(listCartGoods[index]);
                      },
                    ),
                  ),
                ],
              );
            } else {
              debugPrint('购物车 有数据 为空');
              return Center(
                child: Text(
                  '当前购物车为空',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(30),
                    color: Colors.black12,
                  ),
                ),
              );
            }
          } else {
            debugPrint('购物车 没有数据');
            return Center(
              child: Text(
                '当前购物车为空',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(30),
                  color: Colors.black12,
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Future<String> _getCartGoods(BuildContext context) async {
    await Provide.value<CartProvide>(context).getCartInfoGoods();
    return "完成加载";
  }
}

```

## 第55节:购物车_制作底部结算栏的UI


### 购物车结算页面定义
```
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.all(5.0),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          _checkBoxAll(),
          _allPrice(),
          _allPayAll(),
          //_goPayAll(),
        ],
      ),
    );
  }

  // 全选
  Widget _checkBoxAll() {
    return Container(
      child: Row(
        children: <Widget>[
          Checkbox(
            onChanged: (value) {
              debugPrint('点击全选');
            },
            value: true,
            activeColor: Colors.pink,
            checkColor: Colors.white,
          ),
          Text(
            '全选',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: ScreenUtil().setSp(24),
            ),
          ),
        ],
      ),
    );
  }

  // 价格
  Widget _allPrice() {
    return Container(
      width: ScreenUtil().setWidth(400),
      alignment: Alignment.centerRight,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                child: Text(
                  '合计：',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(24),
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: Text(
                  '￥1992',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(30),
                    color: Colors.redAccent,
                  ),
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              '满10元免配送费，预购免配送费',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(22),
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 结算
  Widget _allPayAll() {
    return Container(
      width: ScreenUtil().setWidth(150),
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 10),
      child: MaterialButton(
        onPressed: () {},
        child: Text(
          '结算(6)',
        ),
        color: Colors.red,
        textColor: Colors.white,
      ),
    );
  }

  // 或者自己做button
  Widget _goPayAll() {
    return Container(
      width: ScreenUtil().setWidth(150),
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 10),
      child: InkWell(
        onTap: () {
          debugPrint('自己画button');
        },
        child: Container(
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.all(
              Radius.circular(3),
            ),
          ),
          child: Text(
            '结算(6)',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

```

### 页面调用

```
import 'package:flutter/material.dart';
import 'package:flutter_shop_mall/model/cartInfoModel.dart';
import 'package:flutter_shop_mall/provide/cart_provide.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_shop_mall/pages/cart_page/cart_item.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品购物车'),
      ),
      body: FutureBuilder(
        future: _getCartGoods(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            debugPrint('购物车 有数据');
            List<CartInfoModel> listCartGoods =
                Provide.value<CartProvide>(context).cartInfoList;
            if (listCartGoods != null && listCartGoods.length > 0) {
              debugPrint('购物车 有数据 不为空');
              return Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black12,
                              width: 1,
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),
                        height: ScreenUtil().setHeight(1),
                      ),
                      Expanded(
                        flex: 2,
                        child: ListView.builder(
                          itemCount: listCartGoods.length,
                          itemBuilder: (context, index) {
                            return CartItem(listCartGoods[index]);
                          },
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: CartBottom(),
                  ),
                ],
              );
            } else {
              debugPrint('购物车 有数据 为空');
              return Center(
                child: Text(
                  '当前购物车为空',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(30),
                    color: Colors.black12,
                  ),
                ),
              );
            }
          } else {
            debugPrint('购物车 没有数据');
            return Center(
              child: Text(
                '当前购物车为空',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(30),
                  color: Colors.black12,
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Future<String> _getCartGoods(BuildContext context) async {
    await Provide.value<CartProvide>(context).getCartInfoGoods();
    return "完成加载";
  }
}

```


## 第56节：购物车_制作数量加减按钮UI

### 构建增加数据控件

```
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartCount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(165),
      margin: EdgeInsets.only(top: 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.black12,
          width: 1,
        ),
      ),
      child: Row(
        children: <Widget>[
          _reduceBtn(),
          _addNumCount(),
          _addBtn(),
        ],
      ),
    );
  }

  // 减少
  Widget _reduceBtn() {
    return InkWell(
      onTap: () {
        debugPrint('减少数据');
      },
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setWidth(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.black12,
          border: Border(
            right: BorderSide(
              color: Colors.white,
              width: 1,
            ),
          ),
        ),
        child: Text('-'),
      ),
    );
  }

  // 增加
  Widget _addBtn() {
    return InkWell(
      onTap: () {
        debugPrint('增加数据');
      },
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setWidth(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.black12,
          border: Border(
            left: BorderSide(
              color: Colors.white,
              width: 1,
            ),
          ),
        ),
        child: Text('+'),
      ),
    );
  }

  // 数字
  Widget _addNumCount() {
    return Container(
      width: ScreenUtil().setWidth(71),
      height: ScreenUtil().setWidth(45),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Text('12'),
    );
  }
}

```

### car_item 调用

```
注意 在主轴方向的调用 crossAxisAlignment: CrossAxisAlignment.start,

// 商品名称
  Widget _cartGoodsNameCount() {
    return Container(
      width: ScreenUtil().setWidth(300),
      padding: EdgeInsets.all(10),
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            cartInfoModel.goodsName,
            style: TextStyle(
              fontSize: ScreenUtil().setSp(28),
              color: Colors.black,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.left,
          ),
          CartCount(),
        ],
      ),
    );
  }
```


## 第57节：购物车_在Model中增加选中字段

### 修改购物车的实力类

```
class CartInfoModel {
  String goodsId;
  String goodsName;
  int count;
  double price;
  double oriPrice;
  String images;
  bool isCheck;

  CartInfoModel(
      {this.goodsId, this.goodsName, this.count, this.price,this.oriPrice, this.images,this.isCheck});

  CartInfoModel.fromJson(Map<String, dynamic> json) {
    goodsId = json['goodsId'];
    goodsName = json['goodsName'];
    count = json['count'];
    price = json['price'];
    oriPrice = json['oriPrice'];
    images = json['images'];
    isCheck = json['isCheck'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['goodsId'] = this.goodsId;
    data['goodsName'] = this.goodsName;
    data['count'] = this.count;
    data['price'] = this.price;
    data['oriPrice'] = this.oriPrice;
    data['images'] = this.images;
    data['isCheck'] = this.isCheck;
    return data;
  }
}

```

## 第58节：购物车_删除单个商品功能制作


### 添加删除状态管理
```
import 'package:flutter/material.dart';
import 'package:flutter_shop_mall/model/cartInfoModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartProvide extends ChangeNotifier {
  String cartGoodsStr = "[]";
  List<CartInfoModel> cartInfoList = [];

  void save(String goodsId, String goodsName, int count, double presentPrice,
      double oriPrice, String images) async {
    // 初始化SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // 获取数据
    cartGoodsStr = prefs.getString('cartInfo');
    debugPrint('cartGoodsStr 值  $cartGoodsStr');
    // 判断cartString是否为空，为空说明是第一次添加，或者被key被清除了。
    // 如果有值进行decode操作
    var temp = cartGoodsStr == null ? [] : json.decode(cartGoodsStr.toString());
    List<Map> tampList = (temp as List).cast();
    // 如果数据不为空，那么需要给 cartInfoList 添加数据
    if (tampList != null && tampList.length > 0) {
      tampList.forEach((item) {
        cartInfoList.add(new CartInfoModel.fromJson(item));
      });
    }

    // 判断是否存在当前商品
    bool isHaveThisGoods = false;

    // 用于进行循环的索引使用
    int ival = 0;
    // 进行循环，找出是否已经存在该商品
    tampList.forEach((item) {
      debugPrint('ival 前 $ival');
      // 如果存在，数量进行+1操作
      if (item['goodsId'] == goodsId) {
        debugPrint('有一样的数据，+1');
        tampList[ival]['count'] = item['count'] + 1;
        cartInfoList[ival].count++;
        isHaveThisGoods = true;
      }
      ival++;
    });

    debugPrint('ival 后 $ival');

    //  如果没有，进行增加
    if (!isHaveThisGoods) {
      Map<String, dynamic> newGoods = {
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': presentPrice,
        'oriPrice': oriPrice,
        'images': images,
        'isCheck': true
      };
      tampList.add(newGoods);
      cartInfoList.add(CartInfoModel.fromJson(newGoods));
    }

    //把字符串进行encode操作，
    cartGoodsStr = json.encode(tampList).toString();
    debugPrint('持久化数据 字符串 $cartGoodsStr');
    debugPrint('持久化数据 列表 $cartInfoList');
    prefs.setString('cartInfo', cartGoodsStr); //进行持久化
  }

  // 清空
  void remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.clear();//清空键值对
    prefs.remove('cartInfo');
    // 置空数据
    cartInfoList = [];
    debugPrint('清空完成-----------------');
    notifyListeners();
  }

  // 得到购物车中的商品
  getCartInfoGoods() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var cartInfoStr = prefs.getString('cartInfo');
    //把cartList进行初始化，防止数据混乱
    cartInfoList = [];

    // 判断得到的字符串是否有值，如果不判断会报错
    if (cartInfoStr == null) {
      cartInfoList = [];
    } else {
      var cartInfoJson = json.decode(cartInfoStr.toString());
      List<Map> tampList = (cartInfoJson as List).cast();
      tampList.forEach((item) {
        cartInfoList.add(new CartInfoModel.fromJson(item));
      });
    }
    notifyListeners();
  }

  // 删除购物车数据
  deleteCartInfoGoods(String goodsId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var cartInfoStr = prefs.getString('cartInfo');
    var cartInfoJson = json.decode(cartInfoStr.toString());
    List<Map> tampList = (cartInfoJson as List).cast();

    // 用于进行循环的索引使用
    int ival = 0;
    int delIndex = 0;
    // 进行循环，找出是否已经存在该商品
    tampList.forEach((item) {
      // 如果存在，数量进行+1操作
      if (item['goodsId'] == goodsId) {
        delIndex = ival;
      }
      ival++;
    });
    tampList.removeAt(delIndex);
    cartGoodsStr = json.encode(tampList).toString();
    prefs.setString('cartInfo', cartGoodsStr); //进行持久化
    await getCartInfoGoods();
  }
}

```

### 删除调用

```
// 商品价钱
  Widget _cartGoodsPrice(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(150),
      child: Column(
        children: <Widget>[
          Text(
            '￥${cartInfoModel.price}',
            style: TextStyle(
              fontSize: ScreenUtil().setSp(24),
              color: Colors.black,
            ),
          ),
          Text(
            '￥${cartInfoModel.oriPrice}',
            style: TextStyle(
              fontSize: ScreenUtil().setSp(24),
              color: Colors.black26,
              decoration: TextDecoration.lineThrough,
            ),
          ),
          InkWell(
            onTap: () {
              debugPrint('删除数据');
              Provide.value<CartProvide>(context)
                  .deleteCartInfoGoods(cartInfoModel.goodsId);
            },
            child: Icon(
              Icons.delete,
              color: Colors.black12,
              size: 30,
            ),
          ),
        ],
      ),
    );
```

### 删除购物车的商品，需要更新购物车
```

import 'package:flutter/material.dart';
import 'package:flutter_shop_mall/model/cartInfoModel.dart';
import 'package:flutter_shop_mall/provide/cart_provide.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop_mall/pages/cart_page/cart_item.dart';

import 'cart_page/cart_bottom.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品购物车'),
      ),
      body: FutureBuilder(
        future: _getCartGoods(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            debugPrint('购物车 有数据');
            List<CartInfoModel> listCartGoods =
                Provide.value<CartProvide>(context).cartInfoList;
            if (listCartGoods != null && listCartGoods.length > 0) {
              debugPrint('购物车 有数据 不为空');
              return Stack(
                children: <Widget>[
                  Provide<CartProvide>(
                    builder: (context, child, cartProvide) {
                      listCartGoods =
                          Provide.value<CartProvide>(context).cartInfoList;
                      if (listCartGoods != null && listCartGoods.length > 0) {
                        return Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.black12,
                                    width: 1,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                              ),
                              height: ScreenUtil().setHeight(1),
                            ),
                            Expanded(
                              flex: 2,
                              child: ListView.builder(
                                itemCount: listCartGoods.length,
                                itemBuilder: (context, index) {
                                  return CartItem(listCartGoods[index]);
                                },
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Center(
                          child: Text(
                            '当前购物车为空',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(30),
                              color: Colors.black12,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: CartBottom(),
                  ),
                ],
              );
            } else {
              debugPrint('购物车 有数据 为空');
              return Center(
                child: Text(
                  '当前购物车为空',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(30),
                    color: Colors.black12,
                  ),
                ),
              );
            }
          } else {
            debugPrint('购物车 没有数据');
            return Center(
              child: Text(
                '当前购物车为空',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(30),
                  color: Colors.black12,
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Future<String> _getCartGoods(BuildContext context) async {
    await Provide.value<CartProvide>(context).getCartInfoGoods();
    return "完成加载";
  }
}

```

## 第59节：购物车_计算商品价格和数量

### 价格和数量状态管理

```
import 'package:flutter/material.dart';
import 'package:flutter_shop_mall/model/cartInfoModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartProvide extends ChangeNotifier {
  String cartGoodsStr = "[]";
  List<CartInfoModel> cartInfoList = [];
  double allPrice = 0;
  int allGoodsCount = 0;

  void save(String goodsId, String goodsName, int count, double presentPrice,
      double oriPrice, String images) async {
    // 初始化SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // 获取数据
    cartGoodsStr = prefs.getString('cartInfo');
    debugPrint('cartGoodsStr 值  $cartGoodsStr');
    // 判断cartString是否为空，为空说明是第一次添加，或者被key被清除了。
    // 如果有值进行decode操作
    var temp = cartGoodsStr == null ? [] : json.decode(cartGoodsStr.toString());
    List<Map> tampList = (temp as List).cast();
    // 如果数据不为空，那么需要给 cartInfoList 添加数据
    if (tampList != null && tampList.length > 0) {
      tampList.forEach((item) {
        cartInfoList.add(new CartInfoModel.fromJson(item));
      });
    }

    // 判断是否存在当前商品
    bool isHaveThisGoods = false;

    // 用于进行循环的索引使用
    int ival = 0;
    // 进行循环，找出是否已经存在该商品
    tampList.forEach((item) {
      debugPrint('ival 前 $ival');
      // 如果存在，数量进行+1操作
      if (item['goodsId'] == goodsId) {
        debugPrint('有一样的数据，+1');
        tampList[ival]['count'] = item['count'] + 1;
        cartInfoList[ival].count++;
        isHaveThisGoods = true;
      }
      ival++;
    });

    debugPrint('ival 后 $ival');

    //  如果没有，进行增加
    if (!isHaveThisGoods) {
      Map<String, dynamic> newGoods = {
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': presentPrice,
        'oriPrice': oriPrice,
        'images': images,
        'isCheck': true
      };
      tampList.add(newGoods);
      cartInfoList.add(CartInfoModel.fromJson(newGoods));
    }

    //把字符串进行encode操作，
    cartGoodsStr = json.encode(tampList).toString();
    debugPrint('持久化数据 字符串 $cartGoodsStr');
    debugPrint('持久化数据 列表 $cartInfoList');
    prefs.setString('cartInfo', cartGoodsStr); //进行持久化
  }

  // 清空
  void remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.clear();//清空键值对
    prefs.remove('cartInfo');
    // 置空数据
    cartInfoList = [];
    debugPrint('清空完成-----------------');
    notifyListeners();
  }

  // 得到购物车中的商品
  getCartInfoGoods() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var cartInfoStr = prefs.getString('cartInfo');
    //把cartList进行初始化，防止数据混乱
    cartInfoList = [];

    // 判断得到的字符串是否有值，如果不判断会报错
    if (cartInfoStr == null) {
      cartInfoList = [];
    } else {
      allPrice = 0;
      allGoodsCount = 0;
      var cartInfoJson = json.decode(cartInfoStr.toString());
      List<Map> tampList = (cartInfoJson as List).cast();
      tampList.forEach((item) {
        if(item['isCheck']){
          allPrice+= item['count']*item['price'];
          allGoodsCount += item['count'];
        }
        cartInfoList.add(new CartInfoModel.fromJson(item));
      });
    }
    notifyListeners();
  }

  // 删除购物车数据
  deleteCartInfoGoods(String goodsId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var cartInfoStr = prefs.getString('cartInfo');
    var cartInfoJson = json.decode(cartInfoStr.toString());
    List<Map> tampList = (cartInfoJson as List).cast();

    // 用于进行循环的索引使用
    int ival = 0;
    int delIndex = 0;
    // 进行循环，找出是否已经存在该商品
    tampList.forEach((item) {
      // 如果存在，数量进行+1操作
      if (item['goodsId'] == goodsId) {
        delIndex = ival;
      }
      ival++;
    });
    tampList.removeAt(delIndex);
    cartGoodsStr = json.encode(tampList).toString();
    prefs.setString('cartInfo', cartGoodsStr); //进行持久化
    await getCartInfoGoods();
  }
}

```

### 底部结算

```
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop_mall/provide/cart_provide.dart';
import 'package:provide/provide.dart';

class CartBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.all(5.0),
      color: Colors.white,
      child: Provide<CartProvide>(
        builder: (context, child, cartProvide) {
          return Row(
            children: <Widget>[
              _checkBoxAll(context),
              _allPrice(context),
              _allPayAll(context),
              //_goPayAll(),
            ],
          );
        },
      ),
    );
  }

  // 全选
  Widget _checkBoxAll(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Checkbox(
            onChanged: (value) {
              debugPrint('点击全选');
            },
            value: true,
            activeColor: Colors.pink,
            checkColor: Colors.white,
          ),
          Text(
            '全选',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: ScreenUtil().setSp(24),
            ),
          ),
        ],
      ),
    );
  }

  // 价格
  Widget _allPrice(BuildContext context) {
    double allPrice = Provide.value<CartProvide>(context).allPrice;
    return Container(
      width: ScreenUtil().setWidth(400),
      alignment: Alignment.centerRight,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                child: Text(
                  '合计：',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(24),
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: Text(
                  '￥$allPrice',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(30),
                    color: Colors.redAccent,
                  ),
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              '满10元免配送费，预购免配送费',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(22),
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 结算
  Widget _allPayAll(BuildContext context) {
    int allGoodsCount = Provide.value<CartProvide>(context).allGoodsCount;

    return Container(
      width: ScreenUtil().setWidth(150),
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 10),
      child: MaterialButton(
        onPressed: () {},
        child: Text(
          '结算($allGoodsCount)',
        ),
        color: Colors.red,
        textColor: Colors.white,
      ),
    );
  }

  // 或者自己做button
  Widget _goPayAll() {
    return Container(
      width: ScreenUtil().setWidth(150),
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 10),
      child: InkWell(
        onTap: () {
          debugPrint('自己画button');
        },
        child: Container(
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.all(
              Radius.circular(3),
            ),
          ),
          child: Text(
            '结算(6)',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

```

## 第60节：购物车_商品选中功能制作

### 商品的选择按钮和全选按钮的状态管理

```
import 'package:flutter/material.dart';
import 'package:flutter_shop_mall/model/cartInfoModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartProvide extends ChangeNotifier {
  String cartGoodsStr = "[]";
  List<CartInfoModel> cartInfoList = [];
  double allPrice = 0;
  int allGoodsCount = 0;
  bool isAllChecked = true; // 全选，默认是true

  void save(String goodsId, String goodsName, int count, double presentPrice,
      double oriPrice, String images) async {
    // 初始化SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // 获取数据
    cartGoodsStr = prefs.getString('cartInfo');
    debugPrint('cartGoodsStr 值  $cartGoodsStr');
    // 判断cartString是否为空，为空说明是第一次添加，或者被key被清除了。
    // 如果有值进行decode操作
    var temp = cartGoodsStr == null ? [] : json.decode(cartGoodsStr.toString());
    List<Map> tampList = (temp as List).cast();
    // 如果数据不为空，那么需要给 cartInfoList 添加数据
    if (tampList != null && tampList.length > 0) {
      tampList.forEach((item) {
        cartInfoList.add(new CartInfoModel.fromJson(item));
      });
    }

    // 判断是否存在当前商品
    bool isHaveThisGoods = false;

    // 用于进行循环的索引使用
    int ival = 0;
    // 进行循环，找出是否已经存在该商品
    tampList.forEach((item) {
      debugPrint('ival 前 $ival');
      // 如果存在，数量进行+1操作
      if (item['goodsId'] == goodsId) {
        debugPrint('有一样的数据，+1');
        tampList[ival]['count'] = item['count'] + 1;
        cartInfoList[ival].count++;
        isHaveThisGoods = true;
      }
      ival++;
    });

    debugPrint('ival 后 $ival');

    //  如果没有，进行增加
    if (!isHaveThisGoods) {
      Map<String, dynamic> newGoods = {
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': presentPrice,
        'oriPrice': oriPrice,
        'images': images,
        'isCheck': true
      };
      tampList.add(newGoods);
      cartInfoList.add(CartInfoModel.fromJson(newGoods));
    }

    //把字符串进行encode操作，
    cartGoodsStr = json.encode(tampList).toString();
    debugPrint('持久化数据 字符串 $cartGoodsStr');
    debugPrint('持久化数据 列表 $cartInfoList');
    prefs.setString('cartInfo', cartGoodsStr); //进行持久化
  }

  // 清空
  void remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.clear();//清空键值对
    prefs.remove('cartInfo');
    // 置空数据
    cartInfoList = [];
    debugPrint('清空完成-----------------');
    notifyListeners();
  }

  // 得到购物车中的商品
  getCartInfoGoods() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var cartInfoStr = prefs.getString('cartInfo');
    //把cartList进行初始化，防止数据混乱
    cartInfoList = [];

    // 判断得到的字符串是否有值，如果不判断会报错
    if (cartInfoStr == null) {
      cartInfoList = [];
    } else {
      allPrice = 0;
      allGoodsCount = 0;
      isAllChecked = true;
      var cartInfoJson = json.decode(cartInfoStr.toString());
      List<Map> tampList = (cartInfoJson as List).cast();
      tampList.forEach((item) {
        if (item['isCheck']) {
          allPrice += item['count'] * item['price'];
          allGoodsCount += item['count'];
        } else {
          isAllChecked = false;
        }
        cartInfoList.add(new CartInfoModel.fromJson(item));
      });
    }
    notifyListeners();
  }

  // 删除购物车数据
  deleteCartInfoGoods(String goodsId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var cartInfoStr = prefs.getString('cartInfo');
    var cartInfoJson = json.decode(cartInfoStr.toString());
    List<Map> tampList = (cartInfoJson as List).cast();

    // 用于进行循环的索引使用
    int ival = 0;
    int delIndex = 0;
    // 进行循环，找出是否已经存在该商品
    tampList.forEach((item) {
      // 如果存在，数量进行+1操作
      if (item['goodsId'] == goodsId) {
        delIndex = ival;
      }
      ival++;
    });
    tampList.removeAt(delIndex);
    cartGoodsStr = json.encode(tampList).toString();
    prefs.setString('cartInfo', cartGoodsStr); //进行持久化
    await getCartInfoGoods();
  }

  // 修改购物车选择状态
  checkCartInfoGoodsState(CartInfoModel cartInfoGoods) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var cartInfoStr = prefs.getString('cartInfo');
    var cartInfoJson = json.decode(cartInfoStr.toString());
    List<Map> tampList = (cartInfoJson as List).cast();

    int tempIndex = 0;
    int currentIndex = 0;

    tampList.forEach((item) {
      if (item['goodsId'] == cartInfoGoods.goodsId) {
        //找到索引进行复制
        currentIndex = tempIndex;
      }
      tempIndex++;
    });
    tampList[currentIndex] = cartInfoGoods.toJson(); //把对象变成Map值
    cartGoodsStr = json.encode(tampList).toString();
    prefs.setString('cartInfo', cartGoodsStr); //进行持久化
    await getCartInfoGoods();
  }

  //点击全选按钮操作
  checkAllGoodsState(bool isCheck) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var cartInfoStr = prefs.getString('cartInfo');
    var cartInfoJson = json.decode(cartInfoStr.toString());
    List<Map> tampList = (cartInfoJson as List).cast();
    // Dart不让循环时修改原值
    /*tampList.forEach((item) {
      item['isCheck'] = true;
    });
    cartGoodsStr = json.encode(tampList).toString();
    */
    List<Map> newList = new List();
    for(var item in tampList){
      var newItem = item; // /复制新的变量，因为Dart不让循环时修改原值
      newItem['isCheck'] = isCheck;
      newList.add(newItem);
    }
    cartGoodsStr = json.encode(newList).toString();
    prefs.setString('cartInfo', cartGoodsStr); //进行持久化
    await getCartInfoGoods();
  }
}

```

### 商品单个调用

```
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop_mall/model/cartInfoModel.dart';
import 'package:flutter_shop_mall/provide/cart_provide.dart';
import 'package:provide/provide.dart';

import 'cart_count.dart';

class CartItem extends StatelessWidget {
  CartInfoModel cartInfoModel;

  CartItem(this.cartInfoModel);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 2.0, 5.0, 2.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.black12,
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
      ),
      child: Row(
        children: <Widget>[
          _checkBoxCartGoods(context),
          _imageCartGoods(),
          _cartGoodsNameCount(),
          _cartGoodsPrice(context),
        ],
      ),
    );
  }

  // 复选框
  Widget _checkBoxCartGoods(BuildContext context) {
    return Container(
      child: Checkbox(
        value: cartInfoModel.isCheck,
        onChanged: (value) {
          debugPrint('点击$value');
          cartInfoModel.isCheck = value;
          Provide.value<CartProvide>(context)
              .checkCartInfoGoodsState(cartInfoModel);
        },
        checkColor: Colors.white,
        activeColor: Colors.pink,
      ),
    );
  }

  // 图片
  Widget _imageCartGoods() {
    return Container(
      width: ScreenUtil().setWidth(150),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.black12),
      ),
      child: Image.network(cartInfoModel.images),
    );
  }

  // 商品名称
  Widget _cartGoodsNameCount() {
    return Container(
      width: ScreenUtil().setWidth(300),
      padding: EdgeInsets.all(10),
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            cartInfoModel.goodsName,
            style: TextStyle(
              fontSize: ScreenUtil().setSp(28),
              color: Colors.black,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.left,
          ),
          CartCount(),
        ],
      ),
    );
  }

  // 商品价钱
  Widget _cartGoodsPrice(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(150),
      child: Column(
        children: <Widget>[
          Text(
            '￥${cartInfoModel.price}',
            style: TextStyle(
              fontSize: ScreenUtil().setSp(24),
              color: Colors.black,
            ),
          ),
          Text(
            '￥${cartInfoModel.oriPrice}',
            style: TextStyle(
              fontSize: ScreenUtil().setSp(24),
              color: Colors.black26,
              decoration: TextDecoration.lineThrough,
            ),
          ),
          InkWell(
            onTap: () {
              debugPrint('删除数据');
              showDeleteDialog(context);
              /*Provide.value<CartProvide>(context)
                  .deleteCartInfoGoods(cartInfoModel.goodsId);*/
            },
            child: Icon(
              Icons.delete,
              color: Colors.black12,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }

  void showDeleteDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('删除提示'),
          content: Text('您确定要删除“${cartInfoModel.goodsName}”这个商品么？'),
          actions: <Widget>[
            FlatButton(
              child: Text('取消'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('确定'),
              onPressed: () {
                Navigator.of(context).pop();
                Provide.value<CartProvide>(context)
                    .deleteCartInfoGoods(cartInfoModel.goodsId);
              },
            ),
          ],
        );
      },
    );
  }
}

```


### 商品全部调用

```
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop_mall/provide/cart_provide.dart';
import 'package:provide/provide.dart';

class CartBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.all(5.0),
      color: Colors.white,
      child: Provide<CartProvide>(
        builder: (context, child, cartProvide) {
          return Row(
            children: <Widget>[
              _checkBoxAll(context),
              _allPrice(context),
              _allPayAll(context),
              //_goPayAll(),
            ],
          );
        },
      ),
    );
  }

  // 全选
  Widget _checkBoxAll(BuildContext context) {
    return Provide<CartProvide>(
      builder: (context, child, carProvide) {
        return Container(
          child: Row(
            children: <Widget>[
              Checkbox(
                onChanged: (value) {
                  debugPrint('点击全选 $value');
                  carProvide.checkAllGoodsState(value);
                },
                value: carProvide.isAllChecked,
                activeColor: Colors.pink,
                checkColor: Colors.white,
              ),
              Text(
                '全选',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: ScreenUtil().setSp(24),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // 价格
  Widget _allPrice(BuildContext context) {
    double allPrice = Provide.value<CartProvide>(context).allPrice;
    return Container(
      width: ScreenUtil().setWidth(400),
      alignment: Alignment.centerRight,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                child: Text(
                  '合计：',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(24),
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: Text(
                  '￥$allPrice',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(30),
                    color: Colors.redAccent,
                  ),
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              '满10元免配送费，预购免配送费',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(22),
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 结算
  Widget _allPayAll(BuildContext context) {
    int allGoodsCount = Provide.value<CartProvide>(context).allGoodsCount;

    return Container(
      width: ScreenUtil().setWidth(150),
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 10),
      child: MaterialButton(
        onPressed: () {},
        child: Text(
          '结算($allGoodsCount)',
        ),
        color: Colors.red,
        textColor: Colors.white,
      ),
    );
  }

  // 或者自己做button
  Widget _goPayAll() {
    return Container(
      width: ScreenUtil().setWidth(150),
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 10),
      child: InkWell(
        onTap: () {
          debugPrint('自己画button');
        },
        child: Container(
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.all(
              Radius.circular(3),
            ),
          ),
          child: Text(
            '结算(6)',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

```

### 购物车页面优化

```
import 'package:flutter/material.dart';
import 'package:flutter_shop_mall/model/cartInfoModel.dart';
import 'package:flutter_shop_mall/provide/cart_provide.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop_mall/pages/cart_page/cart_item.dart';

import 'cart_page/cart_bottom.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品购物车'),
      ),
      body: FutureBuilder(
        future: _getCartGoods(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            debugPrint('购物车 有数据');
            return Provide<CartProvide>(
              builder: (context, child, cartProvide) {
                List<CartInfoModel> listCartGoods =
                    Provide.value<CartProvide>(context).cartInfoList;
                if (listCartGoods != null && listCartGoods.length > 0) {
                  debugPrint('购物车 有数据 不为空');
                  return Stack(children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.black12,
                                width: 1,
                                style: BorderStyle.solid,
                              ),
                            ),
                          ),
                          height: ScreenUtil().setHeight(1),
                        ),
                        Expanded(
                          flex: 2,
                          child: ListView.builder(
                            itemCount: listCartGoods.length,
                            itemBuilder: (context, index) {
                              return CartItem(listCartGoods[index]);
                            },
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: CartBottom(),
                    ),
                  ]);
                } else {
                  return Center(
                    child: Text(
                      '当前购物车为空',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(30),
                        color: Colors.black12,
                      ),
                    ),
                  );
                }
              },
            );
          } else {
            debugPrint('购物车 没有数据');
            return Center(
              child: Text(
                '当前购物车为空',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(30),
                  color: Colors.black12,
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Future<String> _getCartGoods(BuildContext context) async {
    await Provide.value<CartProvide>(context).getCartInfoGoods();
    return "完成加载";
  }
}

```

## 第61节：购物车_商品数量的加减操作

### 加减操作状态管理

```
// 增加和减少的操作
goodsCountReduceAndAdd(CartInfoModel cartInfoGoods, String todo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var cartInfoStr = prefs.getString('cartInfo');
    var cartInfoJson = json.decode(cartInfoStr.toString());
    List<Map> tampList = (cartInfoJson as List).cast();

    int tempIndex = 0;
    int currentIndex = 0;

    tampList.forEach((item) {
      if (item['goodsId'] == cartInfoGoods.goodsId) {
        currentIndex = tempIndex;
      }
      tempIndex++;
    });

    if (todo == "add") {
      cartInfoGoods.count++;
    } else if (cartInfoGoods.count > 1) {
      cartInfoGoods.count--;
    }

    tampList[currentIndex] = cartInfoGoods.toJson();
    cartGoodsStr = json.encode(tampList).toString();
    prefs.setString('cartInfo', cartGoodsStr); //进行持久化
    await getCartInfoGoods();
}
```

### 商品数量触发
```
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop_mall/model/cartInfoModel.dart';
import 'package:flutter_shop_mall/provide/cart_provide.dart';
import 'package:provide/provide.dart';

class CartCount extends StatelessWidget {
  final CartInfoModel cartInfoModel;

  CartCount(this.cartInfoModel);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(165),
      margin: EdgeInsets.only(top: 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.black12,
          width: 1,
        ),
      ),
      child: Row(
        children: <Widget>[
          _reduceBtn(context),
          _addNumCount(),
          _addBtn(context),
        ],
      ),
    );
  }

  // 减少
  Widget _reduceBtn(BuildContext context) {
    return InkWell(
      onTap: () {
        if (cartInfoModel.count > 1) {
          debugPrint('减少数据');
          Provide.value<CartProvide>(context)
              .goodsCountReduceAndAdd(cartInfoModel, 'reduce');
        }
      },
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setWidth(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: cartInfoModel.count > 1 ? Colors.white : Colors.black12,
          border: Border(
            right: BorderSide(
              color: Colors.black12,
              width: 1,
            ),
          ),
        ),
        child: cartInfoModel.count > 1 ? Text('-') : Text(' '),
      ),
    );
  }

  // 增加
  Widget _addBtn(BuildContext context) {
    return InkWell(
      onTap: () {
        debugPrint('增加数据');
        Provide.value<CartProvide>(context)
            .goodsCountReduceAndAdd(cartInfoModel, 'add');
      },
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setWidth(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.black12,
          border: Border(
            left: BorderSide(
              color: Colors.white,
              width: 1,
            ),
          ),
        ),
        child: Text('+'),
      ),
    );
  }

  // 数字
  Widget _addNumCount() {
    return Container(
      width: ScreenUtil().setWidth(71),
      height: ScreenUtil().setWidth(45),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Text('${cartInfoModel.count}'),
    );
  }
}

```

## 第62节：购物车_首页Provide化 让跳转随心所欲


### 首页状态管理
```
import 'package:flutter/material.dart';

class CurrentIndexProvide extends ChangeNotifier {
  int currentIndex = 0;

  changeCurrentIndex(int newIndex) {
    currentIndex = newIndex;
    notifyListeners();
  }
}

```

### 主入口文件
```
import 'package:flutter/material.dart';
import 'package:flutter_shop_mall/provide/cart_provide.dart';
import 'package:flutter_shop_mall/provide/current_index_provide.dart';
import 'package:flutter_shop_mall/provide/details_goods_provide.dart';
import 'package:flutter_shop_mall/routers/application.dart';
import 'package:flutter_shop_mall/routers/routers.dart';
import './pages/index_page.dart';
import 'package:provide/provide.dart';
import 'provide/counter_provide.dart';
import 'provide/child_category_provide.dart';
import 'provide/category_list_provide.dart';
import 'package:fluro/fluro.dart';

void main() {
  var counter = CounterProvide(0);
  var childCategory = ChildCategoryProvide();
  var categoryGoodsListProvide = CategoryListProvide();
  var detailsGoodsProvide = DetailsGoodsProvide();
  var cartProvide = CartProvide();
  var currentIndexProvide = CurrentIndexProvide();
  var providers = Providers()
    ..provide(Provider<CounterProvide>.value(counter))
    ..provide(Provider<ChildCategoryProvide>.value(childCategory))
    ..provide(Provider.function((context) => categoryGoodsListProvide))
    ..provide(Provider.function((context) => detailsGoodsProvide))
    ..provide(Provider.function((context) => cartProvide))
    ..provide(Provider.function((context) => currentIndexProvide));
  runApp(ProviderNode(
    child: MyApp(),
    providers: providers,
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 路由配置
    var router = new Router();
    Routers.configureRouters(router);
    Application.router = router;

    return Container(
      child: MaterialApp(
        title: '百姓生活+',
        // 配置路由
        onGenerateRoute: Application.router.generator,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.pink,
        ),
        home: IndexPage(),
      ),
    );
  }
}

```

### index 状态管理

```
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_shop_mall/provide/current_index_provide.dart';
import 'package:provide/provide.dart';
import 'home_page.dart';
import 'category_page.dart';
import 'cart_page.dart';
import 'member_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IndexPage extends StatelessWidget {
  final List<BottomNavigationBarItem> bottomBars = [
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.home),
      title: Text('首页'),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.search),
      title: Text('分类'),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.shopping_cart),
      title: Text('购物车'),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.profile_circled),
      title: Text('首页'),
    ),
  ];

  final List<Widget> tabBodies = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage(),
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Provide<CurrentIndexProvide>(
      builder: (context, child, currentIndexProvide) {
        int _currentIndex = currentIndexProvide.currentIndex;
        return Scaffold(
          backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
          // 保持页面状态
          body: IndexedStack(
            children: tabBodies,
            index: _currentIndex,
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: bottomBars,
            currentIndex: _currentIndex,
            onTap: (index) {
              Provide.value<CurrentIndexProvide>(context).changeCurrentIndex(index);
            },
          ),
        );
      },
    );
  }
}
```

### 商品详细页面添加购物车跳转

```
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop_mall/provide/cart_provide.dart';
import 'package:flutter_shop_mall/provide/current_index_provide.dart';
import 'package:flutter_shop_mall/provide/details_goods_provide.dart';
import 'package:provide/provide.dart';

class DetailsBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var goodsInfo =
        Provide.value<DetailsGoodsProvide>(context).detailsGoods.data.goodInfo;
    var goodsId = goodsInfo.goodsId;
    var goodsName = goodsInfo.goodsName;
    var count = 1;
    var presentPrice = goodsInfo.presentPrice;
    var oriPrice = goodsInfo.oriPrice;
    var images = goodsInfo.image1;

    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(100),
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: () {
              debugPrint('点击购物车');
              Provide.value<CurrentIndexProvide>(context).changeCurrentIndex(2);
              Navigator.pop(context);
            },
            child: Container(
              height: ScreenUtil().setHeight(100),
              width: ScreenUtil().setHeight(110),
              color: Colors.white,
              child: Icon(
                Icons.shopping_cart,
                size: 30,
                color: Colors.pink,
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              debugPrint('加入购物车');
              Provide.value<CartProvide>(context).save(
                  goodsId, goodsName, count, presentPrice, oriPrice, images);
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('添加购物车成功！'),
                action: SnackBarAction(
                  label: 'ok',
                  onPressed: () {},
                ),
              ));
            },
            child: Container(
              height: ScreenUtil().setHeight(100),
              width: ScreenUtil().setHeight(320),
              color: Colors.green,
              alignment: Alignment(0, 0),
              child: Text(
                '加入购物车',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(30),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              debugPrint('立即购买');
              Provide.value<CartProvide>(context).remove();
            },
            child: Container(
              height: ScreenUtil().setHeight(100),
              width: ScreenUtil().setHeight(320),
              color: Colors.red,
              alignment: Alignment(0, 0),
              child: Text(
                '立即购买',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(30),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

```

## 后端接口API文档


### 商城首页基本信息
说明：调用此接口，可获取首页所有的基本信息，包括导航，推荐商品，楼层商品。


- 参数：lon，lat 

- 接口地址：wxmini/homePageContent

- 返回参数：
1. advertesPicture:首页中部广告条。
2. category：首页UI分类信息
3. floor1:楼层1的商品信息和图片
4. floor2:楼层2的商品详细和图片
5. floor3:楼层3的商品详细和图片
6. recommend:商品推荐的信息
7. slides:滑动图片和对应的商品编号
8. shopInfo：根据定位获得的门店图片和店长电话

**Post**

http://v.jspang.com:8088/baixing/wxmini/homePageContent

{
    "lon": "115.02932",
    "lat": "35.76189",
};

```

{
    "code":"0",
    "message":"success",
    "data":{
        "slides":[
            {
                "image":"http://images.baixingliangfan.cn/advertesPicture/20190116/20190116140738_7766.jpg",
                "goodsId":"35df1fdd5d8c468ca525cd7021bd32d8"
            },
            {
                "image":"http://images.baixingliangfan.cn/advertesPicture/20190116/20190116173351_2085.jpg",
                "goodsId":"6fe4fe0fb5394c0d9b9b4792a827e029"
            },
            {
                "image":"http://images.baixingliangfan.cn/advertesPicture/20190116/20190116140753_5620.jpg",
                "goodsId":"2171c20d77c340729d5d7ebc2039c08d"
            }
        ],
        "shopInfo":{
            "leaderImage":"http://images.baixingliangfan.cn/leaderImage/20181121/20181121133310_65.jpg",
            "leaderPhone":"03936188699"
        },
        "integralMallPic":{
            "PICTURE_ADDRESS":"http://images.baixingliangfan.cn/advertesPicture/20180817/20180817080054_5422.png",
            "TO_PLACE":"1"
        },
        "toShareCode":{
            "PICTURE_ADDRESS":"http://images.baixingliangfan.cn/advertesPicture/20180629/20180629125808_7351.png",
            "TO_PLACE":"1"
        },
        "recommend":[
            {
                "image":"http://images.baixingliangfan.cn/compressedPic/20181210150050_5409.jpg",
                "mallPrice":329,
                "goodsName":"(限购2瓶)沱牌品味舍得52°500ml",
                "goodsId":"c0999c03df344e1ab322b3ce6dffdeb1",
                "price":350
            },
            {
                "image":"http://images.baixingliangfan.cn/compressedPic/20181121172615_4947.jpg",
                "mallPrice":558,
                "goodsName":"红花郎15年53°500ml",
                "goodsId":"d0a2f888f9df48609aab3ed3721d8d88",
                "price":613.8
            },
            {
                "image":"http://images.baixingliangfan.cn/compressedPic/20181121171744_3826.jpg",
                "mallPrice":118,
                "goodsName":"茅台王子酒酱香型53度500ml",
                "goodsId":"d772898204664d7596b20f1d5f4d1dfe",
                "price":118
            }
        ],
        "advertesPicture":{
            "PICTURE_ADDRESS":"http://images.baixingliangfan.cn/advertesPicture/20190131/20190131165032_5788.png",
            "TO_PLACE":"1"
        },
        "floor1":[
            {
                "image":"http://images.baixingliangfan.cn/homeFloor/20190116/20190116133522_9332.jpg",
                "goodsId":"faa86c6ee451445a9475870656f04192"
            },
            {
                "image":"http://images.baixingliangfan.cn/homeFloor/20190116/20190116135616_4151.jpg",
                "goodsId":"80817b9fd00b48f296ce939ae197030b"
            },
            {
                "image":"http://images.baixingliangfan.cn/homeFloor/20190116/20190116133626_1248.jpg",
                "goodsId":"00cee04d12474910bfeb7930f6251c22"
            },
            {
                "image":"http://images.baixingliangfan.cn/homeFloor/20190116/20190116133740_8452.jpg",
                "goodsId":"bdfa9a9a358f436594a740e486fd2060"
            },
            {
                "image":"http://images.baixingliangfan.cn/homeFloor/20190116/20190116133753_7874.jpg",
                "goodsId":"516f9db6ee8e499cb8a8758cf2e567c7"
            }
        ],
        "floor2":[
            {
                "image":"http://images.baixingliangfan.cn/homeFloor/20190116/20190116134240_8923.jpg",
                "goodsId":"04e338da9dbd4ad9913c38e7a4ae5677"
            },
            {
                "image":"http://images.baixingliangfan.cn/homeFloor/20190116/20190116134314_7748.jpg",
                "goodsId":"ca055522081f4315a654384ebb524051"
            },
            {
                "image":"http://images.baixingliangfan.cn/homeFloor/20190117/20190117151627_6993.jpg",
                "goodsId":"c0999c03df344e1ab322b3ce6dffdeb1"
            },
            {
                "image":"http://images.baixingliangfan.cn/homeFloor/20190116/20190116134424_3185.jpg",
                "goodsId":"3236991d77754e47a5cbf8e5d1a04902"
            },
            {
                "image":"http://images.baixingliangfan.cn/homeFloor/20190116/20190116134608_5991.jpg",
                "goodsId":"1140c709d608439d8fc85b650e0c477b"
            }
        ],
        "floor3":[
            {
                "image":"http://images.baixingliangfan.cn/homeFloor/20190122/20190122143838_7004.jpg",
                "goodsId":"ec3c55fb0d4a4f68beb80dc6d1fbf7eb"
            },
            {
                "image":"http://images.baixingliangfan.cn/homeFloor/20190116/20190116135202_4384.jpg",
                "goodsId":"81f919f9719e4e7498a3a53f5b294376"
            },
            {
                "image":"http://images.baixingliangfan.cn/homeFloor/20190122/20190122144023_7291.jpg",
                "goodsId":"138f0836ea664544b06f0ddba5331564"
            },
            {
                "image":"http://images.baixingliangfan.cn/homeFloor/20190116/20190116135302_3912.jpg",
                "goodsId":"b7e06b8248f049d2a50ed727d5988558"
            },
            {
                "image":"http://images.baixingliangfan.cn/homeFloor/20190116/20190116135334_5716.jpg",
                "goodsId":"80cd0b81997d41ceacdf3781a36dc13d"
            }
        ],
        "saoma":{
            "PICTURE_ADDRESS":"http://images.baixingliangfan.cn/advertesPicture/20181112/20181112115518_3523.png",
            "TO_PLACE":"1"
        },
        "newUser":{
            "PICTURE_ADDRESS":"http://images.baixingliangfan.cn/advertesPicture/20190201/20190201172941_4626.png",
            "TO_PLACE":"1"
        },
        "floor1Pic":{
            "PICTURE_ADDRESS":"http://images.baixingliangfan.cn/advertesPicture/20190111/20190111080720_8987.jpg",
            "TO_PLACE":"4"
        },
        "floor2Pic":{
            "PICTURE_ADDRESS":"http://images.baixingliangfan.cn/advertesPicture/20190111/20190111080754_8924.jpg",
            "TO_PLACE":"4"
        },
        "floorName":{
            "floor1":"特产礼盒",
            "floor2":"甄选水果",
            "floor3":"酒！便宜"
        },
        "category":[
            {
                "mallCategoryId":"4",
                "mallCategoryName":"白酒",
                "bxMallSubDto":[
                    {
                        "mallSubId":"2c9f6c94621970a801626a35cb4d0175",
                        "mallCategoryId":"4",
                        "mallSubName":"名酒",
                        "comments":""
                    },
                    {
                        "mallSubId":"2c9f6c94621970a801626a363e5a0176",
                        "mallCategoryId":"4",
                        "mallSubName":"宝丰",
                        "comments":""
                    },
                    {
                        "mallSubId":"2c9f6c94621970a801626a3770620177",
                        "mallCategoryId":"4",
                        "mallSubName":"北京二锅头",
                        "comments":""
                    },
                    {
                        "mallSubId":"2c9f6c94679b4fb10167f7cc035c15a8",
                        "mallCategoryId":"4",
                        "mallSubName":"大明",
                        "comments":null
                    },
                    {
                        "mallSubId":"2c9f6c94679b4fb10167f7cc2af915a9",
                        "mallCategoryId":"4",
                        "mallSubName":"杜康",
                        "comments":null
                    },
                    {
                        "mallSubId":"2c9f6c94679b4fb10167f7cc535115aa",
                        "mallCategoryId":"4",
                        "mallSubName":"顿丘",
                        "comments":null
                    },
                    {
                        "mallSubId":"2c9f6c94679b4fb10167f7cc77b215ab",
                        "mallCategoryId":"4",
                        "mallSubName":"汾酒",
                        "comments":null
                    },
                    {
                        "mallSubId":"2c9f6c94679b4fb10167f7cca72e15ac",
                        "mallCategoryId":"4",
                        "mallSubName":"枫林",
                        "comments":null
                    },
                    {
                        "mallSubId":"2c9f6c94679b4fb10167f7cccae215ad",
                        "mallCategoryId":"4",
                        "mallSubName":"高粱酒",
                        "comments":null
                    },
                    {
                        "mallSubId":"2c9f6c94679b4fb10167f7ccf0d915ae",
                        "mallCategoryId":"4",
                        "mallSubName":"古井",
                        "comments":null
                    },
                    {
                        "mallSubId":"2c9f6c94679b4fb10167f7cd1d6715af",
                        "mallCategoryId":"4",
                        "mallSubName":"贵州大曲",
                        "comments":null
                    },
                    {
                        "mallSubId":"2c9f6c94679b4fb10167f7cd3f2815b0",
                        "mallCategoryId":"4",
                        "mallSubName":"国池",
                        "comments":null
                    },
                    {
                        "mallSubId":"2c9f6c94679b4fb10167f7cd5d3015b1",
                        "mallCategoryId":"4",
                        "mallSubName":"国窖",
                        "comments":null
                    },
                    {
                        "mallSubId":"2c9f6c94679b4fb10167f7cd7ced15b2",
                        "mallCategoryId":"4",
                        "mallSubName":"国台",
                        "comments":null
                    },
                    {
                        "mallSubId":"2c9f6c94679b4fb10167f7cd9b9015b3",
                        "mallCategoryId":"4",
                        "mallSubName":"汉酱",
                        "comments":null
                    },
                    {
                        "mallSubId":"2c9f6c94679b4fb10167f7cdbfd215b4",
                        "mallCategoryId":"4",
                        "mallSubName":"红星",
                        "comments":null
                    },
                    {
                        "mallSubId":"2c9f6c946891d16801689474e2a70081",
                        "mallCategoryId":"4",
                        "mallSubName":"怀庄",
                        "comments":null
                    },
                    {
                        "mallSubId":"2c9f6c94679b4fb10167f7cdddf815b5",
                        "mallCategoryId":"4",
                        "mallSubName":"剑南春",
                        "comments":null
                    },
                    {
                        "mallSubId":"2c9f6c94679b4fb10167f7cdfd4815b6",
                        "mallCategoryId":"4",
                        "mallSubName":"江小白",
                        "comments":null
                    },
                    {
                        "mallSubId":"2c9f6c94679b4fb1016802277c37160e",
                        "mallCategoryId":"4",
                        "mallSubName":"金沙",
                        "comments":null
                    },
                    {
                        "mallSubId":"2c9f6c94679b4fb10167f7ce207015b7",
                        "mallCategoryId":"4",
                        "mallSubName":"京宫",
                        "comments":null
                    },
                    {
                        "mallSubId":"2c9f6c94679b4fb10167f7ce46d415b8",
                        "mallCategoryId":"4",
                        "mallSubName":"酒鬼",
                        "comments":null
                    },
                    {
                        "mallSubId":"2c9f6c94679b4fb101680226de23160d",
                        "mallCategoryId":"4",
                        "mallSubName":"口子窖",
                        "comments":null
                    },
                    {
                        "mallSubId":"2c9f6c94679b4fb10167f7ce705515b9",
                        "mallCategoryId":"4",
                        "mallSubName":"郎酒",
                        "comments":null
                    },
                    {
                        "mallSubId":"2c9f6c94679b4fb10167f7ce989e15ba",
                        "mallCategoryId":"4",
                        "mallSubName":"老口子",
                        "comments":null
                    },
                    {
                        "mallSubId":"2c9f6c94679b4fb10167f7cec30915bb",
                        "mallCategoryId":"4",
                        "mallSubName":"龙江家园",
                        "comments":null
                    },
                    {
                        "mallSubId":"2c9f6c94679b4fb10167f7cef15c15bc",
                        "mallCategoryId":"4",
                        "mallSubName":"泸州",
                        "comments":null
                    },
                    {
                        "mallSubId":"2c9f6c94679b4fb10167f7cf156f15bd",
                        "mallCategoryId":"4",
                        "mallSubName":"鹿邑大曲",
                        "comments":null
                    },
                    {
                        "mallSubId":"2c9f6c94679b4fb10167f7cf425b15be",
                        "mallCategoryId":"4",
                        "mallSubName":"毛铺",
                        "comments":null
                    },
                    {
                        "mallSubId":"2c9f6c94679b4fb10167f7cf9dc915c0",
                        "mallCategoryId":"4",
                        "mallSubName":"绵竹",
                        "comments":null
                    },
                    {
                        "mallSubId":"2c9f6c94679b4fb10167f7cfbf1c15c1",
                        "mallCategoryId":"4",
                        "mallSubName":"难得糊涂",
                        "comments":null
                    },
                    {
                        "mallSubId":"2c9f6c94679b4fb10167f7cfdd7215c2",
                        "mallCategoryId":"4",
                        "mallSubName":"牛二爷",
                        "comments":null
                    },
                    {
                        "mallSubId":"2c9f6c94679b4fb10167f7cf71e715bf",
                        "mallCategoryId":"4",
                        "mallSubName":"茅台",
                        "comments":null
                    },
                    {
                        "mallSubId":"2c9f6c94679b4fb10167f7d7eda715c3",
                        "mallCategoryId":"4",
                        "mallSubName":"绵竹",
                        "comments":null
                    },
                    {
                        "mallSubId":"2c9f6c94679b4fb10167f7d96e5c15c4",
                        "mallCategoryId":"4",
                        "mallSubName":"难得糊涂",
                        "comments":null
                    },
                    {
                        "mallSubId":"2c9f6c94679b4fb10167f7dab93b15c5",
                        "mallCategoryId":"4",
                        "mallSubName":"牛二爷",
                        "comments":null
                    },
                    {
                        "mallSubId":"2c9f6c94679b4fb10167f7dae16415c6",
                        "mallCategoryId":"4",
                        "mallSubName":"牛栏山",
                        "comments":null
                    },
                    {
                        "mallSubId":"2c9f6c94679b4fb10167f7db11cb15c7",
                        "mallCategoryId":"4",
                        "mallSubName":"前门",
                        "comments":null
                    },
                    {
                        "mallSubId":"2c9f6c94679b4fb10167f7db430c15c8",
                        "mallCategoryId":"4",
                        "mallSubName":"全兴",
                        "comments":null
                    },
                    {
                        "mallSubId":"2c9f6c94679b4fb10167f7db6cac15c9",
                        "mallCategoryId":"4",
                        "mallSubName":"舍得",
                        "comments":null
                    },
                    {
                        "mallSubId":"2c9f6c94679b4fb10167f7db9a4415ca",
                        "mallCategoryId":"4",
                        "mallSubName":"双沟",
                        "comments":null
                    },
                    {
                        "mallSubId":"2c9f6c94679b4fb10167f7dc30b815cb",
                        "mallCategoryId":"4",
                        "mallSubName":"水井坊",
                        "comments":null
                    },
                    {
                        "mallSubId":"2c9f6c94679b4fb10167f7dc543e15cc",
                        "mallCategoryId":"4",
                        "mallSubName":"四特",
                        "comments":null
                    },
                    {
                        "mallSubId":"2c9f6c94679b4fb10167f7dc765c15cd",
                        "mallCategoryId":"4",
                        "mallSubName":"潭酒",
                        "comments":null
                    },
                    {
                        "mallSubId":"2c9f6c94679b4fb10167f7dc988a15ce",
                        "mallCategoryId":"4",
                        "mallSubName":"沱牌",
                        "comments":null
                    },
                    {
                        "mallSubId":"2c9f6c94679b4fb10167f7dcba5a15cf",
                        "mallCategoryId":"4",
                        "mallSubName":"五粮液",
                        "comments":null
                    },
                    {
                        "mallSubId":"2c9f6c94679b4fb10167f7dcd9e815d0",
                        "mallCategoryId":"4",
                        "mallSubName":"西凤",
                        "comments":null
                    },
                    {
                        "mallSubId":"2c9f6c94679b4fb10167f7dcf6d715d1",
                        "mallCategoryId":"4",
                        "mallSubName":"习酒",
                        "comments":null
                    },
                    {
                        "mallSubId":"2c9f6c94679b4fb10167f7dd11b215d2",
                        "mallCategoryId":"4",
                        "mallSubName":"小白杨",
                        "comments":null
                    },
                    {
                        "mallSubId":"2c9f6c94679b4fb10167f7dd2f3c15d3",
                        "mallCategoryId":"4",
                        "mallSubName":"洋河",
                        "comments":null
                    },
                    {
                        "mallSubId":"2c9f6c94679b4fb10167f7dd969115d4",
                        "mallCategoryId":"4",
                        "mallSubName":"伊力特",
                        "comments":null
                    },
                    {
                        "mallSubId":"2c9f6c94679b4fb10167f7ddb16c15d5",
                        "mallCategoryId":"4",
                        "mallSubName":"张弓",
                        "comments":null
                    },
                    {
                        "mallSubId":"2c9f6c94679b4fb10167f7ddd6c715d6",
                        "mallCategoryId":"4",
                        "mallSubName":"中粮",
                        "comments":null
                    },
                    {
                        "mallSubId":"2c9f6c94679b4fb10167f7de126815d7",
                        "mallCategoryId":"4",
                        "mallSubName":"竹叶青",
                        "comments":null
                    }
                ],
                "comments":null,
                "image":"http://images.baixingliangfan.cn/firstCategoryPicture/20190131/20190131170036_4477.png"
            },
            {
                "mallCategoryId":"1",
                "mallCategoryName":"啤酒",
                "bxMallSubDto":[
                    {
                        "mallSubId":"2c9f6c946016ea9b016016f79c8e0000",
                        "mallCategoryId":"1",
                        "mallSubName":"百威",
                        "comments":""
                    },
                    {
                        "mallSubId":"2c9f6c94608ff843016095163b8c0177",
                        "mallCategoryId":"1",
                        "mallSubName":"福佳",
                        "comments":""
                    },
                    {
                        "mallSubId":"402880e86016d1b5016016db9b290001",
                        "mallCategoryId":"1",
                        "mallSubName":"哈尔滨",
                        "comments":""
                    },
                    {
                        "mallSubId":"402880e86016d1b5016016dbff2f0002",
                        "mallCategoryId":"1",
                        "mallSubName":"汉德",
                        "comments":""
                    },
                    {
                        "mallSubId":"2c9f6c946449ea7e01647cd6830e0022",
                        "mallCategoryId":"1",
                        "mallSubName":"崂山",
                        "comments":""
                    },
                    {
                        "mallSubId":"2c9f6c946449ea7e01647cd706a60023",
                        "mallCategoryId":"1",
                        "mallSubName":"林德曼",
                        "comments":""
                    },
                    {
                        "mallSubId":"2c9f6c94679b4fb10167f7e1411b15d8",
                        "mallCategoryId":"1",
                        "mallSubName":"青岛",
                        "comments":null
                    },
                    {
                        "mallSubId":"2c9f6c94679b4fb10167f7e1647215d9",
                        "mallCategoryId":"1",
                        "mallSubName":"三得利",
                        "comments":null
                    },
                    {
                        "mallSubId":"2c9f6c94679b4fb10167f7e182e715da",
                        "mallCategoryId":"1",
                        "mallSubName":"乌苏",
                        "comments":null
                    },
                    {
                        "mallSubId":"2c9f6c9468118c9c016811ab16bf0001",
                        "mallCategoryId":"1",
                        "mallSubName":"雪花",
                        "comments":null
                    },
                    {
                        "mallSubId":"2c9f6c9468118c9c016811aa6f440000",
                        "mallCategoryId":"1",
                        "mallSubName":"燕京",
                        "comments":null
                    },
                    {
                        "mallSubId":"2c9f6c94679b4fb10167f7e19b8f15db",
                        "mallCategoryId":"1",
                        "mallSubName":"智美",
                        "comments":null
                    }
                ],
                "comments":null,
                "image":"http://images.baixingliangfan.cn/firstCategoryPicture/20190131/20190131170044_9165.png"
            },
            {
                "mallCategoryId":"2",
                "mallCategoryName":"葡萄酒",
                "bxMallSubDto":[
                    {
                        "mallSubId":"2c9f6c9460337d540160337fefd60000",
                        "mallCategoryId":"2",
                        "mallSubName":"澳大利亚",
                        "comments":""
                    },
                    {
                        "mallSubId":"402880e86016d1b5016016e083f10010",
                        "mallCategoryId":"2",
                        "mallSubName":"德国",
                        "comments":""
                    },
                    {
                        "mallSubId":"402880e86016d1b5016016df1f92000c",
                        "mallCategoryId":"2",
                        "mallSubName":"法国",
                        "comments":""
                    },
                    {
                        "mallSubId":"2c9f6c94621970a801626a40feac0178",
                        "mallCategoryId":"2",
                        "mallSubName":"南非",
                        "comments":""
                    },
                    {
                        "mallSubId":"2c9f6c94679b4fb10167f7e5c9a115dc",
                        "mallCategoryId":"2",
                        "mallSubName":"葡萄牙",
                        "comments":null
                    },
                    {
                        "mallSubId":"2c9f6c94679b4fb10167f7e5e68f15dd",
                        "mallCategoryId":"2",
                        "mallSubName":"西班牙",
                        "comments":null
                    },
                    {
                        "mallSubId":"2c9f6c94679b4fb10167f7e609f515de",
                        "mallCategoryId":"2",
                        "mallSubName":"新西兰",
                        "comments":null
                    },
                    {
                        "mallSubId":"2c9f6c94679b4fb10167f7e6286a15df",
                        "mallCategoryId":"2",
                        "mallSubName":"意大利",
                        "comments":null
                    },
                    {
                        "mallSubId":"2c9f6c94679b4fb10167f7e6486615e0",
                        "mallCategoryId":"2",
                        "mallSubName":"智利",
                        "comments":null
                    },
                    {
                        "mallSubId":"2c9f6c94679b4fb10167f7e66c6815e1",
                        "mallCategoryId":"2",
                        "mallSubName":"中国",
                        "comments":null
                    }
                ],
                "comments":null,
                "image":"http://images.baixingliangfan.cn/firstCategoryPicture/20190131/20190131170053_878.png"
            },
            {
                "mallCategoryId":"3",
                "mallCategoryName":"清酒洋酒",
                "bxMallSubDto":[
                    {
                        "mallSubId":"402880e86016d1b5016016e135440011",
                        "mallCategoryId":"3",
                        "mallSubName":"清酒",
                        "comments":""
                    },
                    {
                        "mallSubId":"402880e86016d1b5016016e171cc0012",
                        "mallCategoryId":"3",
                        "mallSubName":"洋酒",
                        "comments":""
                    }
                ],
                "comments":null,
                "image":"http://images.baixingliangfan.cn/firstCategoryPicture/20190131/20190131170101_6957.png"
            },
            {
                "mallCategoryId":"5",
                "mallCategoryName":"保健酒",
                "bxMallSubDto":[
                    {
                        "mallSubId":"2c9f6c94609a62be0160a02d1dc20021",
                        "mallCategoryId":"5",
                        "mallSubName":"黄酒",
                        "comments":""
                    },
                    {
                        "mallSubId":"2c9f6c94648837980164883ff6980000",
                        "mallCategoryId":"5",
                        "mallSubName":"药酒",
                        "comments":""
                    }
                ],
                "comments":null,
                "image":"http://images.baixingliangfan.cn/firstCategoryPicture/20190131/20190131170110_6581.png"
            },
            {
                "mallCategoryId":"2c9f6c946449ea7e01647ccd76a6001b",
                "mallCategoryName":"预调酒",
                "bxMallSubDto":[
                    {
                        "mallSubId":"2c9f6c946449ea7e01647d02f6250026",
                        "mallCategoryId":"2c9f6c946449ea7e01647ccd76a6001b",
                        "mallSubName":"果酒",
                        "comments":""
                    },
                    {
                        "mallSubId":"2c9f6c946449ea7e01647d031bae0027",
                        "mallCategoryId":"2c9f6c946449ea7e01647ccd76a6001b",
                        "mallSubName":"鸡尾酒",
                        "comments":""
                    },
                    {
                        "mallSubId":"2c9f6c946449ea7e01647d03428f0028",
                        "mallCategoryId":"2c9f6c946449ea7e01647ccd76a6001b",
                        "mallSubName":"米酒",
                        "comments":""
                    }
                ],
                "comments":null,
                "image":"http://images.baixingliangfan.cn/firstCategoryPicture/20190131/20190131170124_4760.png"
            },
            {
                "mallCategoryId":"2c9f6c946449ea7e01647ccf3b97001d",
                "mallCategoryName":"下酒小菜",
                "bxMallSubDto":[
                    {
                        "mallSubId":"2c9f6c946449ea7e01647dc18e610035",
                        "mallCategoryId":"2c9f6c946449ea7e01647ccf3b97001d",
                        "mallSubName":"熟食",
                        "comments":""
                    },
                    {
                        "mallSubId":"2c9f6c946449ea7e01647dc1d9070036",
                        "mallCategoryId":"2c9f6c946449ea7e01647ccf3b97001d",
                        "mallSubName":"火腿",
                        "comments":""
                    },
                    {
                        "mallSubId":"2c9f6c946449ea7e01647dc1fc3e0037",
                        "mallCategoryId":"2c9f6c946449ea7e01647ccf3b97001d",
                        "mallSubName":"速冻食品",
                        "comments":""
                    }
                ],
                "comments":null,
                "image":"http://images.baixingliangfan.cn/firstCategoryPicture/20190131/20190131170133_4419.png"
            },
            {
                "mallCategoryId":"2c9f6c946449ea7e01647ccdb0e0001c",
                "mallCategoryName":"饮料",
                "bxMallSubDto":[
                    {
                        "mallSubId":"2c9f6c946449ea7e01647d09cbf6002d",
                        "mallCategoryId":"2c9f6c946449ea7e01647ccdb0e0001c",
                        "mallSubName":"茶饮",
                        "comments":""
                    },
                    {
                        "mallSubId":"2c9f6c946449ea7e01647d09f7e8002e",
                        "mallCategoryId":"2c9f6c946449ea7e01647ccdb0e0001c",
                        "mallSubName":"水饮",
                        "comments":""
                    },
                    {
                        "mallSubId":"2c9f6c946449ea7e01647d0a27e1002f",
                        "mallCategoryId":"2c9f6c946449ea7e01647ccdb0e0001c",
                        "mallSubName":"功能饮料",
                        "comments":""
                    },
                    {
                        "mallSubId":"2c9f6c946449ea7e01647d0b1d4d0030",
                        "mallCategoryId":"2c9f6c946449ea7e01647ccdb0e0001c",
                        "mallSubName":"果汁",
                        "comments":""
                    },
                    {
                        "mallSubId":"2c9f6c946449ea7e01647d14192b0031",
                        "mallCategoryId":"2c9f6c946449ea7e01647ccdb0e0001c",
                        "mallSubName":"含乳饮料",
                        "comments":""
                    },
                    {
                        "mallSubId":"2c9f6c946449ea7e01647d24d9600032",
                        "mallCategoryId":"2c9f6c946449ea7e01647ccdb0e0001c",
                        "mallSubName":"碳酸饮料",
                        "comments":""
                    }
                ],
                "comments":null,
                "image":"http://images.baixingliangfan.cn/firstCategoryPicture/20190131/20190131170143_361.png"
            },
            {
                "mallCategoryId":"2c9f6c946449ea7e01647cd108b60020",
                "mallCategoryName":"乳制品",
                "bxMallSubDto":[
                    {
                        "mallSubId":"2c9f6c946449ea7e01647dd4ac8c0048",
                        "mallCategoryId":"2c9f6c946449ea7e01647cd108b60020",
                        "mallSubName":"常温纯奶",
                        "comments":""
                    },
                    {
                        "mallSubId":"2c9f6c946449ea7e01647dd4f6a40049",
                        "mallCategoryId":"2c9f6c946449ea7e01647cd108b60020",
                        "mallSubName":"常温酸奶",
                        "comments":""
                    },
                    {
                        "mallSubId":"2c9f6c946449ea7e01647dd51ab7004a",
                        "mallCategoryId":"2c9f6c946449ea7e01647cd108b60020",
                        "mallSubName":"低温奶",
                        "comments":""
                    }
                ],
                "comments":null,
                "image":"http://images.baixingliangfan.cn/firstCategoryPicture/20190131/20190131170151_9234.png"
            },
            {
                "mallCategoryId":"2c9f6c946449ea7e01647ccfddb3001e",
                "mallCategoryName":"休闲零食",
                "bxMallSubDto":[
                    {
                        "mallSubId":"2c9f6c946449ea7e01647dc51d93003c",
                        "mallCategoryId":"2c9f6c946449ea7e01647ccfddb3001e",
                        "mallSubName":"方便食品",
                        "comments":""
                    },
                    {
                        "mallSubId":"2c9f6c946449ea7e01647dd204dc0040",
                        "mallCategoryId":"2c9f6c946449ea7e01647ccfddb3001e",
                        "mallSubName":"面包糕点",
                        "comments":""
                    },
                    {
                        "mallSubId":"2c9f6c946449ea7e01647dd22f760041",
                        "mallCategoryId":"2c9f6c946449ea7e01647ccfddb3001e",
                        "mallSubName":"糖果巧克力",
                        "comments":""
                    },
                    {
                        "mallSubId":"2c9f6c946449ea7e01647dd254530042",
                        "mallCategoryId":"2c9f6c946449ea7e01647ccfddb3001e",
                        "mallSubName":"膨化食品",
                        "comments":""
                    },
                    {
                        "mallSubId":"2c9f6c94679b4fb10167f7fa132b15e7",
                        "mallCategoryId":"2c9f6c946449ea7e01647ccfddb3001e",
                        "mallSubName":"坚果炒货",
                        "comments":null
                    },
                    {
                        "mallSubId":"2c9f6c94679b4fb10167f7f4bfc415e2",
                        "mallCategoryId":"2c9f6c946449ea7e01647ccfddb3001e",
                        "mallSubName":"肉干豆干",
                        "comments":null
                    },
                    {
                        "mallSubId":"2c9f6c94679b4fb10167f7f5027a15e3",
                        "mallCategoryId":"2c9f6c946449ea7e01647ccfddb3001e",
                        "mallSubName":"饼干",
                        "comments":null
                    },
                    {
                        "mallSubId":"2c9f6c94679b4fb10167f7f530fd15e4",
                        "mallCategoryId":"2c9f6c946449ea7e01647ccfddb3001e",
                        "mallSubName":"冲调",
                        "comments":null
                    },
                    {
                        "mallSubId":"2c9f6c94683a6b0d016846b49436003b",
                        "mallCategoryId":"2c9f6c946449ea7e01647ccfddb3001e",
                        "mallSubName":"休闲水果",
                        "comments":null
                    }
                ],
                "comments":null,
                "image":"http://images.baixingliangfan.cn/firstCategoryPicture/20190131/20190131170200_7553.png"
            },
            {
                "mallCategoryId":"2c9f6c946449ea7e01647cd08369001f",
                "mallCategoryName":"粮油调味",
                "bxMallSubDto":[
                    {
                        "mallSubId":"2c9f6c946449ea7e01647dd2e8270043",
                        "mallCategoryId":"2c9f6c946449ea7e01647cd08369001f",
                        "mallSubName":"油/粮食",
                        "comments":""
                    },
                    {
                        "mallSubId":"2c9f6c946449ea7e01647dd31bca0044",
                        "mallCategoryId":"2c9f6c946449ea7e01647cd08369001f",
                        "mallSubName":"调味品",
                        "comments":""
                    },
                    {
                        "mallSubId":"2c9f6c946449ea7e01647dd35a980045",
                        "mallCategoryId":"2c9f6c946449ea7e01647cd08369001f",
                        "mallSubName":"酱菜罐头",
                        "comments":""
                    }
                ],
                "comments":null,
                "image":"http://images.baixingliangfan.cn/firstCategoryPicture/20181212/20181212115842_9733.png"
            }
        ],
        "floor3Pic":{
            "PICTURE_ADDRESS":"http://images.baixingliangfan.cn/advertesPicture/20190111/20190111081455_1309.jpg",
            "TO_PLACE":"4"
        },
        "reservationGoods":[

        ]
    }
}
```

## 第63节：购物车_详细页显示购物车商品数量


### 详情页面添加小红点

```
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop_mall/provide/cart_provide.dart';
import 'package:flutter_shop_mall/provide/current_index_provide.dart';
import 'package:flutter_shop_mall/provide/details_goods_provide.dart';
import 'package:provide/provide.dart';

class DetailsBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var goodsInfo =
        Provide.value<DetailsGoodsProvide>(context).detailsGoods.data.goodInfo;
    var goodsId = goodsInfo.goodsId;
    var goodsName = goodsInfo.goodsName;
    var count = 1;
    var presentPrice = goodsInfo.presentPrice;
    var oriPrice = goodsInfo.oriPrice;
    var images = goodsInfo.image1;

    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(100),
      child: Row(
        children: <Widget>[
          Stack(
            children: <Widget>[
              InkWell(
                onTap: () {
                  debugPrint('点击购物车');
                  Provide.value<CurrentIndexProvide>(context)
                      .changeCurrentIndex(2);
                  Navigator.pop(context);
                },
                child: Container(
                  height: ScreenUtil().setHeight(100),
                  width: ScreenUtil().setHeight(110),
                  color: Colors.white,
                  child: Icon(
                    Icons.shopping_cart,
                    size: 30,
                    color: Colors.pink,
                  ),
                ),
              ),
              Provide<CartProvide>(
                builder: (context, child, cartProvide) {
                  var allGoodsCount = cartProvide.allGoodsCount;
                  return Positioned(
                    top: 2,
                    right: 12,
                    child: Container(
                      padding:EdgeInsets.fromLTRB(6, 3, 6, 3),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        border: Border.all(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '$allGoodsCount',
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(16),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
          InkWell(
            onTap: () async {
              debugPrint('加入购物车');
              Provide.value<CartProvide>(context).save(
                  goodsId, goodsName, count, presentPrice, oriPrice, images);
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('添加购物车成功！'),
                action: SnackBarAction(
                  label: 'ok',
                  onPressed: () {},
                ),
              ));
            },
            child: Container(
              height: ScreenUtil().setHeight(100),
              width: ScreenUtil().setHeight(320),
              color: Colors.green,
              alignment: Alignment(0, 0),
              child: Text(
                '加入购物车',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(30),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              debugPrint('立即购买');
              Provide.value<CartProvide>(context).remove();
            },
            child: Container(
              height: ScreenUtil().setHeight(100),
              width: ScreenUtil().setHeight(320),
              color: Colors.red,
              alignment: Alignment(0, 0),
              child: Text(
                '立即购买',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(30),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

```

### cartProvide 状态管理

```
void save(String goodsId, String goodsName, int count, double presentPrice,
      double oriPrice, String images) async {
    // 初始化SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // 获取数据
    cartGoodsStr = prefs.getString('cartInfo');
    debugPrint('cartGoodsStr 值  $cartGoodsStr');
    // 判断cartString是否为空，为空说明是第一次添加，或者被key被清除了。
    // 如果有值进行decode操作
    var temp = cartGoodsStr == null ? [] : json.decode(cartGoodsStr.toString());
    List<Map> tampList = (temp as List).cast();
    // 如果数据不为空，那么需要给 cartInfoList 添加数据
    if (tampList != null && tampList.length > 0) {
      tampList.forEach((item) {
        cartInfoList.add(new CartInfoModel.fromJson(item));
      });
    }

    // 判断是否存在当前商品
    bool isHaveThisGoods = false;

    // 初始化
    allPrice = 0;
    allGoodsCount = 0;

    // 用于进行循环的索引使用
    int ival = 0;
    // 进行循环，找出是否已经存在该商品
    tampList.forEach((item) {
      debugPrint('ival 前 $ival');
      // 如果存在，数量进行+1操作
      if (item['goodsId'] == goodsId) {
        debugPrint('有一样的数据，+1');
        tampList[ival]['count'] = item['count'] + 1;
        cartInfoList[ival].count++;
        isHaveThisGoods = true;
      }
      // 循环添加数据
      if (item['isCheck']) {
        allPrice += (cartInfoList[ival].price * cartInfoList[ival].count);
        allGoodsCount += cartInfoList[ival].count;
      }

      ival++;
    });

    debugPrint('ival 后 $ival');

    //  如果没有，进行增加
    if (!isHaveThisGoods) {
      Map<String, dynamic> newGoods = {
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': presentPrice,
        'oriPrice': oriPrice,
        'images': images,
        'isCheck': true
      };
      tampList.add(newGoods);
      cartInfoList.add(CartInfoModel.fromJson(newGoods));

      // 新添加数据加入
      allPrice += count * presentPrice;
      allGoodsCount += count;
    }

    //把字符串进行encode操作，
    cartGoodsStr = json.encode(tampList).toString();
    debugPrint('持久化数据 字符串 $cartGoodsStr');
    debugPrint('持久化数据 列表 $cartInfoList');
    prefs.setString('cartInfo', cartGoodsStr); //进行持久化
    notifyListeners();
  }

```

## 第64节：会员中心_首页头部布局

```
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

```

## 第65节：会员中心_订单区域UI编写

### order
```
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

```

### order tap
```
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderDetailTap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 20,
        bottom: 20,
      ),
      height: ScreenUtil().setHeight(200),
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

```

### 调用

```
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

```

## 第66节:会员中心_编写ListTile的通用方法

### ListTile通用方法
```
import 'package:flutter/material.dart';

class MemberCommonTap extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subTitle;
  final String type;
  final bool isShowSub;

  MemberCommonTap(
      this.icon, this.title, this.subTitle, this.type, this.isShowSub);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListTile(
        onTap: () {
          switch (type) {
            case '1':
              break;

            case '2':
              break;

            case '3':
              break;

            case '4':
              break;
            default:
              break;
          }
        },
        leading: Icon(icon),
        title: Text(title),
        //subtitle: isShowSub ? Text(subTitle) : Text(''),
        trailing: Icon(Icons.arrow_right),
      ),
    );
  }
}

```

### 调用
```
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

```


### 火爆专区商品列表

- 参数：page

- 接口地址：wxmini/homePageBelowConten
     
- 返回参数：
1. image ：商品图片地址，可以直接使用。
2. name: 商品名称
3. mallPrice：商品商城价格
4. price: 商品价格，指市场价格

**Post**

http://v.jspang.com:8088/baixing/wxmini/homePageBelowConten

{
    "page":1
}

```
{
    "code":"0",
    "message":"success",
    "data":[
        {
            "name":"智美9%蓝帽啤酒18.9°P330ml",
            "image":"http://images.baixingliangfan.cn/compressedPic/20190121171258_323.jpg",
            "mallPrice":21.9,
            "goodsId":"6f09c0e733b0499c81503ce457b4cf9f",
            "price":24.09
        },
        {
            "name":"波士力娇酒蛋黄味21°700ml",
            "image":"http://images.baixingliangfan.cn/compressedPic/20190122093838_5979.jpg",
            "mallPrice":98,
            "goodsId":"cf304b822ddd4f6aa275c5e54f36abba",
            "price":107.8
        },
        {
            "name":"汉德百士菠萝啤500ml",
            "image":"http://images.baixingliangfan.cn/compressedPic/20190121101250_3231.jpg",
            "mallPrice":1.1,
            "goodsId":"80a28efdb16b4fa29884095ef1399a7e",
            "price":1.21
        },
        {
            "name":"林德曼山莓味啤酒250ml",
            "image":"http://images.baixingliangfan.cn/compressedPic/20190121102807_7848.jpg",
            "mallPrice":16,
            "goodsId":"e47bf468042a4940a3b8a32d07f64d71",
            "price":17.6
        },
        {
            "name":"福佳4.9%白啤酒11.7°P330ml",
            "image":"http://images.baixingliangfan.cn/compressedPic/20190121100327_1855.jpg",
            "mallPrice":12.5,
            "goodsId":"3a79607209a044aeb1926c10bb837a75",
            "price":13.75
        },
        {
            "name":"林德曼苹果啤酒250ml",
            "image":"http://images.baixingliangfan.cn/compressedPic/20190121103035_1212.jpg",
            "mallPrice":16,
            "goodsId":"a3b789aa3fa542c6953f578b4a4d00a1",
            "price":17.6
        },
        {
            "name":"青岛啤酒10°500ml",
            "image":"http://images.baixingliangfan.cn/compressedPic/20190121160757_296.jpg",
            "mallPrice":4.8,
            "goodsId":"8d3d6f79e7a34b75848b13c701ea62b4",
            "price":5.28
        },
        {
            "name":"茅台三十年礼盒",
            "image":"http://images.baixingliangfan.cn/compressedPic/20190118163251_3984.jpg",
            "mallPrice":10999,
            "goodsId":"8c8117b894d94273a3ed82536ead3402",
            "price":12098.9
        },
        {
            "name":"茅台玫瑰金53°500MLl",
            "image":"http://images.baixingliangfan.cn/compressedPic/20190118161429_6341.jpg",
            "mallPrice":3599,
            "goodsId":"d2168f0647924b829d95c006bf05a0ec",
            "price":3958.9
        },
        {
            "name":"茅台飞天带杯53°500ml",
            "image":"http://images.baixingliangfan.cn/compressedPic/20181229210425_6614.jpg",
            "mallPrice":1799,
            "goodsId":"35df1fdd5d8c468ca525cd7021bd32d8",
            "price":1978.9
        },
        {
            "name":"五粮液52°1000ml",
            "image":"http://images.baixingliangfan.cn/compressedPic/20190119111343_9787.jpg",
            "mallPrice":1650,
            "goodsId":"48209753f9f146d49ab8dca5f52de6de",
            "price":1815
        },
        {
            "name":"汾酒20青花53°500ml",
            "image":"http://images.baixingliangfan.cn/compressedPic/20190109172849_6508.jpg",
            "mallPrice":379,
            "goodsId":"81f919f9719e4e7498a3a53f5b294376",
            "price":598
        },
        {
            "name":"茅台15年53°500ml",
            "image":"http://images.baixingliangfan.cn/compressedPic/20190118152446_4422.jpg",
            "mallPrice":4999,
            "goodsId":"b093148f2e6747e9bb068efd37b6695f",
            "price":5498.9
        },
        {
            "name":"洋河蓝色经典海之蓝52°480ml",
            "image":"http://images.baixingliangfan.cn/compressedPic/20190109173820_1556.jpg",
            "mallPrice":178,
            "goodsId":"11a401e776e44414bd886f27a1def492",
            "price":195.8
        },
        {
            "name":"汾酒30青花53°500ml",
            "image":"http://images.baixingliangfan.cn/compressedPic/20190109172954_1192.jpg",
            "mallPrice":579,
            "goodsId":"ec3c55fb0d4a4f68beb80dc6d1fbf7eb",
            "price":636.9
        },
        {
            "name":"五粮液十五年礼盒500ml",
            "image":"http://images.baixingliangfan.cn/compressedPic/20190119143850_275.jpg",
            "mallPrice":2160,
            "goodsId":"c7a5eaedb3da4e5e887fc60226812d13",
            "price":2376
        },
        {
            "name":"飞天茅台53°200ML",
            "image":"http://images.baixingliangfan.cn/compressedPic/20190118150311_1017.jpg",
            "mallPrice":869,
            "goodsId":"405b4d856b7d43ed890d868011679cef",
            "price":955.9
        },
        {
            "name":"茅台飞天53° 1500ml",
            "image":"http://images.baixingliangfan.cn/compressedPic/20190118162327_209.jpg",
            "mallPrice":7599,
            "goodsId":"cd4e9ac2e21940e1b21e10ffde24dffb",
            "price":8358.9
        },
        {
            "name":"茅台飞天53° 1000ml",
            "image":"http://images.baixingliangfan.cn/compressedPic/20190118162413_1873.jpg",
            "mallPrice":3999,
            "goodsId":"1d386b95893a4ad590fbc2b4465216f1",
            "price":4398.9
        },
        {
            "name":"泸州国窖1573（52°）500ml",
            "image":"http://images.baixingliangfan.cn/compressedPic/20190118110141_8950.jpg",
            "mallPrice":729,
            "goodsId":"04e338da9dbd4ad9913c38e7a4ae5677",
            "price":810
        }
    ]
}
```

### 商品类别信息

- 接口地址：wxmini/getCategory

- 返回参数：

1. mallCategoryId ： 类别ID，用于控制子类别和商品列表。
2. mallCategoryName : 类别名称，例如“白酒”
3. bxMallSubDto：二级类别，是个数组
4. comments：类别描述，目前全是null
5. image：类别图片，可能是以后扩展使用的。

**Post**

http://v.jspang.com:8088/baixing/wxmini/getCategory

```
{
    "code":"0",
    "message":"success",
    "data":[
        {
            "mallCategoryId":"4",
            "mallCategoryName":"白酒",
            "bxMallSubDto":[
                {
                    "mallSubId":"2c9f6c94621970a801626a35cb4d0175",
                    "mallCategoryId":"4",
                    "mallSubName":"名酒",
                    "comments":""
                },
                {
                    "mallSubId":"2c9f6c94621970a801626a363e5a0176",
                    "mallCategoryId":"4",
                    "mallSubName":"宝丰",
                    "comments":""
                },
                {
                    "mallSubId":"2c9f6c94621970a801626a3770620177",
                    "mallCategoryId":"4",
                    "mallSubName":"北京二锅头",
                    "comments":""
                },
                {
                    "mallSubId":"2c9f6c94679b4fb10167f7cc035c15a8",
                    "mallCategoryId":"4",
                    "mallSubName":"大明",
                    "comments":null
                },
                {
                    "mallSubId":"2c9f6c94679b4fb10167f7cc2af915a9",
                    "mallCategoryId":"4",
                    "mallSubName":"杜康",
                    "comments":null
                },
                {
                    "mallSubId":"2c9f6c94679b4fb10167f7cc535115aa",
                    "mallCategoryId":"4",
                    "mallSubName":"顿丘",
                    "comments":null
                },
                {
                    "mallSubId":"2c9f6c94679b4fb10167f7cc77b215ab",
                    "mallCategoryId":"4",
                    "mallSubName":"汾酒",
                    "comments":null
                },
                {
                    "mallSubId":"2c9f6c94679b4fb10167f7cca72e15ac",
                    "mallCategoryId":"4",
                    "mallSubName":"枫林",
                    "comments":null
                },
                {
                    "mallSubId":"2c9f6c94679b4fb10167f7cccae215ad",
                    "mallCategoryId":"4",
                    "mallSubName":"高粱酒",
                    "comments":null
                },
                {
                    "mallSubId":"2c9f6c94679b4fb10167f7ccf0d915ae",
                    "mallCategoryId":"4",
                    "mallSubName":"古井",
                    "comments":null
                },
                {
                    "mallSubId":"2c9f6c94679b4fb10167f7cd1d6715af",
                    "mallCategoryId":"4",
                    "mallSubName":"贵州大曲",
                    "comments":null
                },
                {
                    "mallSubId":"2c9f6c94679b4fb10167f7cd3f2815b0",
                    "mallCategoryId":"4",
                    "mallSubName":"国池",
                    "comments":null
                },
                {
                    "mallSubId":"2c9f6c94679b4fb10167f7cd5d3015b1",
                    "mallCategoryId":"4",
                    "mallSubName":"国窖",
                    "comments":null
                },
                {
                    "mallSubId":"2c9f6c94679b4fb10167f7cd7ced15b2",
                    "mallCategoryId":"4",
                    "mallSubName":"国台",
                    "comments":null
                },
                {
                    "mallSubId":"2c9f6c94679b4fb10167f7cd9b9015b3",
                    "mallCategoryId":"4",
                    "mallSubName":"汉酱",
                    "comments":null
                },
                {
                    "mallSubId":"2c9f6c94679b4fb10167f7cdbfd215b4",
                    "mallCategoryId":"4",
                    "mallSubName":"红星",
                    "comments":null
                },
                {
                    "mallSubId":"2c9f6c946891d16801689474e2a70081",
                    "mallCategoryId":"4",
                    "mallSubName":"怀庄",
                    "comments":null
                },
                {
                    "mallSubId":"2c9f6c94679b4fb10167f7cdddf815b5",
                    "mallCategoryId":"4",
                    "mallSubName":"剑南春",
                    "comments":null
                },
                {
                    "mallSubId":"2c9f6c94679b4fb10167f7cdfd4815b6",
                    "mallCategoryId":"4",
                    "mallSubName":"江小白",
                    "comments":null
                },
                {
                    "mallSubId":"2c9f6c94679b4fb1016802277c37160e",
                    "mallCategoryId":"4",
                    "mallSubName":"金沙",
                    "comments":null
                },
                {
                    "mallSubId":"2c9f6c94679b4fb10167f7ce207015b7",
                    "mallCategoryId":"4",
                    "mallSubName":"京宫",
                    "comments":null
                },
                {
                    "mallSubId":"2c9f6c94679b4fb10167f7ce46d415b8",
                    "mallCategoryId":"4",
                    "mallSubName":"酒鬼",
                    "comments":null
                },
                {
                    "mallSubId":"2c9f6c94679b4fb101680226de23160d",
                    "mallCategoryId":"4",
                    "mallSubName":"口子窖",
                    "comments":null
                },
                {
                    "mallSubId":"2c9f6c94679b4fb10167f7ce705515b9",
                    "mallCategoryId":"4",
                    "mallSubName":"郎酒",
                    "comments":null
                },
                {
                    "mallSubId":"2c9f6c94679b4fb10167f7ce989e15ba",
                    "mallCategoryId":"4",
                    "mallSubName":"老口子",
                    "comments":null
                },
                {
                    "mallSubId":"2c9f6c94679b4fb10167f7cec30915bb",
                    "mallCategoryId":"4",
                    "mallSubName":"龙江家园",
                    "comments":null
                },
                {
                    "mallSubId":"2c9f6c94679b4fb10167f7cef15c15bc",
                    "mallCategoryId":"4",
                    "mallSubName":"泸州",
                    "comments":null
                },
                {
                    "mallSubId":"2c9f6c94679b4fb10167f7cf156f15bd",
                    "mallCategoryId":"4",
                    "mallSubName":"鹿邑大曲",
                    "comments":null
                },
                {
                    "mallSubId":"2c9f6c94679b4fb10167f7cf425b15be",
                    "mallCategoryId":"4",
                    "mallSubName":"毛铺",
                    "comments":null
                },
                {
                    "mallSubId":"2c9f6c94679b4fb10167f7cf9dc915c0",
                    "mallCategoryId":"4",
                    "mallSubName":"绵竹",
                    "comments":null
                },
                {
                    "mallSubId":"2c9f6c94679b4fb10167f7cfbf1c15c1",
                    "mallCategoryId":"4",
                    "mallSubName":"难得糊涂",
                    "comments":null
                },
                {
                    "mallSubId":"2c9f6c94679b4fb10167f7cfdd7215c2",
                    "mallCategoryId":"4",
                    "mallSubName":"牛二爷",
                    "comments":null
                },
                {
                    "mallSubId":"2c9f6c94679b4fb10167f7cf71e715bf",
                    "mallCategoryId":"4",
                    "mallSubName":"茅台",
                    "comments":null
                },
                {
                    "mallSubId":"2c9f6c94679b4fb10167f7d7eda715c3",
                    "mallCategoryId":"4",
                    "mallSubName":"绵竹",
                    "comments":null
                },
                {
                    "mallSubId":"2c9f6c94679b4fb10167f7d96e5c15c4",
                    "mallCategoryId":"4",
                    "mallSubName":"难得糊涂",
                    "comments":null
                },
                {
                    "mallSubId":"2c9f6c94679b4fb10167f7dab93b15c5",
                    "mallCategoryId":"4",
                    "mallSubName":"牛二爷",
                    "comments":null
                },
                {
                    "mallSubId":"2c9f6c94679b4fb10167f7dae16415c6",
                    "mallCategoryId":"4",
                    "mallSubName":"牛栏山",
                    "comments":null
                },
                {
                    "mallSubId":"2c9f6c94679b4fb10167f7db11cb15c7",
                    "mallCategoryId":"4",
                    "mallSubName":"前门",
                    "comments":null
                },
                {
                    "mallSubId":"2c9f6c94679b4fb10167f7db430c15c8",
                    "mallCategoryId":"4",
                    "mallSubName":"全兴",
                    "comments":null
                },
                {
                    "mallSubId":"2c9f6c94679b4fb10167f7db6cac15c9",
                    "mallCategoryId":"4",
                    "mallSubName":"舍得",
                    "comments":null
                },
                {
                    "mallSubId":"2c9f6c94679b4fb10167f7db9a4415ca",
                    "mallCategoryId":"4",
                    "mallSubName":"双沟",
                    "comments":null
                },
                {
                    "mallSubId":"2c9f6c94679b4fb10167f7dc30b815cb",
                    "mallCategoryId":"4",
                    "mallSubName":"水井坊",
                    "comments":null
                },
                {
                    "mallSubId":"2c9f6c94679b4fb10167f7dc543e15cc",
                    "mallCategoryId":"4",
                    "mallSubName":"四特",
                    "comments":null
                },
                {
                    "mallSubId":"2c9f6c94679b4fb10167f7dc765c15cd",
                    "mallCategoryId":"4",
                    "mallSubName":"潭酒",
                    "comments":null
                },
                {
                    "mallSubId":"2c9f6c94679b4fb10167f7dc988a15ce",
                    "mallCategoryId":"4",
                    "mallSubName":"沱牌",
                    "comments":null
                },
                {
                    "mallSubId":"2c9f6c94679b4fb10167f7dcba5a15cf",
                    "mallCategoryId":"4",
                    "mallSubName":"五粮液",
                    "comments":null
                },
                {
                    "mallSubId":"2c9f6c94679b4fb10167f7dcd9e815d0",
                    "mallCategoryId":"4",
                    "mallSubName":"西凤",
                    "comments":null
                },
                {
                    "mallSubId":"2c9f6c94679b4fb10167f7dcf6d715d1",
                    "mallCategoryId":"4",
                    "mallSubName":"习酒",
                    "comments":null
                },
                {
                    "mallSubId":"2c9f6c94679b4fb10167f7dd11b215d2",
                    "mallCategoryId":"4",
                    "mallSubName":"小白杨",
                    "comments":null
                },
                {
                    "mallSubId":"2c9f6c94679b4fb10167f7dd2f3c15d3",
                    "mallCategoryId":"4",
                    "mallSubName":"洋河",
                    "comments":null
                },
                {
                    "mallSubId":"2c9f6c94679b4fb10167f7dd969115d4",
                    "mallCategoryId":"4",
                    "mallSubName":"伊力特",
                    "comments":null
                },
                {
                    "mallSubId":"2c9f6c94679b4fb10167f7ddb16c15d5",
                    "mallCategoryId":"4",
                    "mallSubName":"张弓",
                    "comments":null
                },
                {
                    "mallSubId":"2c9f6c94679b4fb10167f7ddd6c715d6",
                    "mallCategoryId":"4",
                    "mallSubName":"中粮",
                    "comments":null
                },
                {
                    "mallSubId":"2c9f6c94679b4fb10167f7de126815d7",
                    "mallCategoryId":"4",
                    "mallSubName":"竹叶青",
                    "comments":null
                }
            ],
            "comments":null,
            "image":"http://images.baixingliangfan.cn/firstCategoryPicture/20190131/20190131170036_4477.png"
        },
        Object{...},
        Object{...},
        Object{...},
        {
            "mallCategoryId":"5",
            "mallCategoryName":"保健酒",
            "bxMallSubDto":[
                {
                    "mallSubId":"2c9f6c94609a62be0160a02d1dc20021",
                    "mallCategoryId":"5",
                    "mallSubName":"黄酒",
                    "comments":""
                },
                {
                    "mallSubId":"2c9f6c94648837980164883ff6980000",
                    "mallCategoryId":"5",
                    "mallSubName":"药酒",
                    "comments":""
                }
            ],
            "comments":null,
            "image":"http://images.baixingliangfan.cn/firstCategoryPicture/20190131/20190131170110_6581.png"
        },
        {
            "mallCategoryId":"2c9f6c946449ea7e01647ccd76a6001b",
            "mallCategoryName":"预调酒",
            "bxMallSubDto":[
                {
                    "mallSubId":"2c9f6c946449ea7e01647d02f6250026",
                    "mallCategoryId":"2c9f6c946449ea7e01647ccd76a6001b",
                    "mallSubName":"果酒",
                    "comments":""
                },
                {
                    "mallSubId":"2c9f6c946449ea7e01647d031bae0027",
                    "mallCategoryId":"2c9f6c946449ea7e01647ccd76a6001b",
                    "mallSubName":"鸡尾酒",
                    "comments":""
                },
                {
                    "mallSubId":"2c9f6c946449ea7e01647d03428f0028",
                    "mallCategoryId":"2c9f6c946449ea7e01647ccd76a6001b",
                    "mallSubName":"米酒",
                    "comments":""
                }
            ],
            "comments":null,
            "image":"http://images.baixingliangfan.cn/firstCategoryPicture/20190131/20190131170124_4760.png"
        },
        {
            "mallCategoryId":"2c9f6c946449ea7e01647ccf3b97001d",
            "mallCategoryName":"下酒小菜",
            "bxMallSubDto":[
                {
                    "mallSubId":"2c9f6c946449ea7e01647dc18e610035",
                    "mallCategoryId":"2c9f6c946449ea7e01647ccf3b97001d",
                    "mallSubName":"熟食",
                    "comments":""
                },
                {
                    "mallSubId":"2c9f6c946449ea7e01647dc1d9070036",
                    "mallCategoryId":"2c9f6c946449ea7e01647ccf3b97001d",
                    "mallSubName":"火腿",
                    "comments":""
                },
                {
                    "mallSubId":"2c9f6c946449ea7e01647dc1fc3e0037",
                    "mallCategoryId":"2c9f6c946449ea7e01647ccf3b97001d",
                    "mallSubName":"速冻食品",
                    "comments":""
                }
            ],
            "comments":null,
            "image":"http://images.baixingliangfan.cn/firstCategoryPicture/20190131/20190131170133_4419.png"
        },
        {
            "mallCategoryId":"2c9f6c946449ea7e01647ccdb0e0001c",
            "mallCategoryName":"饮料",
            "bxMallSubDto":[
                {
                    "mallSubId":"2c9f6c946449ea7e01647d09cbf6002d",
                    "mallCategoryId":"2c9f6c946449ea7e01647ccdb0e0001c",
                    "mallSubName":"茶饮",
                    "comments":""
                },
                {
                    "mallSubId":"2c9f6c946449ea7e01647d09f7e8002e",
                    "mallCategoryId":"2c9f6c946449ea7e01647ccdb0e0001c",
                    "mallSubName":"水饮",
                    "comments":""
                },
                {
                    "mallSubId":"2c9f6c946449ea7e01647d0a27e1002f",
                    "mallCategoryId":"2c9f6c946449ea7e01647ccdb0e0001c",
                    "mallSubName":"功能饮料",
                    "comments":""
                },
                {
                    "mallSubId":"2c9f6c946449ea7e01647d0b1d4d0030",
                    "mallCategoryId":"2c9f6c946449ea7e01647ccdb0e0001c",
                    "mallSubName":"果汁",
                    "comments":""
                },
                {
                    "mallSubId":"2c9f6c946449ea7e01647d14192b0031",
                    "mallCategoryId":"2c9f6c946449ea7e01647ccdb0e0001c",
                    "mallSubName":"含乳饮料",
                    "comments":""
                },
                {
                    "mallSubId":"2c9f6c946449ea7e01647d24d9600032",
                    "mallCategoryId":"2c9f6c946449ea7e01647ccdb0e0001c",
                    "mallSubName":"碳酸饮料",
                    "comments":""
                }
            ],
            "comments":null,
            "image":"http://images.baixingliangfan.cn/firstCategoryPicture/20190131/20190131170143_361.png"
        },
        {
            "mallCategoryId":"2c9f6c946449ea7e01647cd108b60020",
            "mallCategoryName":"乳制品",
            "bxMallSubDto":[
                {
                    "mallSubId":"2c9f6c946449ea7e01647dd4ac8c0048",
                    "mallCategoryId":"2c9f6c946449ea7e01647cd108b60020",
                    "mallSubName":"常温纯奶",
                    "comments":""
                },
                {
                    "mallSubId":"2c9f6c946449ea7e01647dd4f6a40049",
                    "mallCategoryId":"2c9f6c946449ea7e01647cd108b60020",
                    "mallSubName":"常温酸奶",
                    "comments":""
                },
                {
                    "mallSubId":"2c9f6c946449ea7e01647dd51ab7004a",
                    "mallCategoryId":"2c9f6c946449ea7e01647cd108b60020",
                    "mallSubName":"低温奶",
                    "comments":""
                }
            ],
            "comments":null,
            "image":"http://images.baixingliangfan.cn/firstCategoryPicture/20190131/20190131170151_9234.png"
        },
        {
            "mallCategoryId":"2c9f6c946449ea7e01647ccfddb3001e",
            "mallCategoryName":"休闲零食",
            "bxMallSubDto":[
                {
                    "mallSubId":"2c9f6c946449ea7e01647dc51d93003c",
                    "mallCategoryId":"2c9f6c946449ea7e01647ccfddb3001e",
                    "mallSubName":"方便食品",
                    "comments":""
                },
                {
                    "mallSubId":"2c9f6c946449ea7e01647dd204dc0040",
                    "mallCategoryId":"2c9f6c946449ea7e01647ccfddb3001e",
                    "mallSubName":"面包糕点",
                    "comments":""
                },
                {
                    "mallSubId":"2c9f6c946449ea7e01647dd22f760041",
                    "mallCategoryId":"2c9f6c946449ea7e01647ccfddb3001e",
                    "mallSubName":"糖果巧克力",
                    "comments":""
                },
                {
                    "mallSubId":"2c9f6c946449ea7e01647dd254530042",
                    "mallCategoryId":"2c9f6c946449ea7e01647ccfddb3001e",
                    "mallSubName":"膨化食品",
                    "comments":""
                },
                {
                    "mallSubId":"2c9f6c94679b4fb10167f7fa132b15e7",
                    "mallCategoryId":"2c9f6c946449ea7e01647ccfddb3001e",
                    "mallSubName":"坚果炒货",
                    "comments":null
                },
                {
                    "mallSubId":"2c9f6c94679b4fb10167f7f4bfc415e2",
                    "mallCategoryId":"2c9f6c946449ea7e01647ccfddb3001e",
                    "mallSubName":"肉干豆干",
                    "comments":null
                },
                {
                    "mallSubId":"2c9f6c94679b4fb10167f7f5027a15e3",
                    "mallCategoryId":"2c9f6c946449ea7e01647ccfddb3001e",
                    "mallSubName":"饼干",
                    "comments":null
                },
                {
                    "mallSubId":"2c9f6c94679b4fb10167f7f530fd15e4",
                    "mallCategoryId":"2c9f6c946449ea7e01647ccfddb3001e",
                    "mallSubName":"冲调",
                    "comments":null
                },
                {
                    "mallSubId":"2c9f6c94683a6b0d016846b49436003b",
                    "mallCategoryId":"2c9f6c946449ea7e01647ccfddb3001e",
                    "mallSubName":"休闲水果",
                    "comments":null
                }
            ],
            "comments":null,
            "image":"http://images.baixingliangfan.cn/firstCategoryPicture/20190131/20190131170200_7553.png"
        },
        {
            "mallCategoryId":"2c9f6c946449ea7e01647cd08369001f",
            "mallCategoryName":"粮油调味",
            "bxMallSubDto":[
                {
                    "mallSubId":"2c9f6c946449ea7e01647dd2e8270043",
                    "mallCategoryId":"2c9f6c946449ea7e01647cd08369001f",
                    "mallSubName":"油/粮食",
                    "comments":""
                },
                {
                    "mallSubId":"2c9f6c946449ea7e01647dd31bca0044",
                    "mallCategoryId":"2c9f6c946449ea7e01647cd08369001f",
                    "mallSubName":"调味品",
                    "comments":""
                },
                {
                    "mallSubId":"2c9f6c946449ea7e01647dd35a980045",
                    "mallCategoryId":"2c9f6c946449ea7e01647cd08369001f",
                    "mallSubName":"酱菜罐头",
                    "comments":""
                }
            ],
            "comments":null,
            "image":"http://images.baixingliangfan.cn/firstCategoryPicture/20181212/20181212115842_9733.png"
        }
    ]
}
```


### 商品分类页中的商品列表

- 接口地址：wxmini/getMallGoods

- 参数：
1. categoryId:大类ID，字符串类型
2. categorySubId : 子类ID，字符串类型，如果没有可以填写空字符串，例如''
3. page: 分页的页数，int类型

- 返回参数 
1. goodsId:商品的Id，用于进入商品页时，查询商品详情。 
2. goodsName: 商品名称 
3. image： 商品的图片 
4. oriPrice： 市场价格（贵的价格） 
5. presentPrice：商城价格(便宜的价格)

**Post**

http://v.jspang.com:8088/baixing/wxmini/getMallGoods

全部

{
    "categoryId": "4",
    "categorySubId": "",
    "page": 1
}

or 二级分类下的

{
    "categoryId": "4",
    "categorySubId": "2c9f6c94621970a801626a35cb4d0175",
    "page": 1
}


```

{
    "code":"0",
    "message":"success",
    "data":[
        {
            "image":"http://images.baixingliangfan.cn/compressedPic/20180717093312_6137.jpg",
            "oriPrice":0.28,
            "presentPrice":0.25,
            "goodsName":"大大泡泡糖",
            "goodsId":"eea505acb1944bbf8ec98ad107113874"
        },
        {
            "image":"http://images.baixingliangfan.cn/compressedPic/20180717113033_1401.jpg",
            "oriPrice":0.78,
            "presentPrice":0.7,
            "goodsName":"玉美鲜鱿鱼味香脆饼15g",
            "goodsId":"2191ec0ab49f4f4da498f9f768ad5528"
        },
        {
            "image":"http://images.baixingliangfan.cn/compressedPic/20180716214046_5472.jpg",
            "oriPrice":1.11,
            "presentPrice":1,
            "goodsName":"劲仔鱼麻辣味12g",
            "goodsId":"2d0c7cb285384355804dcd510bacf9cf"
        },
        {
            "image":"http://images.baixingliangfan.cn/compressedPic/20180717084351_484.jpg",
            "oriPrice":1.11,
            "presentPrice":1,
            "goodsName":"不二家果味大棒棒糖混合口味盒装",
            "goodsId":"be4d7001e5994e40bff17e45a47f18db"
        },
        {
            "image":"http://images.baixingliangfan.cn/compressedPic/20190121101250_3231.jpg",
            "oriPrice":1.21,
            "presentPrice":1.1,
            "goodsName":"汉德百士菠萝啤500ml",
            "goodsId":"80a28efdb16b4fa29884095ef1399a7e"
        },
        {
            "image":"http://images.baixingliangfan.cn/compressedPic/20190116160606_7101.jpg",
            "oriPrice":1.5,
            "presentPrice":1.2,
            "goodsName":"农夫山泉天然水550ml",
            "goodsId":"63d54204ce244418ac05aec800190cef"
        },
        {
            "image":"http://images.baixingliangfan.cn/compressedPic/20190116160156_7714.jpg",
            "oriPrice":2,
            "presentPrice":1.4,
            "goodsName":"怡宝纯净水555ml",
            "goodsId":"6cd7b5875f2d4049bb1667342be34c75"
        },
        {
            "image":"http://images.baixingliangfan.cn/compressedPic/20180716155456_1449.jpg",
            "oriPrice":2.1,
            "presentPrice":1.5,
            "goodsName":"泡椒鸡爪（一个）",
            "goodsId":"05b9e1b4bc6a49e580f3f5c92acbaf20"
        },
        {
            "image":"http://images.baixingliangfan.cn/compressedPic/20190116161123_8945.jpg",
            "oriPrice":1.8,
            "presentPrice":1.5,
            "goodsName":"娃哈哈纯净水596ml",
            "goodsId":"22bb7be334234189ab249ba86ec94c6f"
        },
        {
            "image":"http://images.baixingliangfan.cn/compressedPic/20190116145309_40.jpg",
            "oriPrice":2.5,
            "presentPrice":1.8,
            "goodsName":"哈尔滨冰爽啤酒330ml",
            "goodsId":"3194330cf25f43c3934dbb8c2a964ade"
        },
        {
            "image":"http://images.baixingliangfan.cn/compressedPic/20190115185215_1051.jpg",
            "oriPrice":2,
            "presentPrice":1.8,
            "goodsName":"燕京啤酒8°330ml",
            "goodsId":"522a3511f4c545ab9547db074bb51579"
        },
        {
            "image":"http://images.baixingliangfan.cn/compressedPic/20180717164555_4844.jpg",
            "oriPrice":2.5,
            "presentPrice":1.8,
            "goodsName":"伊利纯鲜牛奶240ml",
            "goodsId":"9f21e652df644c44b29e6aef27f4f56f"
        },
        {
            "image":"http://images.baixingliangfan.cn/compressedPic/20190121102419_9362.jpg",
            "oriPrice":1.98,
            "presentPrice":1.8,
            "goodsName":"崂山清爽8°330ml",
            "goodsId":"bbdbd5028cc849c2998ff84fb55cb934"
        },
        {
            "image":"http://images.baixingliangfan.cn/compressedPic/20180712181330_9746.jpg",
            "oriPrice":2.5,
            "presentPrice":1.9,
            "goodsName":"雪花啤酒8°清爽330ml",
            "goodsId":"87013c4315e54927a97e51d0645ece76"
        },
        {
            "image":"http://images.baixingliangfan.cn/compressedPic/20190116161604_1223.jpg",
            "oriPrice":2.22,
            "presentPrice":2,
            "goodsName":"天喔茶庄蜂蜜柚子茶(l利乐）250ml/盒",
            "goodsId":"14d28dbda7214aa39ca7177144f77c8b"
        },
        {
            "image":"http://images.baixingliangfan.cn/compressedPic/20190116161349_2735.jpg",
            "oriPrice":2,
            "presentPrice":2,
            "goodsName":"今麦郎凉白开500ml/瓶",
            "goodsId":"63ac261a8a964ad2b68c10df50f132db"
        },
        {
            "image":"http://images.baixingliangfan.cn/compressedPic/20180716213830_6267.jpg",
            "oriPrice":2.22,
            "presentPrice":2,
            "goodsName":"无穷农场盐焗鸡蛋30g",
            "goodsId":"6a07941fe90b4483b765fffd79a01dac"
        },
        {
            "image":"http://images.baixingliangfan.cn/compressedPic/20180717235006_2382.jpg",
            "oriPrice":3,
            "presentPrice":2,
            "goodsName":"景田百岁山矿泉水570ml/瓶",
            "goodsId":"a6207b017d954a0e8a5b5b137ac7329e"
        },
        {
            "image":"http://images.baixingliangfan.cn/compressedPic/20180717115346_7802.jpg",
            "oriPrice":2.22,
            "presentPrice":2,
            "goodsName":"花花牛酸牛奶160g",
            "goodsId":"babd01169b42413eac9e6fd82e21cd7b"
        },
        {
            "image":"http://images.baixingliangfan.cn/compressedPic/20190116170518_7239.jpg",
            "oriPrice":2.22,
            "presentPrice":2,
            "goodsName":"今麦郎芒顿小镇水蜜桃味饮料500ml",
            "goodsId":"be7323f3e94c435081abbfdc6dac691e"
        }
    ]
}



```


### 商品详情

- 接口地址：wxmini/getGoodDetailById

- 参数
1. goodId 商品的Id

- 返回参数

1. goodInfo 商品信息
2. goodComments 商品评价
3. advertesPicture 广告


**Post**

http://v.jspang.com:8088/baixing/wxmini/getGoodDetailById

{
 "goodId":"035b55e444db4d308fd963543c7d884f"
}

```

{
    "code":"0",
    "message":"success",
    "data":{
        "goodInfo":{
            "image5":"",
            "amount":10000,
            "image3":"",
            "image4":"",
            "goodsId":"035b55e444db4d308fd963543c7d884f",
            "isOnline":"yes",
            "image1":"http://images.baixingliangfan.cn/shopGoodsImg/20190118/20190118101813_9360.jpg",
            "image2":"",
            "goodsSerialNumber":"6920794458051",
            "oriPrice":3.3,
            "presentPrice":3,
            "comPic":"http://images.baixingliangfan.cn/compressedPic/20190118101813_9360.jpg",
            "state":1,
            "shopId":"402880e860166f3c0160167897d60002",
            "goodsName":"京宫二锅头56°100ml",
            "goodsDetail":"<img src="http://images.baixingliangfan.cn/shopGoodsDetailImg/20190118/20190118101819_6791.jpg" width="100%" height="auto" alt="" /><img src="http://images.baixingliangfan.cn/shopGoodsDetailImg/20190118/20190118101819_1891.jpg" width="100%" height="auto" alt="" /><img src="http://images.baixingliangfan.cn/shopGoodsDetailImg/20190118/20190118101819_908.jpg" width="100%" height="auto" alt="" /><img src="http://images.baixingliangfan.cn/shopGoodsDetailImg/20190118/20190118101819_5209.jpg" width="100%" height="auto" alt="" /><img src="http://images.baixingliangfan.cn/shopGoodsDetailImg/20190118/20190118101819_6593.jpg" width="100%" height="auto" alt="" />"
        },
        "goodComments":[
            {
                "SCORE":5,
                "comments":"第一次在网上的超市购买商品，很有意思，赞���",
                "userName":"155******30",
                "discussTime":1549168700664
            }
        ],
        "advertesPicture":{
            "PICTURE_ADDRESS":"http://images.baixingliangfan.cn/advertesPicture/20190113/20190113134955_5825.jpg",
            "TO_PLACE":"1"
        }
    }
}
```


