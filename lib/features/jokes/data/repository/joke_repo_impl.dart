import 'package:dartz/dartz.dart';
import 'package:jokes_app/core/errors/exception.dart';
import 'package:jokes_app/core/errors/failure.dart';
import 'package:jokes_app/core/netowrk_info/network_info.dart';
import 'package:jokes_app/features/jokes/data/datasource/local_joke_datasource.dart';
import 'package:jokes_app/features/jokes/data/datasource/remote_joke_datasource.dart';
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
      try {
        final result = await remoteJokeDatasource.getRandomJoke();
        await localJokeDatasource.storeJoke(result.joke);
        return Right(result);
      } on ServerException catch (e) {
        return Left(ServerFailure());
      }
    } else {
      try {
        final result = await localJokeDatasource.getLocalJoke();
        return Right(result);
      } catch (e) {
        return Left(LocalFailure());
      }
    }
  }
}
