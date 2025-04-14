import 'package:dartz/dartz.dart';
import 'package:jokes_app/core/errors/failure.dart';
import 'package:jokes_app/features/jokes/domain/entities/joke_entity.dart';
import 'package:jokes_app/features/jokes/domain/repository/joke_repository.dart';

class JokeRepoImpl implements JokeRepository {
  @override
  Future<Either<Failure, JokeEntity>> getRandomJoke() {
    // TODO: implement getRandomJoke
    throw UnimplementedError();
  }
}
