import 'package:flutter/material.dart';
import 'package:giftcard_market/components/navBar.dart';
import 'package:giftcard_market/components/addCardDialog.dart';
import 'package:giftcard_market/homePage.dart';
import 'package:giftcard_market/cartPage.dart';
import 'package:giftcard_market/profilePage.dart';
import 'package:giftcard_market/theme/colors.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  int _currentIndex = 0;

  void _onNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  static const appBarTitle = ["Cart", "Home", "Profile"];

  void _showAddCardDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.primary,
      builder: (context) => const AddCardDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle[_currentIndex]),
        actions: [
          Visibility(
            visible: _currentIndex == 0,
            child: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                // TODO: Implement search functionality
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _showAddCardDialog();
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: const [CartPage(), HomePage(), ProfilePage()],
      ),
      bottomNavigationBar: NavBar(
        currentIndex: _currentIndex,
        onTap: _onNavTap,
      ),
    );
  }
}
