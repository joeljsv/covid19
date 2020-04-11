import 'package:avatar_glow/avatar_glow.dart';
import 'package:covid19/Screen/ui/colors.dart';
import 'package:covid19/Screen/ui/sceensize.dart';
import 'package:covid19/service/Apimode.dart';
import 'package:flutter/material.dart';

class Coronad extends StatelessWidget {
  final Corona corona;

  Coronad({this.corona});

  bodyWidget(BuildContext context) => Stack(
        children: <Widget>[
          Positioned(
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width - 20,
            left: 10.0,
            top: MediaQuery.of(context).size.height * 0.1,
            child: Padding(
              padding: const EdgeInsets.only(left: 3.0),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 60),
                    Row(
                      children: <Widget>[
                        colorCard("Total Cases", corona.totalCases, context,
                            Color(0xFF716cff)),
                        colorCard("New Cases", corona.newCases, context,
                            Color(0xFF716cff)),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        colorCard("Total Deaths", corona.totalDeaths, context,
                            Color(0xFF716cff)),
                        colorCard("New Deaths", corona.newDeaths, context,
                            Color(0xFF716cff)),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        colorCard("Total Recoverd", corona.totalRecoverd,
                            context, Color(0xFF716cff)),
                        colorCard("Active Cases", corona.activeCases, context,
                            Color(0xFF716cff)),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        colorCard("Serious Cases", corona.serious, context,
                            Color(0xFF716cff)),
                        colorCard("Avg 1M", corona.average, context,
                            Color(0xFF716cff)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Hero(
              tag: corona.activeCases,
              child: AvatarGlow(
                endRadius: 70,
                duration: Duration(seconds: 2),
                glowColor: Colors.indigo,
                repeat: true,
                repeatPauseDuration: Duration(seconds: 1),
                startDelay: Duration(seconds: 1),
                child: Material(
                    shape: CircleBorder(),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Container(
                        child: Image.asset('asset/coronadetails.png'),
                      ),
                      radius: 50.0,
                    )),
              ),
            ),
          )
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Bgcolor,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.indigo),
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          corona.country.toUpperCase(),
          style: TextStyle(color: Colors.indigo),
        ),
      ),
      body: bodyWidget(context),
    );
  }
}

Widget colorCard(
    String text, String fields, BuildContext context, Color color) {
  final _media = MediaQuery.of(context).size;
  return Container(
    margin: EdgeInsets.only(top: 9, right: 9),
    padding: EdgeInsets.all(25),
    height: screenAwareSize(80, context),
    width: _media.width / 2 - 25,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(17),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          text,
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          "${fields.toString()}",
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    ),
  );
}
