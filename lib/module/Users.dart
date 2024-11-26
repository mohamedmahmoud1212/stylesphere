import 'dart:convert';
import 'package:http/http.dart' as http;

class Item {
  final String myCart;
  final String address;
  final double email;
  final String name;
  final String phoneNumber;

  final String accountType; //BACKENDLESS = Admin

  Item({
    required this.name,
    required this.myCart,
    required this.address,
    required this.email,
    required this.phoneNumber,
    required this.accountType,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      name: json['Name'] ?? 'User',
      myCart: json['myCart'] ?? 'No items yet', // use json or any logic
      address: json['Address'] ?? '',
      email: json['Email'] ?? '',
      phoneNumber: json['PhoneNumber'] ?? 'Everyone',
      accountType: json['accountType'] ?? '',
    );
  }
}

Future<List<Item>> fetchUsers() async {
  final response = await http.get(
    Uri.parse('https://cleardress-us.backendless.app/api/data/Users'),
  );

  if (response.statusCode == 200) {
    final List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => Item.fromJson(data)).toList();
  } else {
    throw Exception('Failed to load items');
  }
}
