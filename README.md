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
