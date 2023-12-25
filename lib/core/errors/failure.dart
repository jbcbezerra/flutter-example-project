import 'package:equatable/equatable.dart';
import 'package:tdd_tutorial/core/errors/exceptions.dart';

abstract class Failure extends Equatable {
  final String msg;
  final int statusCode;

  const Failure({required this.msg, required this.statusCode});

  @override
  List<Object?> get props => [msg, statusCode];
}

class ApiFailure extends Failure {
  const ApiFailure({required super.msg, required super.statusCode});

  ApiFailure.fromException(ApiException exception)
      : this(msg: exception.msg, statusCode: exception.statusCode);
}
