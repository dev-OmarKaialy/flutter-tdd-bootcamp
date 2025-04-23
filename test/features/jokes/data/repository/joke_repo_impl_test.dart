import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jokes_app/core/errors/exception.dart';
import 'package:jokes_app/core/errors/failure.dart';
import 'package:jokes_app/core/netowrk_info/network_info.dart';
import 'package:jokes_app/features/jokes/data/datasource/local_joke_datasource.dart';
import 'package:jokes_app/features/jokes/data/datasource/remote_joke_datasource.dart';
import 'package:jokes_app/features/jokes/data/models/joke_model.dart';
import 'package:jokes_app/features/jokes/data/repository/joke_repo_impl.dart';
import 'package:jokes_app/features/jokes/domain/entities/joke_entity.dart';
import 'package:mocktail/mocktail.dart';

class MockRemoteDataSource extends Mock implements RemoteJokeDatasource {}

class MockLocalDataSource extends Mock implements LocalJokeDatasource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late JokeRepoImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = JokeRepoImpl(
      remoteJokeDatasource: mockRemoteDataSource,
      localJokeDatasource: mockLocalDataSource,
      info: mockNetworkInfo,
    );
  });
  group('getRandomJoke', () {
    final tJoke = 'Test Text';
    final tJokeModel = JokeModel(joke: 'Test Text');
    final JokeEntity tJokeEntity = tJokeModel;

    test('should check if device is connected', () async {
      //arange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getRandomJoke)
          .thenAnswer((_) async => tJokeModel); //act
      when(() => mockLocalDataSource.storeJoke(tJoke))
          .thenAnswer((_) async => Future.value());
      await repository.getRandomJoke();
      //assert
      verify(() => mockNetworkInfo.isConnected);
    });

    group('device is online', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      test(
          'should return remote data when the call of remote datasource is success',
          () async {
        //arange
        when(mockRemoteDataSource.getRandomJoke)
            .thenAnswer((_) async => tJokeModel);
        when(() => mockLocalDataSource.storeJoke(tJoke))
            .thenAnswer((_) async => Future.value());
        //act
        final result = await repository.getRandomJoke();
        //assert
        verify(mockRemoteDataSource.getRandomJoke);
        expect(result, equals(Right(tJokeEntity)));
      });
      test(
        'should cache the data locally when the call to remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getRandomJoke)
              .thenAnswer((_) async => tJokeModel);
          when(() => mockLocalDataSource.storeJoke(tJoke))
              .thenAnswer((_) async => Future.value());
          // act
          await repository.getRandomJoke();
          // assert
          verify(mockRemoteDataSource.getRandomJoke);
          verify(() => mockLocalDataSource.storeJoke(tJoke));
        },
      );
      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockRemoteDataSource.getRandomJoke).thenThrow(ServerException());
          // act
          final result = await repository.getRandomJoke();
          // assert
          verify(mockRemoteDataSource.getRandomJoke);
          verifyZeroInteractions(mockLocalDataSource);
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });
    group('device is offline', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test(
        'should return last locally cached data when the cached data is present',
        () async {
          // arrange
          when(mockLocalDataSource.getLocalJoke)
              .thenAnswer((_) async => tJokeModel);
          // act
          final result = await repository.getRandomJoke();
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLocalJoke);
          expect(result, equals(Right(tJokeEntity)));
        },
      );

      test(
        'should return cache failure when the call to local data source is unsuccessful',
        () async {
          // arrange
          when(mockLocalDataSource.getLocalJoke).thenThrow(CacheException());
          // act
          final result = await repository.getRandomJoke();
          // assert
          verify(mockLocalDataSource.getLocalJoke);
          expect(result, equals(Left(LocalFailure())));
        },
      );
    });
  });
}
