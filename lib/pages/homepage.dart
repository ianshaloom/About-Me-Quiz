import 'package:flutter/material.dart';
import 'package:quizme/database/data_structure.dart';
import 'package:video_player/video_player.dart';

import 'quiz.dart';
import 'result.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late VideoPlayerController _controller;

  DataStructure a = DataStructure();
  final List _questions = DataStructure().questions;

  var _questionIndex = 0;
  var _totalScore = 0;

  void _answerQuest(int score) {
    _totalScore += score;
    setState(() {
      _questionIndex += 1;
      if (_questionIndex == _questions.length) {
        playVideo(resultAsset);
        print(_questionIndex);
      }
    });
    print(_totalScore);
  }

  double getGrade(int score) {
    double grade;
    int total = _questions.length * 10;
    grade = score / total * 100;
    return grade;
  }

  void resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
      _controller.dispose();
    });
  }

  void playVideo(String asset) {
    setState(() {
      _controller = VideoPlayerController.asset(asset)
        ..addListener(() => setState(() {}))
        ..setLooping(true)
        ..initialize().then((_) {
          _controller.play();
        });
    });
  }

  String get resultAsset {
    String resultText = '';
    if (getGrade(_totalScore) >= 80.0) {
      resultText = 'assets/videos/excellent2.mp4';
    } else if (getGrade(_totalScore) >= 60.0) {
      resultText = 'assets/videos/average1.mp4';
    } else if (getGrade(_totalScore) >= 40.0) {
      resultText = 'assets/videos/average2.mp4';
    } else if (getGrade(_totalScore) >= 20.0) {
      resultText = 'assets/videos/worst3.mp4';
    } else if (getGrade(_totalScore) <= 20.0) {
      resultText = 'assets/videos/worst4.mp4';
    }

    return resultText;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: const Text(
          'Quiz Me Up',
          style: TextStyle(
            fontSize: 28,
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      body: _questionIndex < _questions.length
          ? QuizPage(
              questions: _questions,
              questionIndex: _questionIndex,
              onPressed: _answerQuest,
            )
          : ResultPage(
              quizResults: _totalScore,
              onPressed: resetQuiz,
              controller: _controller,
            ),
    );
  }
}
