import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/counter_provide.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 200),
          child: Column(
            children: <Widget>[
              NumberWidget(),
              AddButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class NumberWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Provide<CounterProvide>(builder: (context, child, counter) {
        return Text(
          '${counter.value}',
          style: Theme.of(context).textTheme.display1,
        );
      }),
    );
  }
}

class AddButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: RaisedButton(
        onPressed: () {
          Provide.value<CounterProvide>(context).increment();
        },
        child: Text('增加'),
      ),
    );
  }
}
