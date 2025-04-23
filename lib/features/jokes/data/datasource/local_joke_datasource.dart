import 'dart:convert';

import 'package:jokes_app/core/errors/exception.dart';
import 'package:jokes_app/features/jokes/data/models/joke_model.dart';
import 'package:jokes_app/features/jokes/domain/entities/joke_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalJokeDatasource {
  Future<void> storeJoke(String joke);
  Future<JokeEntity> getLocalJoke();
}

class LocalDatasourceImplementation implements LocalJokeDatasource {
  final SharedPreferences sharedPreferences;

  LocalDatasourceImplementation({required this.sharedPreferences});
  @override
  Future<JokeEntity> getLocalJoke() async {
    final json = sharedPreferences.getString('joke');
    if (json != null) {
      return JokeModel.fromJson(jsonDecode(json));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> storeJoke(String joke) async {
    await sharedPreferences.setString('joke', joke);
  }
}
