import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import '../../domain/usecases/add_product.dart';
import '../../domain/usecases/get_products.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../../core/errors/failures.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final GetProducts getProducts;
  final AddProduct addProduct;

  ProductCubit({
    required this.getProducts,
    required this.addProduct,
  }) : super(ProductInitial()) {
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    emit(ProductLoading());
    final result = await getProducts();
    result.fold(
      (failure) => emit(ProductError(failure.message)),
      (products) => emit(ProductLoaded(products)),
    );
  }

  Future<void> addProduct(Product product) async {
    final result = await addProduct(product);
    result.fold(
      (failure) => emit(ProductError(failure.message)),
      (_) => fetchProducts(),
    );
  }
}
