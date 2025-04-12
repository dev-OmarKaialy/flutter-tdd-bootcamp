import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:jokes_app/features/jokes/data/models/joke_model.dart';
import 'package:jokes_app/features/jokes/domain/entities/joke_entity.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final testModel = JokeModel(joke: 'First');

  test('should testModel be a child of Joke Entity', () async {
    //arrange
    //act
    //verify
    expect(testModel, isA<JokeEntity>());
  });
  group('toJson', () {
    test('should return a Map<String,dynamic>', () async {
      //arrange
      final Map<String, dynamic> jokeJson = {'joke': 'First'};
      //act
      final result = testModel.toJson();
      //verify
      expect(result, jokeJson);
    });
  });
  group('fromJson', () {
    test('fromJson', () async {
      //arrange
      final tModel = JokeModel(
          joke:
              "As President Roosevelt said: 'We have nothing to fear but fear itself. And Chuck Norris.'");
      final json = fixtureReader('joke.json');
      final map = jsonDecode(json);
      //act
      final result = JokeModel.fromJson(map);
      //verify
      expect(result, isA<JokeModel>());
      expect(result, tModel);
    });
  });
}
