import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:jokes_app/core/errors/exception.dart';
import 'package:jokes_app/features/jokes/data/datasource/remote_joke_datasource.dart';
import 'package:jokes_app/features/jokes/data/models/joke_model.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockClient extends Mock implements Client {}

void main() {
  late RemoteJokeDatasourceImplementation datasrouce;
  late MockClient client;
  setUp(() {
    registerFallbackValue(
        Uri.parse('https://geek-jokes.sameerkumar.website/api?format=json'));
    client = MockClient();
    datasrouce = RemoteJokeDatasourceImplementation(client: client);
  });
  group('getRandomJoke', () {
    final tJokeModel =
        JokeModel.fromJson(jsonDecode(fixtureReader('joke.json')));

    test('should return JokeModel from Datasource', () async {
      //arrange
      when(() => client.get(any()))
          .thenAnswer((_) async => Response(fixtureReader('joke.json'), 200));
      //act
      final result = await datasrouce.getRandomJoke();
      //verify
      expect(result, tJokeModel);
    });

    test('should throw server exception if status code != 200', () async {
      //arrange
      when(() => client.get(any())).thenAnswer((_) async => Response('', 404));
      //act
      final call = datasrouce.getRandomJoke;
      //verify
      expect(() => call(), throwsA(TypeMatcher<ServerException>()));
    });
  });
}
