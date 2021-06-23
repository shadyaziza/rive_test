import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nara_task/views/home_view.dart';

void main() {
  runApp(ProviderScope(child: NaraTask()));
}

class NaraTask extends StatelessWidget {
  const NaraTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.teal),
      home: HomeView(),
    );
  }
}
