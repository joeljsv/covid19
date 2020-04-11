import 'package:flutter/material.dart';
import 'package:flutter_speedometer/flutter_speedometer.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final Function resetHandler;

  Result(this.resultScore, this.resetHandler);

  String get resultPhrase {
    String resultText;
    if (resultScore <= 20) {
      resultText = 'Testing is not recommended for you at the current time';
    } else if (resultScore <= 60) {
      resultText =
          'Testing is not recommended for you atthe current time.Ring 1056 or Contact to the Helath department if yoursymptoms are extreme.';
    } else if (resultScore > 60) {
      resultText = 'You will need to be tested for COVID-19.';
    } else {
      resultText = 'You are so bad!';
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                child: Image.asset(
              'asset/doc.png',
              fit: BoxFit.contain,
            )),
            Container(
              padding: EdgeInsets.all(10),
              child: Speedometer(
                meterColor: Colors.indigo,
                backgroundColor: Colors.transparent,
                size: 100,
                minValue: 0,
                maxValue: 120,
                warningColor: Colors.red,
                currentValue: resultScore,
                warningValue: 150,
              ),
            ),
            Text(
              resultPhrase,
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            FlatButton(
              child: Text(
                'Test Again !',
              ),
              textColor: Colors.blue,
              onPressed: resetHandler,
            ),
          ],
        ),
      ),
    );
  }
}
