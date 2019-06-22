class CartInfoModel {
  String goodsId;
  String goodsName;
  int count;
  double price;
  double oriPrice;
  String images;

  CartInfoModel(
      {this.goodsId, this.goodsName, this.count, this.price,this.oriPrice, this.images});

  CartInfoModel.fromJson(Map<String, dynamic> json) {
    goodsId = json['goodsId'];
    goodsName = json['goodsName'];
    count = json['count'];
    price = json['price'];
    oriPrice = json['oriPrice'];
    images = json['images'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['goodsId'] = this.goodsId;
    data['goodsName'] = this.goodsName;
    data['count'] = this.count;
    data['price'] = this.price;
    data['oriPrice'] = this.oriPrice;
    data['images'] = this.images;
    return data;
  }
}
