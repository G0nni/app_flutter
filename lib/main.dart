import 'package:flutter/material.dart';

import 'pages/quizpage.dart';
import 'pages/after.dart';
import 'data/data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test de connaissance',
      home: const Accueil(),
      initialRoute: '/',
      routes: {
        '/quizpage': (context) =>
            const QuestionWidget(questiondata: questionData),
        '/after': (context) => const AfterWidget(),
      },
    );
  }
}

class Accueil extends StatelessWidget {
  const Accueil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          child: Padding(
            padding: .all(4.0),
            child: Column(
              children: <Widget>[
                Spacer(),
                Text('Bienvenue sur le test de connaissance de Nico'),
                Spacer(),
                FilledButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/quizpage');
                  },
                  child: const Text('Commencer'),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
