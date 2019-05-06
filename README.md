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