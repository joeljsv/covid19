import 'package:covid19/Screen/ui/colors.dart';
import 'package:covid19/Screen/ui/helpline.dart';
import 'package:covid19/Screen/ui/sceensize.dart';
import 'package:covid19/auth/login.dart';
import 'package:covid19/service/cautio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'assment/aassment.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> with SingleTickerProviderStateMixin {
  Animation virusBounce;
  Animation shadowFade;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              animationController.reverse();
            } else if (status == AnimationStatus.dismissed) {
              animationController.forward(from: 0.0);
            }
          });
    virusBounce = Tween(begin: Offset(0, 0), end: Offset(0, -20.0))
        .animate(animationController);
    shadowFade = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        curve: Interval(0.4, 1.0), parent: animationController));

    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Bgcolor,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(25, 100, 25, 25),
          child: Center(
            child: Column(
               
              children: <Widget>[
                
                Transform.translate(
                  offset: virusBounce.value,
                  child: Image(
                    alignment: Alignment.center,
                    image: AssetImage('asset/doc.png'),
                    height: screenAwareSize(190, context),
                    width: screenAwareSize(400, context),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                ),
                Center(
                  child: Text(
                    'Hey $name',
                    style: TextStyle(
                      color: Colors.indigo,
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'I\'am Dr: Covid',
                    style: TextStyle(
                      color: Colors.indigo,
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                 MaterialButton(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(40.0),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AssmentScreen()),
                    );
                  },
                  minWidth: double.infinity,
                  height: 40,
                  child: Text(
                    'Self Test '.toUpperCase(),
                  ),
                  color: Fgcolor,
                  textColor: Colors.white,
                ),
                SizedBox(height: 5),
                MaterialButton(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(40.0),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Cautions()),
                    );
                  },
                  minWidth: double.infinity,
                  height: 40,
                  child: Text(
                    'Precautions'.toUpperCase(),
                  ),
                  color: Fgcolor,
                  textColor: Colors.white,
                ),
                SizedBox(height: 5),
                MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Contact()),
                    );
                  },
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                  minWidth: double.infinity,
                  height: 40,
                  child: Text(
                    'HelpLine'.toUpperCase(),
                  ),
                  color: Fgcolor,
                  textColor: Colors.white,
                ),
                 SizedBox(height: 5),
                MaterialButton(
                  onPressed: () {
                    signOutGoogle();
                    removeValues();
                  
                  },
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(50.0),
                  ),
                  minWidth: 50,
                  height: 40,
                  child: Text(
                    'SignOut'.toUpperCase(),
                  ),
                  color: Fgcolor,
                  textColor: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
  removeValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("log");
  }
}
