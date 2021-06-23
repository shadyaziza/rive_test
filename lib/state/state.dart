import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nara_task/services/questions.dart';
import 'package:rive/rive.dart';

final stateProvider = StateProvider<AppState>(
  (ref) => AppState(),
);

class AppState {
  AppState();
  late Question question;
  bool oldAnswerCorrect = false;
  bool currentAnswerCorrect = false;
  Artboard? artboard;
  RiveAnimationController? controller;
  PageController pageController = PageController();
  void setController(RiveAnimationController ct) => controller = ct;
  void setArtboard(Artboard ab) => artboard = ab;
  void createTransition([String? idle]) {
    artboard!.removeController(controller!);
    artboard!.addController(
      controller = SimpleAnimation(idle ?? animationSelection()),
    );
  }

  void setQuestion(Question q) => question = q;

  bool checkAnswer(String answer) {
    final value = answer.trim() == question.answer;

    currentAnswerCorrect = value;
    oldAnswerCorrect = currentAnswerCorrect;
    createTransition();
    return value;
  }

  void resetAnimation() {
    createTransition(RiveLabels.idle);
  }

  String animationSelection() {
    if (oldAnswerCorrect) {
      if (currentAnswerCorrect) {
        return '${RiveLabels.fromEntry}${RiveLabels.toCorrect}';
      } else {
        return '${RiveLabels.fromCorrect}${RiveLabels.toWrong}';
      }
    } else {
      if (currentAnswerCorrect) {
        return '${RiveLabels.fromWrong}${RiveLabels.toCorrect}';
      } else {
        return '${RiveLabels.fromEntry}${RiveLabels.toWrong}';
      }
    }
  }
}

class RiveLabels {
  static final fromEntry = 'solve>';
  static final fromCorrect = 'correct>';
  static final toCorrect = 'correct';
  static final fromWrong = 'wrong>';
  static final toWrong = 'wrong';
  static final idle = 'idle';
}
