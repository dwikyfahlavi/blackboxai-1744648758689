import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import '../../domain/usecases/add_order.dart';
import '../../domain/usecases/get_orders.dart';
import '../../domain/entities/order.dart';
import '../../domain/repositories/order_repository.dart';
import '../../core/errors/failures.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final GetOrders getOrders;
  final AddOrder addOrder;

  OrderCubit({
    required this.getOrders,
    required this.addOrder,
  }) : super(OrderInitial()) {
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    emit(OrderLoading());
    final result = await getOrders();
    result.fold(
      (failure) => emit(OrderError(failure.message)),
      (orders) => emit(OrderLoaded(orders)),
    );
  }

  Future<void> addOrder(Order order) async {
    final result = await addOrder(order);
    result.fold(
      (failure) => emit(OrderError(failure.message)),
      (_) => fetchOrders(),
    );
  }
}
