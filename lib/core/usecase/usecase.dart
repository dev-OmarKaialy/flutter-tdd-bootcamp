import 'package:dartz/dartz.dart';
import 'package:jokes_app/core/errors/failure.dart';

abstract class Usecase<T, P> {
  Future<Either<Failure, T>> call(P params);
}

class NoParams {}
