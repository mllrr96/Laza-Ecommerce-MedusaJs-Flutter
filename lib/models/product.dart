class Product {
  final String title;
  final String thumbnailPath;
  final String price;
  final String? category;
  final String? description;
  final List<String>? images;
  const Product({
    required this.title,
    required this.thumbnailPath,
    required this.price,
    this.category,
    this.images,this.description,
  });
}
