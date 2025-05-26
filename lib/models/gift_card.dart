class GiftCard {
  final String id;
  final String platform;
  final String name;
  final double price;
  final String imageUrl;
  final String description;

  const GiftCard({
    required this.id,
    required this.platform,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
  });
}

// Sample gift card data
final List<GiftCard> sampleGiftCards = [
  GiftCard(
    id: '1',
    platform: 'Amazon',
    name: 'Amazon Gift Card',
    price: 50.00,
    imageUrl: 'https://example.com/amazon.png',
    description: 'Use for millions of items on Amazon.com',
  ),
  GiftCard(
    id: '2',
    platform: 'Steam',
    name: 'Steam Wallet Code',
    price: 25.00,
    imageUrl: 'https://example.com/steam.png',
    description: 'Add funds to your Steam wallet for games and software',
  ),
  GiftCard(
    id: '3',
    platform: 'Netflix',
    name: 'Netflix Gift Card',
    price: 30.00,
    imageUrl: 'https://example.com/netflix.png',
    description: 'Enjoy your favorite movies and TV shows',
  ),
  GiftCard(
    id: '4',
    platform: 'Spotify',
    name: 'Spotify Premium Gift Card',
    price: 15.00,
    imageUrl: 'https://example.com/spotify.png',
    description: 'Ad-free music streaming experience',
  ),
  GiftCard(
    id: '5',
    platform: 'Google Play',
    name: 'Google Play Gift Card',
    price: 20.00,
    imageUrl: 'https://example.com/googleplay.png',
    description: 'Use for apps, games, movies, and more',
  ),
  GiftCard(
    id: '6',
    platform: 'iTunes',
    name: 'iTunes Gift Card',
    price: 25.00,
    imageUrl: 'https://example.com/itunes.png',
    description: 'Use for apps, music, movies, and more on Apple devices',
  ),
];
