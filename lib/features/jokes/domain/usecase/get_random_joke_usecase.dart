import 'package:dartz/dartz.dart';
import 'package:jokes_app/core/errors/failure.dart';
import 'package:jokes_app/features/jokes/domain/entities/joke_entity.dart';
import 'package:jokes_app/features/jokes/domain/repository/joke_repository.dart';

class GetRandomJokeUsecase {
  final JokeRepository jokeRepository;

  GetRandomJokeUsecase({required this.jokeRepository});
  Future<Either<Failure, JokeEntity>> call() async {
    return await jokeRepository.getRandomJoke();
  }
}
