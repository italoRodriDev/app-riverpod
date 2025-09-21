class JokeModel {
  String? type;
  String? setup;
  String? punchline;
  int? id;

  JokeModel({this.type, this.setup, this.punchline, this.id});

  factory JokeModel.fromJson(Map<String, Object?> json) {
    return JokeModel(
        type: json['type']! as String,
        setup: json['setup']! as String,
        punchline: json['punchline']! as String,
        id: json['id']! as int);
  }
}
