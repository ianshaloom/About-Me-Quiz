import 'package:flutter/material.dart';
import 'package:quizme/database/data_structure.dart';
import 'package:video_player/video_player.dart';

import '../widgets/videoplayer.dart';

class ResultPage extends StatelessWidget {
  final int quizResults;
  final void Function()? onPressed;
  final VideoPlayerController controller;
  const ResultPage({
    super.key,
    required this.quizResults,
    required this.onPressed,
    required this.controller,
  });

  double getGrade(int score) {
    double grade;
    int total = DataStructure().questions.length * 10;
    grade = score / total * 100;
    return grade;
  }

  String get resultPhrase {
    String resultText = '';
    if (getGrade(quizResults) >= 80.0) {
      resultText =
          "Damn, you know me inside out! Your knowledge about me is truly impressive. It's like you've unlocked all the secrets!";
    } else if (getGrade(quizResults) >= 60.0) {
      resultText =
          "Impressive! You know quite a bit about me. It's clear that you've invested time in getting to know me better.";
    } else if (getGrade(quizResults) >= 40.0) {
      resultText =
          "You have a decent understanding of who I am, but there's more to explore. Keep up the good work and continue learning!";
    } else if (getGrade(quizResults) >= 20.0) {
      resultText =
          "You have some knowledge about me, but there's still room for improvement. Keep digging deeper to learn more!";
    } else if (getGrade(quizResults) < 20.0) {
      resultText =
          "You barely know anything about me. Mahn you really suck! 👎";
    }

    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10, top: 20),
          child: Text(
            'Your Score: ${getGrade(quizResults).round()}',
            style: const TextStyle(
              fontSize: 40,
              color: Colors.black,
              fontWeight: FontWeight.w100,
            ),
          ),
        ),
        VideoPlayerWidget(
          controller: controller,
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            resultPhrase,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 30,
              color: Colors.black,
              fontWeight: FontWeight.w200,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: FloatingActionButton.extended(
            onPressed: onPressed,
            icon: const Icon(Icons.quiz_outlined),
            label: const Text(
              'Try One More Time',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
