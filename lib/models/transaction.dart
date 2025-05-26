class Transaction {
  final String id;
  final String type; // 'buy' or 'sell'
  final String giftCardName;
  final double amount;
  final double price;
  final DateTime date;
  final String status; // 'pending', 'completed', 'cancelled'

  Transaction({
    required this.id,
    required this.type,
    required this.giftCardName,
    required this.amount,
    required this.price,
    required this.date,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'giftCardName': giftCardName,
      'amount': amount,
      'price': price,
      'date': date.toIso8601String(),
      'status': status,
    };
  }

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      type: json['type'],
      giftCardName: json['giftCardName'],
      amount: json['amount'].toDouble(),
      price: json['price'].toDouble(),
      date: DateTime.parse(json['date']),
      status: json['status'],
    );
  }
}
