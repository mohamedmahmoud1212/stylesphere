import 'dart:convert';
import 'package:http/http.dart' as http;

class Item {
  final int cvv;
  final int cardNumber;
  final double balance;
  final String expDate;
  final String lastTransID;

  Item({
    required this.cvv,
    required this.cardNumber,
    required this.balance,
    required this.expDate,
    required this.lastTransID,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      cvv: json['CVV'] ?? '',
      cardNumber: json['CardNumber'] ?? '',
      expDate: json['ExpDate'] ?? '',
      lastTransID: json['LastTransID'] ?? '',
      balance: (json['Balance'] as num?)?.toDouble() ?? 0,
    );
  }
}

Future<List<Item>> fetchBilling() async {
  final response = await http.get(
    Uri.parse('https://cleardress-us.backendless.app/api/data/Billing'),
  );

  if (response.statusCode == 200) {
    final List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => Item.fromJson(data)).toList();
  } else {
    throw Exception('Failed to load items');
  }
}
