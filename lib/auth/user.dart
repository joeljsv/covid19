import 'package:covid19/Screen/ui/start.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './login.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  removeValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("log");
  }

  void signOutGoogle() async {
    await googleSignIn.signOut().whenComplete((){
      googleSignIn.disconnect().whenComplete(() =>  Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) {
                return LoginPage();
              },
            ),
          ))
      ;});

    print("User Sign Out");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StartScreen()
    );
  }
}
