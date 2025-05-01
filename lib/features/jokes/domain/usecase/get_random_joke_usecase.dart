import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:jokes_app/core/errors/failure.dart';
import 'package:jokes_app/core/usecase/usecase.dart';
import 'package:jokes_app/features/jokes/domain/entities/joke_entity.dart';
import 'package:jokes_app/features/jokes/domain/repository/joke_repository.dart';

@injectable
class GetRandomJokeUsecase implements Usecase<JokeEntity, NoParams> {
  final JokeRepository jokeRepository;

  GetRandomJokeUsecase({required this.jokeRepository});

  @override
  Future<Either<Failure, JokeEntity>> call(NoParams params) async {
    return await jokeRepository.getRandomJoke();
  }
}
