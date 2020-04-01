import 'dart:convert';
import 'package:covid19/Screen/ui/colors.dart';
import 'package:covid19/Screen/ui/sceensize.dart';
import 'package:covid19/service/statewise.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:line_icons/line_icons.dart';

import 'statedetail.dart';



class StateScreen extends StatefulWidget {
  @override
  _StateScreenState createState() => _StateScreenState();
}

class _StateScreenState extends State<StateScreen> {
  List<StateWise> test, sample, _dat1;

  var jsondata;
  Andhra d;

  String s = "https://indiacovid-api.herokuapp.com/total";
  Future<void> getData() async {
    final response = await http.get(s);
    jsondata = json.decode(response.body);
    d = Andhra.fromJson(jsondata);
    test = d.stateWise;
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
            centerTitle: true,
            title: Text('State Wise',style: TextStyle(
              fontSize: 30,
              color: Colors.indigo
            ),),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          //backgroundColor: Color.fromRGBO(209, 224, 224, 0.2),
          //backgroundColor:Color(0xFFFF3B4254),
          backgroundColor: Bgcolor,
          body: d == null
              ? Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                    valueColor: new AlwaysStoppedAnimation<Color>(Fgcolor),
                  ),
                )
              : RefreshIndicator(
                  backgroundColor: Colors.white,
                  color: Colors.indigo,
                  onRefresh: getData,
                  child: Column(children: <Widget>[
                    SizedBox(height: 10),
                    Container(
                      width: screenAwareSize(300, context),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: screenAwareSize(40, context),
                      decoration: BoxDecoration(
                        //  color: Colors.indigoAccent[100],
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(15.0),
                              bottomLeft: Radius.circular(15.0),
                              topLeft: Radius.circular(15.0),
                              topRight: Radius.circular(15.0))),
                      child: TextField(
                        style: new TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          alignLabelWithHint: true,
                          
                          contentPadding: EdgeInsets.only(top: 15.0),
                          border: InputBorder.none,
                          
                          hintText: 'Search Here...',
                          hintStyle: TextStyle(color: Colors.indigo, fontSize: 16.0),
                          labelStyle: TextStyle(color: Colors.indigo),
                          prefixIcon: Icon(Icons.search, color: Colors.indigo),
                        ),
                        onChanged: (text) {
                          setState(() {
                            _dat1 = sample
                                .where((r) => (r.state
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
                                    padding: EdgeInsets.only(left: 7),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Coronad(
                                                      corona: pointer,
                                                    )));
                                      },
                                      child: Card(
                                        elevation: 0,
                                        color: Bgcolor,
                                        margin: new EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 8.0),
                                        child: ListTile(
                                          leading: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            backgroundImage: NetworkImage('https://img.icons8.com/color/480/coronavirus.png'),
                                          ),
                                          title: Text(
                                            pointer.deaths,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
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
                                                  builder: (context) => Coronad(
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
              ]),
            ),
    );
  }
}
