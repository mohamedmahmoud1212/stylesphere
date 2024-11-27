class Billing {
  final int cvv;
  final int cardNumber;
  final double balance;
  final String expDate;
  final String lastTransID;

  Billing({
    required this.cvv,
    required this.cardNumber,
    required this.balance,
    required this.expDate,
    required this.lastTransID,
  });

  factory Billing.fromJson(Map<String, dynamic> json) {
    return Billing(
      cvv: json['CVV'] ?? '',
      cardNumber: json['CardNumber'] ?? '',
      expDate: json['ExpDate'] ?? '',
      lastTransID: json['LastTransID'] ?? '',
      balance: (json['Balance'] as num?)?.toDouble() ?? 0,
    );
  }
}
