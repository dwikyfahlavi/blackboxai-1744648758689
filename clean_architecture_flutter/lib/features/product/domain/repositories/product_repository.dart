import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, void>> addProduct(Product product);
  Future<Either<Failure, List<Product>>> getProducts();
}
