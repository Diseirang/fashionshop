class Cart {
  int cartid;
  int userid;
  int itemid;
  int quantity;
  String color;
  String size;
  String name;
  double rating;
  List<String> tags;
  double price;
  List<String> sizes;
  List<String> colors;
  String description;
  String image;

  Cart(
      this.cartid,
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
      this.image);

      factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        int.parse(json['cart_id']),
        int.parse(json['user_id']),
        int.parse(json['item_id']),
        int.parse(json['quantity']),
        json['color'],
        json['size'],
        json['name'],
        double.parse(json['rating']),
        json['tags'].toString().split(', '),
        double.parse(json['price']),
        json['sizes'].toString().split(', '),
        json['colors'].toString().split(', '),
        json['description'],
        json['image'],
      );
}
