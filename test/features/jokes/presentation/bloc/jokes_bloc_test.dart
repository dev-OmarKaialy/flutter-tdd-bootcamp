import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jokes_app/core/errors/failure.dart';
import 'package:jokes_app/core/usecase/usecase.dart';
import 'package:jokes_app/features/jokes/data/models/joke_model.dart';
import 'package:jokes_app/features/jokes/domain/usecase/get_random_joke_usecase.dart';
import 'package:jokes_app/features/jokes/presentation/bloc/jokes_bloc.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockGetRandomJokeUsecase extends Mock implements GetRandomJokeUsecase {}

void main() {
  late MockGetRandomJokeUsecase mockGetRandomJokeUsecase;
  late JokesBloc jokesBloc;
  setUp(() {
    mockGetRandomJokeUsecase = MockGetRandomJokeUsecase();
    jokesBloc = JokesBloc(mockGetRandomJokeUsecase);
  });
  setUpAll(() {
    registerFallbackValue(NoParams());
  });

  test('initialState', () {
    //verify
    expect(jokesBloc.state.status, Status.init);
  });

  group('GetRandomJokeEvent', () {
    final tJokeModel =
        JokeModel.fromJson(jsonDecode(fixtureReader('joke.json')));

    test('should get data from GetRandomJokeUsecase', () async {
      //arrange
      when(() => mockGetRandomJokeUsecase.call(any()))
          .thenAnswer((_) async => Right(tJokeModel));
      //act
      jokesBloc.add(GetRandomJokeEvent());
      await untilCalled(() => mockGetRandomJokeUsecase.call(any()));
      //verify
      verify(() => mockGetRandomJokeUsecase.call(any()));
    });
    test('should emit [loading, success] when data is loaded', () async {
      // arrange
      when(() => mockGetRandomJokeUsecase.call(any()))
          .thenAnswer((_) async => Right(tJokeModel));

      // assert later
      final expectedStates = [
        predicate<JokesState>((state) => state.status == Status.loading),
        predicate<JokesState>(
            (state) => state.status == Status.success && state.joke != null),
      ];

      expectLater(jokesBloc.stream, emitsInOrder(expectedStates));

      // actِ
      jokesBloc.add(GetRandomJokeEvent());
    });

    test('should emit [loading, failed] when failed', () async {
      // arrange
      when(() => mockGetRandomJokeUsecase.call(any()))
          .thenAnswer((_) async => Left(LocalFailure()));

      // assert later
      final expectedStates = [
        predicate<JokesState>((state) => state.status == Status.loading),
        predicate<JokesState>((state) => state.status == Status.failed),
      ];

      expectLater(jokesBloc.stream, emitsInOrder(expectedStates));

      // act
      jokesBloc.add(GetRandomJokeEvent());
    });
    test('should emit [loading, failed] when failed cache', () async {
      // arrange
      when(() => mockGetRandomJokeUsecase.call(any()))
          .thenAnswer((_) async => Left(ServerFailure()));

      // assert later
      final expectedStates = [
        predicate<JokesState>((state) => state.status == Status.loading),
        predicate<JokesState>((state) => state.status == Status.failed),
      ];

      expectLater(jokesBloc.stream, emitsInOrder(expectedStates));

      // act
      jokesBloc.add(GetRandomJokeEvent());
    });
  });
}
