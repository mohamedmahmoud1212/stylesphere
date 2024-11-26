import 'dart:convert';
import 'package:http/http.dart' as http;

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
