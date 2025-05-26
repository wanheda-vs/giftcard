import 'package:flutter/foundation.dart';
import 'gift_card.dart';

class CartItem {
  final GiftCard giftCard;
  int quantity;

  CartItem({required this.giftCard, this.quantity = 1});
}

class Cart extends ChangeNotifier {
  final List<CartItem> _items = [];
  Function(GiftCard)? onItemRemoved;

  Cart(); // Explicit constructor

  List<CartItem> get items => List.unmodifiable(_items);

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
    final index = _items.indexWhere((item) => item.giftCard.id == giftCardId);
    if (index >= 0) {
      final removedItem = _items[index].giftCard;
      _items.removeAt(index);
      notifyListeners();
      if (onItemRemoved != null) {
        onItemRemoved!(removedItem);
      }
    }
  }

  double get total => _items.fold(
        0,
        (sum, item) => sum + (item.giftCard.price * item.quantity),
      );
}
