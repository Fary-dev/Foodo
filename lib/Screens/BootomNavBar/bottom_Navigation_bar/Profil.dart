import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mjam/Contants/Color.dart';
import 'package:mjam/Screens/Home_Page/HomePage.dart';
import 'package:mjam/Screens/Login_and_SignUp/auch_with_Google.dart';
import 'package:mjam/Screens/Login_and_SignUp/auch_with_facebook.dart';
import 'package:mjam/Screens/Login_and_SignUp/login_screen.dart';
import 'package:mjam/Screens/Login_and_SignUp/sign_up_screen.dart';

class Profil extends StatefulWidget {
  Profil({Key? key}) : super(key: key);

  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  final LoginFacebook loginFacebook = Get.put(LoginFacebook());
  FirebaseAuth _auth = FirebaseAuth.instance;
  final userData = GetStorage();

  logOut() async {
    try {
      await _auth.signOut().whenComplete(
          () => Get.snackbar('Abmeldung', 'has successfully signed out.',icon:Icon(CupertinoIcons.person_alt_circle,color: primaryColor,),) );
      userData.write('isLogged', false);
      userData.remove('userName');
      userData.remove('method');
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              actions: [
                userData.read('isLogged') == true
                    ? TextButton(
                        child: Text(
                          'Abmelden',
                          style: Theme.of(context)
                              .primaryTextTheme
                              .button!
                              .copyWith(color: primaryColor, fontSize: 10),
                        ),
                        onPressed: () {
                          switch (userData.read('method')) {
                            case 'google':
                              print(userData.read('method'));
                              signOutGoogle();
                              Get.offAll(HomePage());
                              break;
                            case 'signUp':
                              print(userData.read('method'));
                              logOut();
                              Get.offAll(HomePage());
                              break;
                            case 'facebook':
                              print(userData.read('method'));
                              loginFacebook.signOutFacebook();
                              Get.offAll(HomePage());
                              break;
                          }
                         /* logOut();
                          signOutGoogle();
                          loginFacebook.signOutFacebook();*/

                        },
                      )
                    : TextButton(
                        onPressed: () {},
                        child: Text(
                          '',
                          style: TextStyle(color: primaryColor, fontSize: 12),
                        ),
                      ),
              ],
              centerTitle: true,
              elevation: 0,
              title: Text(
                !(userData.read('isLogged'))
                    ? 'Profil'
                    : userData.read('userName'),
                style: Theme.of(context).primaryTextTheme.button,
              ),
              bottom: TabBar(
                labelStyle: Theme.of(context).primaryTextTheme.headline2,
                unselectedLabelColor: greyColor,
                labelColor: primaryColor,
                indicatorColor: primaryColor,
                indicatorWeight: 3,
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
              userData.read('isLogged') == false
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //_________________assets/prof.png_____________
                        Container(
                          height: 80,
                          width: 80,
                          child: ColorFiltered(
                            child: Image.asset(
                              "assets/prof.png",
                              fit: BoxFit.fitHeight,
                            ),
                            colorFilter:
                                ColorFilter.mode(Colors.grey, BlendMode.srcIn),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        //____________Es ist leer hier_________________
                        Text(
                          'Es ist leer hier',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              color: greyColor),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        //_________Du musst angemeldet sein_____________
                        Text(
                          'Du musst angemeldet sein, um diese '
                          'Information sehen zu können',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                              color: greyColor),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 100,
                        ),
                        //______________KUNDENKONTO ERSTELLEN__________
                        MaterialButton(
                          minWidth: 340,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            side: BorderSide(color: primaryColor, width: 2.0),
                          ),
                          child: Text(
                            'KUNDENKONTO ERSTELLEN',
                            style: Theme.of(context)
                                .primaryTextTheme
                                .button!
                                .apply(color: primaryColor),
                          ),
                          onPressed: () {
                            Get.to(() => SignUpScreen());
                          },
                        ),

                        //_______________________Oder___________________
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 45, right: 15),
                                child: Divider(
                                  color: greyColor,
                                  height: 25,
                                ),
                              ),
                            ),
                            Text(
                              'oder',
                              style: TextStyle(fontSize: 11, color: greyColor),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 10, right: 45),
                                child: Divider(
                                  color: greyColor,
                                  height: 25,
                                ),
                              ),
                            ),
                          ],
                        ),

                        //______________________ANMELDEN________________
                        MaterialButton(
                          color: primaryColor,
                          minWidth: 340,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            side: BorderSide(color: primaryColor),
                          ),
                          onPressed: () {
                            Get.to(() => LoginScreen());
                          },
                          child: Text(
                            'ANMELDEN',
                            style: Theme.of(context)
                                .primaryTextTheme
                                .button!
                                .apply(color: whiteColor),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        )
                      ],
                    )
                  : Center(
                      child: Text(
                        'Wilkommen',
                        style: Theme.of(context)
                            .primaryTextTheme
                            .headline2!
                            .copyWith(fontSize: 20),
                      ),
                    ),
              Column(
                children: [
                  buildContainer('Hilfe Center', () {}),
                  buildContainer('Allergene', () {}),
                  buildContainer('Impressum', () {}),
                  buildContainer('AGB', () {}),
                  buildContainer('Datenschutz', () {}),
                ],
              ),
              Center(
                child: Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    'Derzeit sind keine Updates verfügbar. Bitte \nspäter noch einmal versuchen.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).primaryTextTheme.headline3,
                  ),
                ),
              ),
            ])),
      ),
    );
  }

  Widget buildContainer(String text, VoidCallback function) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: MediaQuery.of(context).size.width,
      child: MaterialButton(
        elevation: 0,
        height: 50,
        color: Theme.of(context).cardColor,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            style: Theme.of(context).primaryTextTheme.headline2,
          ),
        ),
        onPressed: function,
      ),
    );
  }
}
