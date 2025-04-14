abstract class Failure {}

class ServerFailure extends Failure {
  final String message;
  
  const ServerFailure([this.message = '']);
}

class CacheFailure extends Failure {}
