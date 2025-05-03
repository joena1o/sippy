class BeverageItem {
  final String itemId;
  final String name; // Brand name
  final String imageUrl;
  final double price; // Use double for currency
  final String description;

  const BeverageItem({
    required this.itemId,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.description,
  });
}
