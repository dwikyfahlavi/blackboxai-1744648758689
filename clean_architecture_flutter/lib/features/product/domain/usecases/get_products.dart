import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetProducts {
  final ProductRepository repository;

  GetProducts(this.repository);

  Future<Either<Failure, List<Product>>> call() {
    return repository.getProducts();
  }
}
