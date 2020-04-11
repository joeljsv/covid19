import 'package:flutter/material.dart';

final pages = [
  PageViewModel(
      const Color(0xFF548CFF),
      'asset/doc.png',
      'Clean your hands often',
      "Wash Your Hands often with soap and water for at least 20 seconds especially after you have been in a public place, or after blowing your nose, coughing, or sneezing.",
      'asset/doc.png'),
  PageViewModel(
      const Color(0xFFE4534D),
      'asset/doc.png',
      'Avoid close contact',
      "use a hand sanitizer that contains at least 60% alcohol. Cover all surfaces of your hands and rub them together until they feel dry.",
      'asset/doc.png'),
  PageViewModel(
    const Color(0xFFFF682D),
    'asset/doc.png',
    'Stay home',
    "Stay home if you are sick, except to get medical care.",
    'asset/doc.png',
  ),
  PageViewModel(
      const Color(0xFF548CFF),
      'asset/doc.png',
      'Clean and disinfect',
      "Clean AND disinfect frequently touched surfaces daily. This includes tables, doorknobs, light switches, countertops, handles, desks, phones, keyboards, toilets, faucets, and sinks.",
      'asset/doc.png'),
];

class Page extends StatelessWidget {
  final PageViewModel viewModel;
  final double percentVisible;

  Page({
    this.viewModel,
    this.percentVisible = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        color: viewModel.color,
        child: Opacity(
          opacity: percentVisible,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Transform(
              transform: Matrix4.translationValues(
                  0.0, 50.0 * (1.0 - percentVisible), 0.0),
              child: Padding(
                padding: EdgeInsets.only(bottom: 25.0),
                child: Image.asset(viewModel.heroAssetPath,
                    width: 200.0, height: 200.0),
              ),
            ),
            Transform(
              transform: Matrix4.translationValues(
                  0.0, 30.0 * (1.0 - percentVisible), 0.0),
              child: Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Text(
                  viewModel.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'FlamanteRoma',
                    fontSize: 34.0,
                  ),
                ),
              ),
            ),
            Transform(
              transform: Matrix4.translationValues(
                  0.0, 30.0 * (1.0 - percentVisible), 0.0),
              child: Padding(
                padding: EdgeInsets.only(bottom: 75.0),
                child: Text(
                  viewModel.body,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'FlamanteRomaItalic',
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
          ]),
        ));
  }
}

class PageViewModel {
  final Color color;
  final String heroAssetPath;
  final String title;
  final String body;
  final String iconAssetPath;

  PageViewModel(
    this.color,
    this.heroAssetPath,
    this.title,
    this.body,
    this.iconAssetPath,
  );
}
