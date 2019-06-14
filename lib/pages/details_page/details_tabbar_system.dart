import 'package:flutter/material.dart';

class DetailsTabBarSystem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Container(
        child: Column(
          children: <Widget>[
            TabBar(
              unselectedLabelColor: Colors.black38,
              indicatorColor: Colors.black54,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: 1.0,
              tabs: <Widget>[
                Tab(icon: Icon(Icons.local_florist)),
                Tab(icon: Icon(Icons.change_history)),
              ],
            ),
            TabBarView(
              children: <Widget>[
                Text('sss'),
                Text('ddddds'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}