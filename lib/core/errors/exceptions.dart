import 'package:equatable/equatable.dart';

class ApiException extends Equatable {
  final String msg;
  final int statusCode;

  const ApiException({required this.msg, required this.statusCode});

  @override
  List<Object?> get props => [msg, statusCode];
}
