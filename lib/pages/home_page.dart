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
