import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../entities/order.dart';

abstract class OrderRepository {
  Future<Either<Failure, void>> addOrder(Order order);
  Future<Either<Failure, List<Order>>> getOrders();
}
