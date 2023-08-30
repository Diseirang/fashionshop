class Item {
  int? id;
  String? name;
  double? rating;
  List<String>? tags;
  double? price;
  List<String>? sizes;
  List<String>? colors;
  String? description;
  String? image;

  Item(
    this.id,
    this.name,
    this.rating,
    this.tags,
    this.price,
    this.sizes,
    this.colors,
    this.description,
    this.image,
  );

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        int.parse(json['item_id']),
        json['name'],
        double.parse(json['rating']),
        json['tags'].toString().split(
              ',',
            ),
        double.parse(json['price']),
        json['sizes'].toString().split(','),
        json['colors'].toString().split(','),
        json['description'],
        json['image'],
      );
}

// class Item
// {
//   int? id;
//   String? name;
//   double? rating;
//   List<String>? tags;
//   double? price;
//   List<String>? sizes;
//   List<String>? colors;
//   String? description;
//   String? image;

//   Item({
//     this.id,
//     this.name,
//     this.rating,
//     this.tags,
//     this.price,
//     this.sizes,
//     this.colors,
//     this.description,
//     this.image,
//   });

//   factory Item.fromJson(Map<String, dynamic> json) => Item(
//     id: int.parse(json["item_id"]),
//     name: json["name"],
//     rating: double.parse(json["rating"]),
//     tags: json["tags"].toString().split(","),
//     price: double.parse(json["price"]),
//     sizes: json["sizes"].toString().split(","),
//     colors: json["colors"].toString().split(","),
//     description: json['description'],
//     image: json['image'],
//   );
// }
