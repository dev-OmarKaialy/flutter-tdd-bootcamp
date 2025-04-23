part of 'jokes_bloc.dart';

abstract class JokesEvent extends Equatable {}

class GetRandomJokeEvent extends JokesEvent {
  @override
  List<Object?> get props => [];
}
