class Product {
  String pCode;
  String pTitle;
  int pQty;
  double pPrice;
  String pDesc;
  String pPic;

  Product(
      this.pCode, this.pTitle, this.pQty, this.pPrice, this.pDesc, this.pPic);

  Map<String, dynamic> toJson() => {
        'p_code': pCode,
        'p_title': pTitle,
        'p_qty': pQty.toString(),
        'p_price': pPrice.toString(),
        'p_desc': pDesc,
        'p_pic': pPic,
      };
}

