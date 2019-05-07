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
        body: SingleChildScrollView(
          child: Container(
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
      ),
    );
  }

  void _choiceActionGirl() {
    debugPrint('点击选择美女');
    var typeText = textEditingController.text.toString();
    if (typeText == '') {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(title: Text('美女类型不能为空')),
      );
    } else {
      postHttp(typeText).then((value) {
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
}
