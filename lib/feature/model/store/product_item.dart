class ProductItem {
  ProductItem({
    this.id,
    this.name,
    this.description,
    this.price,
    this.productGallery,
  });

  String? id;
  String? name;
  dynamic description;
  num? price;
  List<dynamic>? productGallery;

  factory ProductItem.fromJson(Map<String, dynamic> json) => ProductItem(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        productGallery: json["product_gallery"] == null
            ? []
            : List<dynamic>.from(json["product_gallery"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "product_gallery": List<dynamic>.from(productGallery!.map((x) => x)),
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductItem &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
