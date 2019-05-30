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



