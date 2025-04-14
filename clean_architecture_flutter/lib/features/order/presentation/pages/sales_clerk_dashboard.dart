import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/order_cubit.dart';
import '../../domain/entities/order.dart';

class SalesClerkDashboard extends StatelessWidget {
  final TextEditingController productIdController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sales Clerk Dashboard')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Input Order', style: TextStyle(fontSize: 20)),
          ),
          _buildInputOrderForm(context),
          _buildOrderList(context),
        ],
      ),
    );
  }

  Widget _buildInputOrderForm(BuildContext context) {
    return Column(
      children: [
        TextField(controller: productIdController, decoration: InputDecoration(labelText: 'Product ID')),
        TextField(controller: quantityController, decoration: InputDecoration(labelText: 'Quantity')),
        ElevatedButton(
          onPressed: () {
            final order = Order(
              id: DateTime.now().toString(),
              productId: productIdController.text,
              quantity: int.tryParse(quantityController.text) ?? 0,
              totalPrice: 0.0, // Calculate total price based on product price
              salesClerkId: 'salesClerkId', // Replace with actual sales clerk ID
            );
            context.read<OrderCubit>().addOrder(order);
          },
          child: Text('Add Order'),
        ),
      ],
    );
  }

  Widget _buildOrderList(BuildContext context) {
    return Expanded(
      child: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          if (state is OrderLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is OrderLoaded) {
            final orders = state.orders;
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return ListTile(
                  title: Text('Order ID: ${order.id}'),
                  subtitle: Text('Product ID: ${order.productId}, Quantity: ${order.quantity}'),
                );
              },
            );
          } else {
            return Center(child: Text('No orders available.'));
          }
        },
      ),
    );
  }
}
