import 'package:jokes_app/features/jokes/domain/entities/joke_entity.dart';

abstract class RemoteJokeDatasource {
  Future<JokeEntity> getRandomJoke();
}

class TestJoke implements RemoteJokeDatasource {
  @override
  Future<JokeEntity> getRandomJoke() {
    // TODO: implement getRandomJoke
    throw UnimplementedError();
  }
}
