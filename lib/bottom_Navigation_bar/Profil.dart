import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mjam/Screens/Login_and_SignIn/auch_with_Google.dart';
import 'package:mjam/Screens/Login_and_SignIn/login_screen.dart';
import 'package:mjam/Screens/Login_and_SignIn/sign_up_screen.dart';
import 'package:mjam/Widgets/BottomNavBarWidget.dart';

// ignore: must_be_immutable
class Profil extends StatefulWidget {
  Profil({Key key}) : super(key: key);
  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  logOut() async {
    await _auth.signOut().then((_) {});
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(' has successfully signed out.'),
    ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        length: 3,
        child: SafeArea(
          child: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.redAccent[400],
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                actions: signInOrNot == true
                    ? [
                        TextButton(
                          onPressed: () {
                            logOut();
                            signOutGoogle();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        BottomNavBarWidget()));
                          },
                          child: Text(
                            'Abmelden',
                            style: TextStyle(
                                color: Colors.redAccent[400], fontSize: 12),
                          ),
                        )
                      ]
                    : null,
                centerTitle: true,
                backgroundColor: Colors.white,
                elevation: 0,
                title: Text(
                  googleUserName == null ? 'Profil' : googleUserName,
                  style: TextStyle(
                      color: Colors.black, fontSize: 13, letterSpacing: 0.5),
                ),
                bottom: TabBar(
                  labelStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.4),
                  unselectedLabelColor: Colors.black,
                  labelColor: Colors.red[700],
                  indicatorColor: Colors.red[700],
                  indicatorWeight: 5,
                  tabs: [
                    Tab(
                      text: 'PROFIL',
                    ),
                    Tab(
                      text: 'HILFE',
                    ),
                    Tab(
                      text: 'NEUES',
                    )
                  ],
                ),
              ),
              body: TabBarView(children: [
                signInOrNot == false || googleUserName == null
                    ? Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //_________________assets/prof.png_____________
                            Container(
                              padding: EdgeInsets.only(top: 150, bottom: 15),
                              child: Container(
                                  height: 100,
                                  width: 100,
                                  child: Image.asset(
                                    'assets/prof.png',
                                    fit: BoxFit.fitHeight,
                                  )),
                            ),
                            //____________Es ist leer hier_________________
                            Container(
                              padding: EdgeInsets.only(bottom: 20),
                              child: Text(
                                'Es ist leer hier',
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black38),
                              ),
                            ),
                            //_________Du musst angemeldet sein_____________
                            Container(
                              padding: EdgeInsets.only(bottom: 30),
                              width: 200,
                              child: Text(
                                'Du musst angemeldet sein, um diese '
                                'Information sehen zu können',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black38),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            //______________KUNDENKONTO ERSTELLEN__________
                            Container(
                              // ignore: deprecated_member_use
                              child: FlatButton(
                                minWidth: 340,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  side: BorderSide(color: Colors.red[700]),
                                ),
                                child: Text(
                                  'KUNDENKONTO ERSTELLEN',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.red[700]),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SignUpScreen()));
                                },
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            //_______________________Oder___________________
                            Container(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(left: 45, right: 15),
                                      child: Divider(
                                        color: Colors.black38,
                                        height: 25,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'oder',
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.black38),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(left: 10, right: 45),
                                      child: Divider(
                                        color: Colors.black38,
                                        height: 25,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            //______________________ANMELDEN________________
                            Container(
                              // ignore: deprecated_member_use
                              child: FlatButton(
                                color: Colors.red[700],
                                minWidth: 340,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  side: BorderSide(color: Colors.red[700]),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen()));
                                },
                                child: Text(
                                  'ANMELDEN',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Center(
                        child: Text(
                          'Wilkommen',
                          style: TextStyle(
                              fontSize: 18, color: Colors.redAccent[400]),
                        ),
                      ),
                Container(
                  color: Colors.grey[100],
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(top: 10),
                        // ignore: deprecated_member_use
                        child: FlatButton(
                          padding: EdgeInsets.only(right: 285),
                          color: Colors.white,
                          child: Text(
                            'Hilfe Center',
                            style: TextStyle(fontSize: 13, color: Colors.black),
                          ),
                          onPressed: () {},
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        // ignore: deprecated_member_use
                        child: FlatButton(
                          height: 50,
                          padding: EdgeInsets.only(right: 300),
                          color: Colors.white,
                          minWidth: 450,
                          child: Text(
                            'Allergene',
                            style: TextStyle(fontSize: 13, color: Colors.black),
                          ),
                          onPressed: () {},
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        // ignore: deprecated_member_use
                        child: FlatButton(
                          height: 50,
                          padding: EdgeInsets.only(right: 288),
                          color: Colors.white,
                          minWidth: 450,
                          child: Text(
                            'Impressum',
                            style: TextStyle(fontSize: 13, color: Colors.black),
                          ),
                          onPressed: () {},
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        // ignore: deprecated_member_use
                        child: FlatButton(
                          height: 50,
                          padding: EdgeInsets.only(right: 333),
                          color: Colors.white,
                          minWidth: 450,
                          child: Text(
                            'AGB',
                            style: TextStyle(fontSize: 13, color: Colors.black),
                          ),
                          onPressed: () {},
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        // ignore: deprecated_member_use
                        child: FlatButton(
                          height: 50,
                          padding: EdgeInsets.only(right: 280),
                          color: Colors.white,
                          minWidth: 450,
                          child: Text(
                            'Datenschutz',
                            style: TextStyle(fontSize: 13, color: Colors.black),
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      'Derzeit sind keine Updates verfügbar. Bitte später noch einmal versuchen.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15, letterSpacing: 0.5),
                    ),
                  ),
                ),
              ])),
        ),
      ),
    );
  }
}
