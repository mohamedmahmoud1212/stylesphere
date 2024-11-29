class Item {
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  final String interest;

  Item({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.interest,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      name: json['Name'] ?? 'No name',
      description: json['Description'] ?? 'No description.',
      imageUrl: json['Image'] ?? '',
      category: json['Category'] ?? 'Null',
      interest: json['Interest'] ?? 'Everyone',
      price: (json['Price'] as num?)?.toDouble() ?? 1.99,
    );
  }
}
