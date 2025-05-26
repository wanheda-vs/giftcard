import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:giftcard_market/models/transaction.dart';

class StorageService {
  static const String _userKey = 'user_data';
  static const String _transactionsKey = 'transactions';

  // User data methods
  Future<void> saveUserData(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, jsonEncode(userData));
  }

  Future<Map<String, dynamic>?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString(_userKey);
    if (userData != null) {
      return jsonDecode(userData) as Map<String, dynamic>;
    }
    return null;
  }

  Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }

  // Transaction methods
  Future<void> saveTransaction(Transaction transaction) async {
    final prefs = await SharedPreferences.getInstance();
    final transactions = await getTransactions() ?? [];
    transactions.add(transaction);
    await prefs.setString(
      _transactionsKey,
      jsonEncode(transactions.map((t) => t.toJson()).toList()),
    );
  }

  Future<List<Transaction>?> getTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    final transactions = prefs.getString(_transactionsKey);
    if (transactions != null) {
      final List<dynamic> decoded = jsonDecode(transactions);
      return decoded.map((json) => Transaction.fromJson(json)).toList();
    }
    return null;
  }

  Future<void> updateTransactionStatus(
      String transactionId, String newStatus) async {
    final transactions = await getTransactions() ?? [];
    final index = transactions.indexWhere((t) => t.id == transactionId);
    if (index != -1) {
      final transaction = transactions[index];
      transactions[index] = Transaction(
        id: transaction.id,
        type: transaction.type,
        giftCardName: transaction.giftCardName,
        amount: transaction.amount,
        price: transaction.price,
        date: transaction.date,
        status: newStatus,
      );
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        _transactionsKey,
        jsonEncode(transactions.map((t) => t.toJson()).toList()),
      );
    }
  }

  Future<void> clearTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_transactionsKey);
  }
}
