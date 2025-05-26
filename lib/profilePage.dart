import 'package:flutter/material.dart';
import 'package:giftcard_market/screens/auth/login_screen.dart';
import 'package:giftcard_market/services/storage_service.dart';
import 'package:giftcard_market/theme/colors.dart';
import 'package:giftcard_market/models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:giftcard_market/components/ShadowButton.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _storageService = StorageService();
  Map<String, dynamic>? _userData;
  List<Transaction>? _transactions;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _loadTransactions();
  }

  Future<void> _loadUserData() async {
    final userData = await _storageService.getUserData();
    setState(() {
      _userData = userData;
    });
  }

  Future<void> _loadTransactions() async {
    final transactions = await _storageService.getTransactions();
    setState(() {
      _transactions = transactions;
    });
  }

  Future<void> _logout() async {
    await _storageService.clearUserData();
    setState(() {
      _userData = null;
      _transactions = null;
    });
  }

  String _formatDate(DateTime date) {
    return DateFormat('MMM d, y').format(date);
  }

  String _formatCurrency(double amount) {
    return '\$${amount.toStringAsFixed(2)}';
  }

  @override
  Widget build(BuildContext context) {
    if (_userData == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Please login to view your profile',
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 20),
            ShadowButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
                if (result == true) {
                  _loadUserData();
                  _loadTransactions();
                }
              },
              borderRadius: 35,
              buttonChild: const Text(
                'Login',
                style: TextStyle(color: Colors.white),
              ),
              buttonColor: AppColors.primary,
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Profile',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 30),
          Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name: ${_userData!['name'] ?? 'Not set'}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Email: ${_userData!['email']}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            'Transaction History',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          if (_transactions == null || _transactions!.isEmpty)
            const Center(
              child: Text(
                'No transactions yet',
                style: TextStyle(color: Colors.white70),
              ),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _transactions!.length,
              itemBuilder: (context, index) {
                final transaction = _transactions![index];
                return Card(
                  color: Colors.white,
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    title: Text(
                      '${transaction.type.toUpperCase()} - ${transaction.giftCardName}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      '${_formatDate(transaction.date)} • ${_formatCurrency(transaction.amount)}',
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          _formatCurrency(transaction.price),
                          style: TextStyle(
                            color: transaction.type == 'buy'
                                ? Colors.red
                                : Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          transaction.status,
                          style: TextStyle(
                            color: transaction.status == 'completed'
                                ? Colors.green
                                : transaction.status == 'cancelled'
                                    ? Colors.red
                                    : Colors.orange,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _logout,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.tertiary1,
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
