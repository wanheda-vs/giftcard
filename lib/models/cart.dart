import 'package:flutter/foundation.dart';
import 'gift_card.dart';

class CartItem {
  final GiftCard giftCard;
  int quantity;

  CartItem({required this.giftCard, this.quantity = 1});
}

class Cart extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  void addItem(GiftCard giftCard) {
    final existingIndex =
        _items.indexWhere((item) => item.giftCard.id == giftCard.id);

    if (existingIndex >= 0) {
      _items[existingIndex].quantity += 1;
    } else {
      _items.add(CartItem(giftCard: giftCard));
    }
    notifyListeners();
  }

  void removeItem(String giftCardId) {
    _items.removeWhere((item) => item.giftCard.id == giftCardId);
    notifyListeners();
  }

  double get total => _items.fold(
        0,
        (sum, item) => sum + (item.giftCard.price * item.quantity),
      );
}
