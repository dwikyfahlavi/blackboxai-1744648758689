import 'package:fpdart/fpdart.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';
import '../entities/user.dart';

class SignUp implements UseCase<User, SignUpParams> {
  final AuthRepository repository;

  SignUp(this.repository);

  @override
  Future<Either<Failure, User>> call(SignUpParams params) async {
    return await repository.createUserWithEmailAndPassword(
      params.email,
      params.password,
    );
  }
}

class SignUpParams {
  final String email;
  final String password;

  SignUpParams({required this.email, required this.password});
}
