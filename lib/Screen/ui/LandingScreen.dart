import 'package:covid19/Screen/ui/colors.dart';
import 'package:covid19/Screen/ui/helpline.dart';
import 'package:covid19/Screen/ui/more.dart';
import 'package:covid19/Screen/ui/sceensize.dart';
import 'package:covid19/assment/assment.dart';
import 'package:covid19/auth/login.dart';
import 'package:covid19/service/cautio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

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

  Future<void> _neverSatisfied() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Covid 19 Tracker(Dr:Covid)'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Developed by DEVCORP\n'),
                Text('Developer info:\n'),
                Center(
                    child: Text(
                  'Connect With us\n',
                  style: TextStyle(color: Colors.indigo),
                )),
                Divider(thickness: 5, color: Colors.indigo),
                Text('\n'),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      child: Icon(
                        FontAwesomeIcons.github,
                        size: 40,
                      ),
                      onTap: () =>
                          launch('https://github.com/joelSunnyVarhese'),
                    ),
                    Text('\t\t'),
                    InkWell(
                      child: Icon(
                        FontAwesomeIcons.instagram,
                        size: 40,
                      ),
                      onTap: () =>
                          launch('https://www.instagram.com/joel.10._/'),
                    ),
                    Text('\t\t'),
                    InkWell(
                      child: Icon(
                        FontAwesomeIcons.telegram,
                        size: 40,
                      ),
                      onTap: () => launch('https://t.me/joelsunny10'),
                    ),
                    Text('\t\t'),
                    InkWell(
                      child: Icon(
                        FontAwesomeIcons.whatsapp,
                        size: 40,
                      ),
                      onTap: () => launch('https://wa.me/917034445301'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: <Widget>[
          InkWell(
            child: Icon(
              Icons.info,
              color: Colors.indigo,
            ),
            onTap: () => _neverSatisfied(),
          ),
          SizedBox(
            width: 10,
          ),
        ],
        elevation: 0,
      ),
      backgroundColor: Bgcolor,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(25, 10, 25, 25),
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
                  padding: EdgeInsets.only(top: 0),
                ),
                Center(
                  child: Text(
                    (name != null) ? 'Hey $name' : 'Hey',
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
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AssmentScreen()),
                  ),
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
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Cautions()),
                  ),
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
                MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MoreScreen()),
                    );
                  },
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                  minWidth: double.infinity,
                  height: 40,
                  child: Text(
                    'More'.toUpperCase(),
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
}
