import 'package:nara_task/extensions/random_num.dart';

class Questions {
  final List<Question> questions = [];
  Questions();
  void generator() {
    for (int i = 3; i > 0; i--) {
      int r1 = RandomInt.generate(max: 9);
      int r2 = RandomInt.generate(max: 9);
      questions.add(
        Question.fromGenerator(
          '$r1 X $r2',
          _multiply(r1, r2),
        ),
      );
    }
  }

  int _multiply(int r1, int r2) {
    return (r1 * r2);
  }
}

class Question {
  final String _statement;
  final String _correctAnswer;
  Question._(this._statement, this._correctAnswer);
  String get statement => _statement;
  String get answer => _correctAnswer;
  // bool checkAnswer(String answer) => answer.trim() == _correctAnswer;
  factory Question.fromGenerator(String statement, int answer) {
    return Question._(
      statement,
      answer.toString(),
    );
  }
}
