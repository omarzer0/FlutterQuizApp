import 'package:flutter_quiz_app/pojo/question.dart';

class QuizBrain {
  int _questionNumber = 0;
  List<Question> _questionsList = [
    Question("1 + 1 = ?", "1", "2", "3", "4", 4),
    Question("What language is used to make this app?", "flutter", "dart",
        "java", "swift", 4),
    Question("What is the smallest country in the world", "Vatican City",
        "Ben Nevis", "Damietta", "Santiago", 4),
    Question(
        "If tell you that the correct answer is 4 will you believe me? hum... let's see",
        "1",
        "2",
        "3",
        "4",
        4)
  ];

  void nextQuestion() {
    if (_questionNumber < _questionsList.length - 1) _questionNumber++;
  }

  String getQuestionText() {
    return _questionsList[_questionNumber].questionText;
  }

  String getQuestionAnswer1() {
    return _questionsList[_questionNumber].q1;
  }

  String getQuestionAnswer2() {
    return _questionsList[_questionNumber].q2;
  }

  String getQuestionAnswer3() {
    return _questionsList[_questionNumber].q3;
  }

  String getQuestionAnswer4() {
    return _questionsList[_questionNumber].q4;
  }

  bool checkForCorrectAnswer(String userAnswer) {
    bool isCorrect = false;
    if (userAnswer == _questionsList[_questionNumber].correctAnswer)
      isCorrect = true;
    return isCorrect;
  }

  String getCorrectAnswer() => _questionsList[_questionNumber].correctAnswer;

  bool isFinished() {
    bool finished = false;
    if (_questionNumber >= _questionsList.length - 1) finished = true;
    return finished;
  }

  void rest() => _questionNumber = 0;

  int getLen() => _questionsList.length;
}
