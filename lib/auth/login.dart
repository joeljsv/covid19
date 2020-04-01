import 'package:covid19/auth/screen.dart';
import 'package:covid19/auth/user.dart';
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
String imageUrl;
String uid;
final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
Future<String> signInSlientWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signInSilently();
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

// Only taking the first part of the name, i.e., First Name
  if (name.contains(" ")) {
    name = name.substring(0, name.indexOf(" "));
  }

  return 'signInWithGoogle succeeded: $user';
}


 
class _LoginPageState extends State<LoginPage> {
  @override
void initState() {
  super.initState();
 
  
  check();
  
  
  }
  @override
  void check()async{
     SharedPreferences prefs = await SharedPreferences.getInstance();

bool CheckValue = prefs.containsKey('log');
print('bool $CheckValue');
if(CheckValue){
  if(name!=null){
signInSlientWithGoogle().whenComplete(() =>  Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) {
              return FirstScreen();
            },
          ),
        ));
}else{
  signInSlientWithGoogle().whenComplete(() =>  Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) {
              return FirstScreen();
            },
          ),
        ));

}}else{
Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) {
                return LoginAnimatedScreen();
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
      body: Center(
              child: Container(
          height: 60,
          width: 60,
          color: Colors.white,
          child: Center(
            child: Image.asset('asset/klgo.png'),
          ),
        ),
      ),
    );
  }}