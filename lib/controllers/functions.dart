import 'dart:math';

String genTransactionId() {
  var random = Random();
  String randomDigits =
      List.generate(8, (_) => random.nextInt(10).toString()).join();
  String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
  String transactionId = "TXN-${timestamp.substring(7)}-$randomDigits";

  return transactionId;
}
