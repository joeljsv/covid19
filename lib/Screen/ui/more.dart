import 'package:covid19/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class MoreScreen extends StatefulWidget {
  @override
  _ProState createState() => _ProState();
}

class _ProState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        
        title: Text(
          'More',
          style: TextStyle(color: Colors.indigo),
        ),
        iconTheme: IconThemeData(color: Colors.indigo),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: _height / 12,
              ),
              CircleAvatar(
                radius: _width < _height ? _width / 6 : _height / 6,
                backgroundImage: NetworkImage(imageUrl),
              ),
              SizedBox(
                height: _height / 50.0,
              ),
              Text(
                fulname,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: _width / 15,
                    color: Colors.indigo),
              ),
              SizedBox(
                height: _height / 50.0,
              ),
              Text(
                email,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: _width / 25,
                    color: Colors.indigo),
              ),
              Divider(height: _height / 30, color: Colors.indigo),
              Container(
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.indigo,
                    width: 4,
                  ),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CustomListTile(
                        FontAwesomeIcons.globe,
                        'Gov.of India Update',
                        () => launch("https://mohfw.gov.in/")),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomListTile(
                        FontAwesomeIcons.globe,
                        'Coronavirus advisory information\n(WHO)',
                        () => launch(
                            "https://www.who.int/emergencies/diseases/novel-coronavirus-2019/advice-for-public")),
                    SizedBox(
                      height: 20,
                    ),
                    CustomListTile(
                        FontAwesomeIcons.globe,
                        'Coronavirus condition overview\n(WHO)',
                        () => launch(
                            "https://www.who.int/health-topics/coronavirus")),
                    SizedBox(
                      height: 20,
                    ),
                    CustomListTile(Icons.phone, 'Kerala Help Line',
                        () => launch("tel://0471-2552056")),
                    SizedBox(
                      height: 20,
                    ),
                    CustomListTile(Icons.phone, 'Disha Call Center',
                        () => launch("tel://1056")),
                    SizedBox(
                      height: 20,
                    ),
                    CustomListTile(FontAwesomeIcons.whatsapp, 'WHO',
                        () => launch("http://bit.ly/who-covid19-whatsapp")),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: _width / 8, right: _width / 8),
                child: InkWell(
                  onTap: () {
                    signOutGoogle();
                    removeValues();
                  },
                  child: Text(
                    'Sign Out',
                    style: TextStyle(color: Colors.indigo, fontSize: 30),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void signOutGoogle() async {
    await googleSignIn.signOut().whenComplete(() {
      googleSignIn
          .disconnect()
          .whenComplete(() => Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) {
                    return LoginPage();
                  },
                ),
              ));
    });

    print("User Sign Out");
  }

  removeValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("log");
  }
}

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function onTap;

  CustomListTile(this.icon, this.text, this.onTap);
  @override
  Widget build(BuildContext context) {
    //ToDO
    final _width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
      child: Container(
        width: _width - 20,
        child: InkWell(
            splashColor: Colors.indigoAccent,
            onTap: onTap,
            child: Container(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          icon,
                          color: Colors.indigo,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                        ),
                        Text(
                          text,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      ],
                    ),
                    Icon(Icons.arrow_right)
                  ],
                ))),
      ),
    );
  }
}
