class Cart {
  int? cartid;
  int? userid;
  int? itemid;
  int? quantity;
  String? color;
  String? size;
  String? name;
  double? rating;
  List<String>? tags;
  double? price;
  List<String>? sizes;
  List<String>? colors;
  String? description;
  String? image;

  Cart(
      {this.cartid,
      this.userid,
      this.itemid,
      this.quantity,
      this.color,
      this.size,
      this.name,
      this.rating,
      this.tags,
      this.price,
      this.sizes,
      this.colors,
      this.description,
      this.image});

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        cartid: int.parse(json['cart_id']),
        userid: int.parse(json['user_id']),
        itemid: int.parse(json['item_id']),
        quantity: int.parse(json['quantity']),
        color: json['color'],
        size: json['size'],
        name: json['name'],
        rating: double.parse(json['rating']),
        tags: json['tags'].toString().split(', '),
        price: double.parse(json['price']),
        sizes: json['sizes'].toString().split(', '),
        colors: json['colors'].toString().split(', '),
        description: json['description'],
        image: json['image'],
      );
}
