import 'dart:async';
import 'dart:math';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quiz_app/quiz_brain.dart';
import 'package:flutter_quiz_app/widgets/custom_Button.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/background7.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: MainPage(),
          ),
        ),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  QuizBrain quizBrain = QuizBrain();
  int score = 0;
  bool isFirstTime = true;
  int _counter = 10;
  Timer _timer;
  var player = AssetsAudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  quizBrain.getQuestionText(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 35, color: Colors.white),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Text('Time Left: $_counter',
                    style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
            ),
          ),
          Row(
            children: [
              CustomButton(quizBrain.getQuestionAnswer1(), (String x) {
                checkAnswer(x);
              }),
              CustomButton(quizBrain.getQuestionAnswer2(), (String x) {
                checkAnswer(x);
              })
            ],
          ),
          Row(
            children: [
              CustomButton(quizBrain.getQuestionAnswer4(), (String x) {
                checkAnswer(x);
              }),
              CustomButton(quizBrain.getQuestionAnswer4(), (String x) {
                checkAnswer(x);
              })
            ],
          )
        ]);
  }

  void checkAnswer(String userAnswer) {
    print("called");
    setState(() {
      if (quizBrain.isFinished()) {
        if (quizBrain.checkForCorrectAnswer(userAnswer)) score++;

        showAlertWithButtonsAndReset();
        print(score);
        quizBrain.rest();
        _timer.cancel();
        score = 0;
        _counter = 10;
      } else {
        if (quizBrain.checkForCorrectAnswer(userAnswer)) {
          score++;
          print("add");
          print(score);
        }
        quizBrain.nextQuestion();
        _startTimer();
      }
    });
  }

  void _startTimer() {
    setState(() {
      _counter = 10;
    });
    if (_timer != null) _timer.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter == 0) {
          _timer.cancel();
          if (!quizBrain.isFinished()) {
            quizBrain.nextQuestion();
            _startTimer();
          } else {
            showAlertWithButtonsAndReset();
          }
        } else
          _counter--;
      });
    });
  }

  void showScoreDialogAndReset() {
    Alert(
            context: context,
            title: "Done! $score / ${quizBrain.getLen()}",
            desc: "You've reached the end of the quiz.")
        .show();

    print(score);
    quizBrain.rest();
    score = 0;
    _timer.cancel();
    _counter = 10;
  }

  void showAlertWithButtonsAndReset() {
    Alert(
      context: context,
      title: "Great! Your score is: $score / ${quizBrain.getLen()}",
      desc: "Do you want to try one more?",
      buttons: [
        DialogButton(
          child: Text(
            "One more",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
            _startTimer();
          },
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
        DialogButton(
          child: Text(
            "No thx",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            SystemNavigator.pop();
          },
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
      ],
    ).show();

    playSound(score);

    print(score);
    quizBrain.rest();
    score = 0;
    _timer.cancel();
    _counter = 10;
  }

  void playSound(int score) {
    switch (score) {
      case 0:
        player.open(Audio('assets/next_time.mp3'), autoStart: true);
        break;
      case 1:
        player.open(Audio('assets/use_ur_head.mp3'), autoStart: true);
        break;
      case 2:
        player.open(Audio('assets/not_bad_kid.mp3'), autoStart: true);
        break;
      case 3:
        player.open(Audio('assets/yaho.mp3'), autoStart: true);
        break;
      case 4:
        player.open(Audio('assets/nice_work.mp3'), autoStart: true);
        break;
    }
  }
}
