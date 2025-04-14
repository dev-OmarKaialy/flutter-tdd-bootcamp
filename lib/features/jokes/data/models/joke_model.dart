import '../../domain/entities/joke_entity.dart';

class JokeModel extends JokeEntity {
  const JokeModel({required super.joke});

  Map<String, dynamic> toJson() {
    return {'joke': joke};
  }

  factory JokeModel.fromJson(Map<String, dynamic> json) =>
      JokeModel(joke: json['joke']);
  JokeModel copyWith({String? joke}) {
    return JokeModel(joke: joke ?? this.joke);
  }
}
