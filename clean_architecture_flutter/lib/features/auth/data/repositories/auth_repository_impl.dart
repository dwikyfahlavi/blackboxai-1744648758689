import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../domain/repositories/auth_repository.dart';
import '../domain/entities/user.dart';
import '../data/datasources/auth_remote_data_source.dart';
import '../data/datasources/session_local_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final SessionLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, User>> signInWithEmailAndPassword(String email, String password) async {
    try {
      final user = await remoteDataSource.signInWithEmailAndPassword(email, password);
      if (user.role == null) {
        return Left(ServerFailure('User role not found'));
      }
      await localDataSource.saveSession(user.id);
      return Right(user);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> createUserWithEmailAndPassword(String email, String password) async {
    try {
      final userCredential = await remoteDataSource.createUserWithEmailAndPassword(email, password);
      final user = User.fromFirebaseUser(userCredential.user!);
      await localDataSource.saveSession(user.id);
      return Right(user);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await remoteDataSource.signOut();
      await localDataSource.clearSession();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User?>> getCurrentUser() async {
    try {
      final userId = await localDataSource.getSession();
      if (userId != null) {
        return Right(User(id: userId));
      }
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
