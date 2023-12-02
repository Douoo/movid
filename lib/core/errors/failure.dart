import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String message;

  const Failure({this.message = 'Something went wrong while fetching data'});

  @override
  List<Object?> get props => [
        message,
      ];
}

class ServerFailure extends Failure {
  const ServerFailure({super.message});
}

class ConnectionFailure extends Failure {
  const ConnectionFailure(
      {super.message =
          '''No (Unstable) internet connection available. Please try again when you have a better connection.'''});
}

class CacheFailure extends Failure {}
