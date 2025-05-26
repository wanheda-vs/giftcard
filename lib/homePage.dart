import 'package:flutter/material.dart';
import 'package:giftcard_market/models/gift_card.dart';
import 'package:giftcard_market/models/cart.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<GiftCard> _displayedCards = [];

  @override
  void initState() {
    super.initState();
    _displayedCards.addAll(sampleGiftCards);
    // Set up the callback for when items are removed from cart
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cart = Provider.of<Cart>(context, listen: false);
      cart.onItemRemoved = _handleCartItemRemoved;
    });
  }

  void _handleCartItemRemoved(GiftCard giftCard) {
    setState(() {
      if (!_displayedCards.any((card) => card.id == giftCard.id)) {
        _displayedCards.add(giftCard);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, cart, child) {
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: _displayedCards.length,
          itemBuilder: (context, index) {
            final giftCard = _displayedCards[index];
            return Dismissible(
              key: Key(giftCard.id),
              direction: DismissDirection.endToStart,
              background: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
              ),
              onDismissed: (direction) {
                setState(() {
                  _displayedCards.removeAt(index);
                });
                cart.addItem(giftCard);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${giftCard.name} added to cart'),
                    duration: const Duration(seconds: 2),
                    action: SnackBarAction(
                      label: 'UNDO',
                      onPressed: () {
                        setState(() {
                          _displayedCards.insert(index, giftCard);
                        });
                        cart.removeItem(giftCard.id);
                      },
                    ),
                  ),
                );
              },
              child: Card(
                margin: const EdgeInsets.only(bottom: 16),
                elevation: 2,
                child: Row(
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(10),
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.card_giftcard,
                          size: 48,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              giftCard.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '\$${giftCard.price.toStringAsFixed(2)}',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              giftCard.platform,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              giftCard.description,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
