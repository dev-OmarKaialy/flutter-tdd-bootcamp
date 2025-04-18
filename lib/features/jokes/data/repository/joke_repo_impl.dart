import 'package:dartz/dartz.dart';
import 'package:jokes_app/core/errors/failure.dart';
import 'package:jokes_app/core/netowrk_info/network_info.dart';
import 'package:jokes_app/features/jokes/data/datasource/local_joke_datasource.dart';
import 'package:jokes_app/features/jokes/data/datasource/remote_joke_datasource.dart';
import 'package:jokes_app/features/jokes/data/models/joke_model.dart';
import 'package:jokes_app/features/jokes/domain/entities/joke_entity.dart';
import 'package:jokes_app/features/jokes/domain/repository/joke_repository.dart';

class JokeRepoImpl implements JokeRepository {
  final NetworkInfo info;
  final LocalJokeDatasource localJokeDatasource;
  final RemoteJokeDatasource remoteJokeDatasource;

  JokeRepoImpl(
      {required this.info,
      required this.localJokeDatasource,
      required this.remoteJokeDatasource});
  @override
  Future<Either<Failure, JokeEntity>> getRandomJoke() async {
    if (await info.isConnected) {
      final result = await remoteJokeDatasource.getRandomJoke();
      await localJokeDatasource
          .storeJoke(JokeModel(joke: result.joke).toJson().toString());
      return Right(result);
    } else {
      return Right(JokeEntity(joke: 'joke'));
    }
  }
}
