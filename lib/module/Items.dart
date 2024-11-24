import 'dart:convert';
import 'package:http/http.dart' as http;

class Item {
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  Item({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      name: json['productName'] ?? 'No name',
      description: json['description'] ?? 'No description',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      imageUrl: json['Image'] ?? '',
    );
  }
}

Future<List<Item>> fetchItems() async {
  final response = await http.get(
    Uri.parse('https://cleardress-us.backendless.app/api/data/Products'),
  );

  if (response.statusCode == 200) {
    final List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => Item.fromJson(data)).toList();
  } else {
    throw Exception('Failed to load items');
  }
}
