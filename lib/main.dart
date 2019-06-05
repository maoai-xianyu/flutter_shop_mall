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
