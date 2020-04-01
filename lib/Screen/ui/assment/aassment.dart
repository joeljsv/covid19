import 'package:flutter/material.dart';

import './quiz.dart';
import './result.dart';


class AssmentScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AssmentScreenState();
  }
}

class _AssmentScreenState extends State<AssmentScreen> {
  final _questions = const [
    {
      'questionText': 'Do you have a fever or respiratorysymptoms? \neg cough, sore throat,shortness of breath',
      'answers': [
        {'text': 'Yes', 'score': 10},
        {'text': 'No', 'score': 0},
        
      ],
    },
    {
      'questionText': 'Have you had close contact* in the last 14 days with a personwho has tested positive for COVID-19?',
      'answers': [
       {'text': 'Yes', 'score': 20},
        {'text': 'No', 'score': 0},
      ],
    },
    {
      'questionText': 'Have you had any internationaltravel in Last  14 days ?',
      'answers': [
       {'text': 'Yes', 'score': 30},
        {'text': 'No', 'score': 0},
      ],
    },
    {
      'questionText': 'Are you a healthcare worker with both fever (>37.5) and respiratorysymptoms?',
      'answers': [
       {'text': 'Yes', 'score': 40},
        {'text': 'No', 'score': 0},
      ],
    },
  ];
  var _questionIndex = 0;
  var _totalScore = 0;

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  void _answerQuestion(int score) {
    // var aBool = true;
    // aBool = false;

    _totalScore += score;

    setState(() {
      _questionIndex = _questionIndex + 1;
    });
    print(_questionIndex);
    if (_questionIndex < _questions.length) {
      print('We have more questions!');
    } else {
      print('No more questions!');
    }
  }

  @override
  Widget build(BuildContext context) {
    // var dummy = const ['Hello'];
    // dummy.add('Max');
    // print(dummy);
    // dummy = [];
    // questions = []; // does not work if questions is a const

    return  Scaffold(
        appBar: AppBar(
          title: Text('Self Test'),
          centerTitle: true,
          elevation: 00,
          backgroundColor: Colors.indigo,
        ),
        body: _questionIndex < _questions.length
            ? Quiz(
                answerQuestion: _answerQuestion,
                questionIndex: _questionIndex,
                questions: _questions,
              )
            : Result(_totalScore, _resetQuiz),
      
    );
  }
}
