class Order {
  final String id;
  final String productId;
  final int quantity;
  final double totalPrice;
  final String salesClerkId;

  const Order({
    required this.id,
    required this.productId,
    required this.quantity,
    required this.totalPrice,
    required this.salesClerkId,
  });

  factory Order.fromFirestore(Map<String, dynamic> data) {
    return Order(
      id: data['id'] ?? '',
      productId: data['productId'] ?? '',
      quantity: data['quantity'] ?? 0,
      totalPrice: data['totalPrice']?.toDouble() ?? 0.0,
      salesClerkId: data['salesClerkId'] ?? '',
    );
  }
}
