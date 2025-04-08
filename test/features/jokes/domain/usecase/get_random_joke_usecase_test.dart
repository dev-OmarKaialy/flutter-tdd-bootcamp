import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jokes_app/features/jokes/domain/entities/joke_entity.dart';
import 'package:jokes_app/features/jokes/domain/repository/joke_repository.dart';
import 'package:jokes_app/features/jokes/domain/usecase/get_random_joke_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockJokeRepository extends Mock implements JokeRepository {}

void main() {
  late final GetRandomJokeUsecase getRandomJokeUsecase;
  late final MockJokeRepository repo;
  setUp(() {
    repo = MockJokeRepository();
    getRandomJokeUsecase = GetRandomJokeUsecase(jokeRepository: repo);
  });
  group('test get random joke usecase', () {
    var jokeEntity = JokeEntity(joke: 'first');
    test('should return a random joke entity', () async {
      //arrange
      when(repo.getRandomJoke).thenAnswer((_) async {
        return Right(jokeEntity);
      });
      //act
      final result = await getRandomJokeUsecase();
      //verify
      expect(result, Right(jokeEntity));
      verify(repo.getRandomJoke).called(1);
      verifyNoMoreInteractions(repo);
    });
  });
}
