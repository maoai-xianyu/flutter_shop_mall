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
