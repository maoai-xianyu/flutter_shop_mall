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