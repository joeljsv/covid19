import 'package:covid19/Screen/ui/onbording/onbord.dart';
import 'package:covid19/auth/screen.dart';
import 'package:covid19/auth/user.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

addBoolToSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('log', true);
}

String name;
String email;
String fulname;
String imageUrl;
String uid;
final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
Future<String> signInSlientWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount =
      await googleSignIn.signInSilently();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final AuthResult authResult = await _auth.signInWithCredential(credential);
  final FirebaseUser user = authResult.user;

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);
  assert(user.email != null);
  assert(user.displayName != null);
  assert(user.photoUrl != null);

  name = user.displayName;
  email = user.email;
  imageUrl = user.photoUrl;
  uid = user.uid;
  fulname=name;

// Only taking the first part of the name, i.e., First Name
  if (name.contains(" ")) {
    name = name.substring(0, name.indexOf(" "));
  }

  return 'signInWithGoogle succeeded: $user';
}

Future<String> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final AuthResult authResult = await _auth.signInWithCredential(credential);
  final FirebaseUser user = authResult.user;

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);
  assert(user.email != null);
  assert(user.displayName != null);
  assert(user.photoUrl != null);

  name = user.displayName;
  email = user.email;
  imageUrl = user.photoUrl;
  uid = user.uid;
  fulname=name;

// Only taking the first part of the name, i.e., First Name
  if (name.contains(" ")) {
    name = name.substring(0, name.indexOf(" "));
  }

  return 'signInWithGoogle succeeded: $user';
}

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

class Message {
  String title;
  String body;
  String message;
  Message(title, body, message) {
    this.title = title;
    this.body = body;
    this.message = message;
  }
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();

    check();
  }

  List<Message> messagesList;

  _configureFirebaseListeners() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage: $message');
        _setMessage(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch: $message');
        _setMessage(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print('onResume: $message');
        _setMessage(message);
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(sound: true, badge: true, alert: true),
    );
  }

  _setMessage(Map<String, dynamic> message) {
    final notification = message['notification'];
    final data = message['data'];
    final String title = notification['title'];
    final String body = notification['body'];
    String mMessage = data['message'];
    print("Title: $title, body: $body, message: $mMessage");
    setState(() {
      Message msg = Message(title, body, mMessage);
      messagesList.add(msg);
    });
  }

  bool suc = true;
  @override
  void check() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool CheckValue = prefs.containsKey('log');
    print('bool $CheckValue');
    if (CheckValue) {
      setState(() {
        suc = true;
      });
      if (name != null) {
        signInSlientWithGoogle()
            .whenComplete(() => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) {
                      return FirstScreen();
                    },
                  ),
                ));
      } else {
        print('Name');
        signInSlientWithGoogle().whenComplete(() {
          (email != null)
              ? Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) {
                      return FirstScreen();
                    },
                  ),
                )
              : setState(() {
                  suc = false;
                });
        });
      }
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) {
            return Instruction();
          },
        ),
      );
    }
  }

  addBoolToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('log', true);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF716cff),
      body: Center(
        child: Container(
          child: Center(
              child: (suc)
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            height: 120,
                            width: 120,
                            child: Image.asset('asset/klgo.png')),
                        SizedBox(
                          height: 20,
                        ),
                        CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        )
                      ],
                    )
                  : Container(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.signal_wifi_off,
                          color: Colors.white,
                          size: 50,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Somthing  wrong !',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        FlatButton(
                          onPressed: () {
                            check();
                          },
                          child: Text('Retry !'),
                          color: Colors.white,
                          textColor: Colors.indigo,
                        ),
                      ],
                    ))),
        ),
      ),
    );
  }
}
