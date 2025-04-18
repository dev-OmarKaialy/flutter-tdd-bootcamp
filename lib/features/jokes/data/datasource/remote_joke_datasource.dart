import 'dart:convert';

import 'package:http/http.dart';
import 'package:jokes_app/features/jokes/data/models/joke_model.dart';
import 'package:jokes_app/features/jokes/domain/entities/joke_entity.dart';

import '../../../../core/errors/exception.dart';

abstract class RemoteJokeDatasource {
  Future<JokeEntity> getRandomJoke();
}

class RemoteJokeDatasourceImplementation implements RemoteJokeDatasource {
  final Client client;

  RemoteJokeDatasourceImplementation({required this.client});
  @override
  Future<JokeEntity> getRandomJoke() async {
    final result = await client.get(
        Uri.parse('https://geek-jokes.sameerkumar.website/api?format=json'));

    if (result.statusCode == 200) {
      return JokeModel.fromJson(jsonDecode(result.body));
    }
    throw ServerException();
  }
}
