import 'package:tdd_tutorial/core/utilities/typedef.dart';

abstract class UsecaseWithParameters<T, P> {
  const UsecaseWithParameters();

  ResultFuture<T> call(P params);
}

abstract class UsecaseWithoutParameters<T> {
  const UsecaseWithoutParameters();

  ResultFuture<T> call();
}
