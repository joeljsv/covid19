import 'dart:convert';
import 'package:covid19/Screen/ui/sceensize.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'colors.dart';

class TestDart extends StatefulWidget {
  @override
  _TestDartState createState() => _TestDartState();
}

var jsondata;

dynamic state;
String s = "https://api.rootnet.in/covid19-in/stats/latest";
List<dynamic> statewise = [];

class _TestDartState extends State<TestDart> {
  Future<void> getData() async {
    print(s);

    final response = await http.get(s);
    print(response.toString());
    jsondata = json.decode(response.body);
    print(response.body);
    print('Data Print');
    print(jsondata);
    setState(() {
      statewise = jsondata['data']['regional'];
    });

    print(statewise.length);
    for (int i = 0; i < statewise.length; i++) {
      print(statewise[i]['loc']);
    }
  }

  @override
  void initState() {
    super.initState();

    getData();
  }

  @override
  Widget build(BuildContext context) {
    BuildContext ctxt;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'INDIA',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            inherit: true,
            color: Color(0xFF716cff),
            letterSpacing: 0.4,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: jsondata == null
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Color(0xFF716cff),
                valueColor: new AlwaysStoppedAnimation<Color>(Fgcolor),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            colorCard(
                                "Active",
                                '${jsondata['data']['summary']['total'] - jsondata['data']['summary']['discharged'] - jsondata['data']['summary']['deaths']}',
                                context,
                                Color(0xFF716cff)),
                            colorCard(
                                "Total",
                                jsondata['data']['summary']['total'].toString(),
                                context,
                                Color(0xFF716cff)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            colorCard(
                                "Confirmed Indian",
                                jsondata['data']['summary']
                                        ['confirmedCasesIndian']
                                    .toString(),
                                context,
                                Color(0xFF716cff)),
                            colorCard(
                                "Confirmed Foreign",
                                jsondata['data']['summary']
                                        ['confirmedCasesForeign']
                                    .toString(),
                                context,
                                Color(0xFF716cff)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            colorCard(
                                "Discharged",
                                jsondata['data']['summary']['discharged']
                                    .toString(),
                                context,
                                Color(0xFF716cff)),
                            colorCard(
                                "Death cases",
                                jsondata['data']['summary']['deaths']
                                    .toString(),
                                context,
                                Color(0xFF716cff)),
                          ],
                        ),
                        SizedBox(height: 50),
                        Text(
                          'STATE LIST',
                          style: TextStyle(
                              fontSize: 30, color: const Color(0xFF716cff)),
                        ),
                        SizedBox(height: 50),
                      ],
                    ),
                  ),
                  for (int i = 0; i < statewise.length; i++) buildBody(ctxt, i)
                ],
              ),
            ),
    );
  }
}

Widget box = SizedBox(
  height: 5,
);
Widget buildBody(BuildContext ctxt, int i) {
  return Container(
    padding: EdgeInsets.all(8),
    child: Center(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFF716cff),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              '${statewise[i]['loc']}',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Container(
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Divider(
                    color: const Color(0xFF716cff),
                    thickness: 2,
                  ),
                  box,
                  Text(
                    "Active  :- ${statewise[i]['confirmedCasesIndian'] + statewise[i]['confirmedCasesForeign']-statewise[i]['discharged']-statewise[i]['deaths']}",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ), box,
                  Text(
                    "Total  :- ${statewise[i]['confirmedCasesIndian'] + statewise[i]['confirmedCasesForeign']}",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  box,
                  Text(
                    "Confirmed Indian :- ${statewise[i]['confirmedCasesIndian']}",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  box,
                  Text(
                    "Confirmed Foreign :- ${statewise[i]['confirmedCasesForeign']}",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  box,
                  Text(
                    "Discharged :- ${statewise[i]['discharged']}",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  box,
                  Text(
                    "Deaths :- ${statewise[i]['deaths']}",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Widget colorCard(String text, String f, BuildContext context, Color color) {
  final _media = MediaQuery.of(context).size;
  return Container(
    margin: EdgeInsets.only(top: 18, right: 12),
    padding: EdgeInsets.all(25),
    height: screenAwareSize(100, context),
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
          "${f.toString()}",
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
