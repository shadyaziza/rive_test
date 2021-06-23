import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nara_task/services/questions.dart';
import 'package:nara_task/state/state.dart';
import 'package:nara_task/widgets/emoji.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final Questions q;
  late final bool isCorrect = false;
  int index = 0;
  double opacity = 0;

  @override
  void initState() {
    q = Questions()..generator();
    Timer timer = Timer(
      Duration(seconds: 5),
      () => setState(() {
        opacity = 1.0;
      }),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, watch, ___) {
      final state = watch(stateProvider)..state.setQuestion(q.questions[index]);
      return Stack(
        alignment: Alignment(0, -0.65),
        children: [
          Scaffold(
            appBar: PreferredSize(
              preferredSize: Size(double.infinity, 120),
              child: AppBar(
                elevation: 0.0,
                centerTitle: true,
                title: Text('Question No.${index + 1}'),
              ),
            ),
            body: AnimatedOpacity(
              opacity: opacity,
              duration: Duration(seconds: 3),
              child: PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: state.state.pageController,
                onPageChanged: (int newPage) {
                  context
                      .read(stateProvider)
                      .state
                      .setQuestion(q.questions[newPage]);
                  setState(() {
                    index = newPage;
                  });
                },
                children: [
                  for (final q in q.questions) ...{
                    _QuestionPage(
                      q: q,
                      index: index,
                    )
                  }
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(200),
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: Emoji(),
          ),
        ],
      );
    });
  }
}

class _QuestionPage extends ConsumerWidget {
  const _QuestionPage({Key? key, required this.q, required this.index})
      : super(key: key);
  final Question q;
  final int index;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          q.statement,
          textScaleFactor: 1.4,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: TextField(
            onSubmitted: (text) {
              context.read(stateProvider).state.checkAnswer(text);
              context.read(stateProvider).state.pageController.animateToPage(
                  index + 1,
                  duration: Duration(seconds: 3),
                  curve: Curves.easeIn);
            },
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            onTap: () => context.read(stateProvider).state.resetAnimation(),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Write your answer',
            ),
          ),
        )
      ],
    );
  }
}
