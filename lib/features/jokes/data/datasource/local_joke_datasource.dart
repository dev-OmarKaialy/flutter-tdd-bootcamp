import 'package:jokes_app/features/jokes/domain/entities/joke_entity.dart';

abstract class LocalJokeDatasource {
  Future<void> storeJoke(String joke);
  Future<JokeEntity> getLocalJoke();
}
