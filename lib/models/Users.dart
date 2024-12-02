class Users {
  final String? myCart;
  final String email;
  final String name;
  final String phoneNumber;
  final String accountType;

  Users({
    required this.name,
    this.myCart,
    required this.email,
    required this.phoneNumber,
    required this.accountType,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      name: json['Name'] ?? '',
      myCart: json['myCart'] ?? 'No items yet',
      email: json['Email'] ?? '',
      phoneNumber: json['PhoneNumber'] ?? 'No phone number',
      accountType: json['accountType'] ?? '',
    );
  }
}
