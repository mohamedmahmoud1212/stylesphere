class Item {
  final String documentID;
  final String name;

  final String? image;
  final String? email;
  final String? phone;
  final String? description;
  final double? price;
  final String? category;
  final String? interest;

  Item({
    required this.documentID,
    required this.name,
    this.description,
    this.price,
    this.image,
    this.category,
    this.interest,
    this.email,
    this.phone,
  });

  factory Item.fromJson(Map<String, dynamic> json, String documentID) {
    return Item(
      documentID: documentID,
      name: json['Name'] ?? "No Name",
      category: json['Category'] ?? "No Category",
      price: (json['Price'] ?? 0.0) as double,
      description: json['Description'] ?? "No description",
      interest: json['Interest'] ?? "All",
      image: json['Image'] ?? "No Image" as String?,
      email: json['email'] ?? "No Email" as String?,
      phone: json['PhoneNumber'] ?? "No Phone" as String?,
    );
  }
}
