import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop_mall/model/detailsGoodsModel.dart';
import 'package:flutter_shop_mall/provide/details_goods_provide.dart';
import 'package:provide/provide.dart';
import 'package:flutter_html/flutter_html.dart';

class DetailsWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var goodsDetail = Provide.value<DetailsGoodsProvide>(context)
        .detailsGoods
        .data
        .goodInfo
        .goodsDetail;

    debugPrint(' goodsDetail  $goodsDetail');

    var goodsComment = Provide.value<DetailsGoodsProvide>(context)
        .detailsGoods
        .data
        .goodComments;

    if (goodsComment != null && goodsComment.length > 0) {
      debugPrint(' goodsComment  ${goodsComment[0].userName}');
    }

    var advertesPicture = Provide.value<DetailsGoodsProvide>(context)
        .detailsGoods
        .data
        .advertesPicture;

    debugPrint(' advertesPicture  ${advertesPicture.pICTUREADDRESS}');

    return Provide<DetailsGoodsProvide>(
      builder: (context, child, detailsGoodsProvide) {
        var isLeft = Provide.value<DetailsGoodsProvide>(context).isLeft;
        if (isLeft) {
          return Container(
            child: Html(data: goodsDetail),
          );
        } else {
          if (goodsComment != null && goodsComment.length > 0) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: ScreenUtil().setWidth(1000),
                  decoration: BoxDecoration(
                    color: Colors.red,
                  ),
                  width: ScreenUtil().setWidth(750),
                  child: Flexible(
                    child: ListView.builder(
                      itemCount: goodsComment.length,
                      itemBuilder: (context, index) {
                        return _showComments(goodsComment[index]);
                      },
                    ),
                  ),
                ),
                Image.network(advertesPicture.pICTUREADDRESS),
              ],
            );
          } else {
            if (advertesPicture != null) {
              return Image.network(advertesPicture.pICTUREADDRESS);
            } else {
              return Container(
                width: ScreenUtil().setWidth(750),
                margin: EdgeInsets.only(top: 15),
                padding: EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: Text("当前还没有评论哦"),
              );
            }
          }
        }
      },
    );
  }

  Widget _showComments(GoodComments comment) {
    return Container(
      padding: EdgeInsets.only(left: 10, top: 20),
      child: Column(
        children: <Widget>[
          Text(
            comment.userName,
            style: TextStyle(
              color: Colors.black,
              fontSize: ScreenUtil().setSp(24),
            ),
          ),
          Text(
            comment.comments,
            style: TextStyle(
              color: Colors.black26,
              fontSize: ScreenUtil().setSp(24),
            ),
          ),
          Text(
            '${comment.discussTime}',
            style: TextStyle(
              color: Colors.black45,
              fontSize: ScreenUtil().setSp(24),
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(1),
          )
        ],
      ),
    );
  }
}
