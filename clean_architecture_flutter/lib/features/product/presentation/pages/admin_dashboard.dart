import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/product_cubit.dart';
import '../../domain/entities/product.dart';

class AdminDashboard extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController stockController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin Dashboard')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Add Product', style: TextStyle(fontSize: 20)),
          ),
          _buildAddProductForm(context),
          _buildProductList(context),
        ],
      ),
    );
  }

  Widget _buildAddProductForm(BuildContext context) {
    return Column(
      children: [
        TextField(controller: nameController, decoration: InputDecoration(labelText: 'Product Name')),
        TextField(controller: descriptionController, decoration: InputDecoration(labelText: 'Description')),
        TextField(controller: priceController, decoration: InputDecoration(labelText: 'Price')),
        TextField(controller: stockController, decoration: InputDecoration(labelText: 'Stock')),
        ElevatedButton(
          onPressed: () {
            final product = Product(
              id: DateTime.now().toString(),
              name: nameController.text,
              description: descriptionController.text,
              price: double.tryParse(priceController.text) ?? 0.0,
              stock: int.tryParse(stockController.text) ?? 0,
            );
            context.read<ProductCubit>().addProduct(product);
          },
          child: Text('Add Product'),
        ),
      ],
    );
  }

  Widget _buildProductList(BuildContext context) {
    return Expanded(
      child: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ProductLoaded) {
            final products = state.products;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text('Price: \$${product.price}, Stock: ${product.stock}'),
                );
              },
            );
          } else {
            return Center(child: Text('No products available.'));
          }
        },
      ),
    );
  }
}
