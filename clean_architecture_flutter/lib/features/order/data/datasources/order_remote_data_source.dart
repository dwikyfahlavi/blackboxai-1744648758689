import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/order.dart';

abstract class OrderRemoteDataSource {
  Future<void> addOrder(Order order);
  Future<List<Order>> getOrders();
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final FirebaseFirestore _firestore;

  OrderRemoteDataSourceImpl(this._firestore);

  @override
  Future<void> addOrder(Order order) async {
    await _firestore.collection('orders').doc(order.id).set({
      'productId': order.productId,
      'quantity': order.quantity,
      'totalPrice': order.totalPrice,
      'salesClerkId': order.salesClerkId,
    });
  }

  @override
  Future<List<Order>> getOrders() async {
    final snapshot = await _firestore.collection('orders').get();
    return snapshot.docs.map((doc) => Order.fromFirestore(doc.data())).toList();
  }
}
