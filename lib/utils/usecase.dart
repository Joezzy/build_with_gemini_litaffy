import 'package:dartz/dartz.dart';
import 'package:littafy/core/errors/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class Params<T> {
  final T data;
  Params(this.data);
}

class NoParams<T> {
  NoParams();
}
