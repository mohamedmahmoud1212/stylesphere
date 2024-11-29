// import 'dart:convert';
// import 'package:http/http.dart' as http;

class Users {
  final String myCart;
  final String address;
  final double email;
  final String name;
  final String phoneNumber;

  final String accountType;

  Users({
    required this.name,
    required this.myCart,
    required this.address,
    required this.email,
    required this.phoneNumber,
    required this.accountType,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      name: json['name'] ?? 'User',
      myCart: json['myCart'] ?? 'No items yet', // use json or any logic
      address: json['Address'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['PhoneNumber'] ?? '',
      accountType: json['accountType'] ?? '',
    );
  }
}

// Future<List<Users>> fetchUsers() async {
//   final response = await http.get(
//     Uri.parse('https://cleardress-us.backendless.app/api/data/Users'),
//   );

//   if (response.statusCode == 200) {
//     final List jsonResponse = json.decode(response.body);
//     return jsonResponse.map((data) => Users.fromJson(data)).toList();
//   } else {
//     throw Exception('Failed to load items');
//   }
// }
