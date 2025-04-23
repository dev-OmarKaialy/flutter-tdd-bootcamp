// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jokes_app/core/usecase/usecase.dart';
import 'package:jokes_app/features/jokes/domain/entities/joke_entity.dart';

import '../../domain/usecase/get_random_joke_usecase.dart';

part 'jokes_event.dart';
part 'jokes_state.dart';

class JokesBloc extends Bloc<JokesEvent, JokesState> {
  final GetRandomJokeUsecase getRandomJokeUsecase;
  JokesBloc(
    this.getRandomJokeUsecase,
  ) : super(JokesState()) {
    on<GetRandomJokeEvent>((event, emit) async {
      emit(state.copyWith(status: Status.loading));
      final result = await getRandomJokeUsecase(NoParams());
      result.fold((left) {
        emit(state.copyWith(status: Status.failed));
      }, (right) {
        emit(state.copyWith(status: Status.success, joke: right));
      });
    });
  }
}
