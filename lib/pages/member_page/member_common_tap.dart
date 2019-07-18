import 'package:flutter/material.dart';

class MemberCommonTap extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subTitle;
  final String type;
  final bool isShowSub;

  MemberCommonTap(
      this.icon, this.title, this.subTitle, this.type, this.isShowSub);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListTile(
        onTap: () {
          switch (type) {
            case '1':
              break;

            case '2':
              break;

            case '3':
              break;

            case '4':
              break;
            default:
              break;
          }
        },
        leading: Icon(icon),
        title: Text(title),
        //subtitle: isShowSub ? Text(subTitle) : Text(''),
        trailing: Icon(Icons.arrow_right),
      ),
    );
  }
}
