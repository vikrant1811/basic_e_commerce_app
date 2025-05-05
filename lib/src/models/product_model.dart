class ProductModel {
  final int id;
  final String title;
  final String description;
  final String image;
  final double price;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.price,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      image: json['thumbnail'] ?? '',
      price: json['price'].toDouble(),
    );
  }
}
