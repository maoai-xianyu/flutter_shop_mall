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
