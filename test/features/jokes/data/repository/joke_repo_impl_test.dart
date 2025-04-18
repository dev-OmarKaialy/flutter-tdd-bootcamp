import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jokes_app/core/netowrk_info/network_info.dart';
import 'package:jokes_app/features/jokes/data/datasource/local_joke_datasource.dart';
import 'package:jokes_app/features/jokes/data/datasource/remote_joke_datasource.dart';
import 'package:jokes_app/features/jokes/data/models/joke_model.dart';
import 'package:jokes_app/features/jokes/data/repository/joke_repo_impl.dart';
import 'package:jokes_app/features/jokes/domain/entities/joke_entity.dart';
import 'package:mocktail/mocktail.dart';

class MockRemoteDatasource extends Mock implements RemoteJokeDatasource {}

class MockLocalDatasource extends Mock implements LocalJokeDatasource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late JokeRepoImpl jokeRepoImpl;
  late MockLocalDatasource mockLocalDatasource;
  late MockRemoteDatasource mockRemoteDatasource;
  late MockNetworkInfo mockNetworkInfo;
  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockLocalDatasource = MockLocalDatasource();
    mockRemoteDatasource = MockRemoteDatasource();
    jokeRepoImpl = JokeRepoImpl(
        info: mockNetworkInfo,
        localJokeDatasource: mockLocalDatasource,
        remoteJokeDatasource: mockRemoteDatasource);
  });

  group('getRandomJoke', () {
    final tJoke = 'FirstJoke';
    final tJokeModel = JokeModel(joke: tJoke);
    final JokeEntity jokeEntity = tJokeModel;
    test('should check if device is Connected ', () async {
      //arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDatasource.getRandomJoke)
          .thenAnswer((_) async => tJokeModel);
      when(() => mockLocalDatasource.storeJoke(tJoke));

      //act
      final result = await jokeRepoImpl.getRandomJoke();
      //verify
      verify(() => mockNetworkInfo.isConnected);
    });
    group('online', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test('should return Right(JokeEntity) ', () async {
        //arrange
        when(mockRemoteDatasource.getRandomJoke)
            .thenAnswer((_) async => jokeEntity);
        when(() =>
                mockLocalDatasource.storeJoke(tJokeModel.toJson().toString()))
            .thenAnswer((_) async => true);

        //act
        final result = await jokeRepoImpl.getRandomJoke();
        //verify
        verify(mockRemoteDatasource.getRandomJoke);
        expect(result, Right(tJokeModel));
      });
      test('should cache latest joke ', () async {
        //arrange
        when(mockRemoteDatasource.getRandomJoke)
            .thenAnswer((_) async => jokeEntity);
        when(() =>
                mockLocalDatasource.storeJoke(tJokeModel.toJson().toString()))
            .thenAnswer((_) async => true);

        //act
        await jokeRepoImpl.getRandomJoke();
        //verify
        verify(mockRemoteDatasource.getRandomJoke);
        verify(() =>
            mockLocalDatasource.storeJoke(tJokeModel.toJson().toString()));
      });
    });
    group('offline', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
    });
  });
}
