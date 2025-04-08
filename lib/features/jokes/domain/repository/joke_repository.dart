import 'package:dartz/dartz.dart';
import 'package:jokes_app/features/jokes/domain/entities/joke_entity.dart';

import '../../../../core/errors/failure.dart';

abstract class JokeRepository {
  Future<Either<Failure, JokeEntity>> getRandomJoke();
}
