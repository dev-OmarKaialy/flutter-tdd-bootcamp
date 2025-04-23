// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'jokes_bloc.dart';

enum Status { loading, init, success, failed }

class JokesState {
  final Status status;
  final JokeEntity? joke;

  JokesState({this.status = Status.init, this.joke});

  JokesState copyWith({
    Status? status,
    JokeEntity? joke,
  }) {
    return JokesState(
      status: status ?? this.status,
      joke: joke ?? this.joke,
    );
  }
}
