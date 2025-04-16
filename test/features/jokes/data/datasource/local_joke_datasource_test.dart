import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:jokes_app/core/errors/exception.dart';
import 'package:jokes_app/features/jokes/data/datasource/local_joke_datasource.dart';
import 'package:jokes_app/features/jokes/data/models/joke_model.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late LocalDatasourceImplementation localDatasourceImplementation;
  late MockSharedPreferences sharedPreferences;
  final tJokeModel =
      JokeModel.fromJson(jsonDecode(fixtureReader('joke_cached.json')));

  setUp(() {
    sharedPreferences = MockSharedPreferences();
    localDatasourceImplementation =
        LocalDatasourceImplementation(sharedPreferences: sharedPreferences);
  });
  group('getLocalStored', () {
    test('should return JokeModel from Cache', () async {
      //arrange
      when(() => sharedPreferences.getString('joke'))
          .thenReturn(fixtureReader('joke_cached.json'));
      //act
      final result = await localDatasourceImplementation.getLocalJoke();
      //verify
      expect(result, tJokeModel);
      verify(() => sharedPreferences.getString('joke')).called(1);
    });
    test('should throw CacheException', () async {
//arrange
      when(() => sharedPreferences.getString(any())).thenReturn(null);
//act
      final act = localDatasourceImplementation.getLocalJoke;
//verify
      expect(() => act(), throwsA(TypeMatcher<CacheException>()));
    });
  });
  group('Store new Value', () {
    test('should store joke to local storage', () async {
      //arrange
      when(() => sharedPreferences.setString(any(), any()))
          .thenAnswer((_) async => true);
      //act
      await localDatasourceImplementation
          .storeJoke(tJokeModel.toJson().toString());
      //verify
      verify(() =>
          sharedPreferences.setString('joke', tJokeModel.toJson().toString()));
    });
  });
}
