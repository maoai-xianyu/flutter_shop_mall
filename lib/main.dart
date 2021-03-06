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
