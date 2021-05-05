class Question {
  String _questionText;
  String _q1;
  String _q2;
  String _q3;
  String _q4;
  int correctAnswerNumber;

  Question(this._questionText, this._q1, this._q2, this._q3, this._q4,
      this.correctAnswerNumber);

  String get q4 => _q4;

  String get q3 => _q3;

  String get q2 => _q2;

  String get q1 => _q1;

  String get correctAnswer{
    switch (correctAnswerNumber) {
      case 1: return q1; break;
      case 2: return q2; break;
      case 3: return q3; break;
      case 4: return q4; break;
      default: throw new Exception("wrong number!");
    }
  }

  String get questionText => _questionText;
}