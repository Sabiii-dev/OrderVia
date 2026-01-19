class Product {
  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.currency,
    required this.imageUrl,
    this.subtitle,
    this.category,
    this.productUrl,
  });

  final String id;
  final String title;
  final String? subtitle;
  final String? category;
  final double price;
  final String currency;
  final String imageUrl;
  final String? productUrl;
}

