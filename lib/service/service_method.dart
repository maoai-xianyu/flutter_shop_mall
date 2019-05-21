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
