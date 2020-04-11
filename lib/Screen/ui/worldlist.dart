import 'dart:convert';
import 'package:covid19/service/Apimode.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:line_icons/line_icons.dart';

import 'colors.dart';
import 'countrydetail.dart';
import 'sceensize.dart';

class Worldlist extends StatefulWidget {
  @override
  _WorldlistState createState() => _WorldlistState();
}

class _WorldlistState extends State<Worldlist> {
  List<Corona> test, sample, _dat1;

  var jsondata;
  Details d, temp, a;
  String s = "https://api-corona.herokuapp.com/";
  Future<void> getData() async {
    final response = await http.get(s);
    jsondata = json.decode(response.body);
    d = Details.fromJson(jsondata);
    test = d.corona;
    setState(() {
      sample = test;
      _dat1 = sample;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'World List',
          style: TextStyle(color: Colors.indigo),
        ),
        iconTheme: IconThemeData(
          color: Colors.indigo
        ),
      ),
      backgroundColor: Bgcolor,
      body: d == null
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
                valueColor: new AlwaysStoppedAnimation<Color>(Fgcolor),
              ),
            )
          : RefreshIndicator(
              onRefresh: getData,
              child: Column(
                children: <Widget>[
                  Container(
                    width: screenAwareSize(300, context),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    height: screenAwareSize(40, context),
                    decoration: BoxDecoration(
                        //  color: Color(0xFF262626),
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(15.0),
                            bottomLeft: Radius.circular(15.0),
                            topLeft: Radius.circular(15.0),
                            topRight: Radius.circular(15.0))),
                    child: TextField(
                      style: new TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 15.0),
                        border: InputBorder.none,
                        hintText: 'Search Here...',
                        hintStyle:
                            TextStyle(color: Colors.indigo, fontSize: 15.0),
                        labelStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(Icons.search, color: Colors.indigo),
                      ),
                      onChanged: (text) {
                        setState(() {
                          _dat1 = sample
                              .where((r) => (r.country
                                  .toLowerCase()
                                  .contains(text.trim().toLowerCase())))
                              .toList();
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      children: _dat1
                          .map((pointer) => Padding(
                                padding: const EdgeInsets.all(3),
                                child: Container(
                                  decoration:
                                      BoxDecoration(shape: BoxShape.circle),
                                  padding: EdgeInsets.only(left: 7),
                                  child: InkWell(
                                    focusColor: Colors.white,
                                    highlightColor: Colors.white,
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Coronad(
                                                    corona: pointer,
                                                  )));
                                    },
                                    child: Card(
                                      elevation: 00,
                                      //  shadowColor: Colors.indigo,

                                      margin: new EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 8.0),
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          child: Icon(LineIcons.map_marker),
                                        ),
                                        title: Text(
                                          pointer.country,
                                          style: TextStyle(
                                            color: Colors.indigo,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        subtitle: Text(
                                          "Total Cases : " +
                                              pointer.totalCases.toString(),
                                          style: TextStyle(
                                            color: Colors.indigo,
                                          ),
                                        ),
                                        trailing: IconButton(
                                          icon: Icon(
                                            LineIcons.arrow_circle_o_right,
                                            color: Colors.indigo,
                                          ),
                                          iconSize: 31,
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Coronad(
                                                          corona: pointer,
                                                        )));
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
