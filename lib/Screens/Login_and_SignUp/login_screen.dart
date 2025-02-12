import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mjam/Contants/Color.dart';
import 'package:mjam/Screens/Login_and_SignUp/reset_password.dart';
import 'package:mjam/Screens/BootomNavBar/BottomNavBarWidget.dart';
import 'package:mjam/Widgets/customTextField.dart';

import 'auch_with_Google.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final userData = GetStorage();
  TextStyle txtBtnStyle = TextStyle(color: Colors.black, fontSize: 16);
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool showPassword = false;

  void click() {
    setState(() {
      signInWithGoogle().whenComplete(() {
        Get.to(() => BottomNavBarWidget());
        /* Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return BottomNavBarWidget();
            },
          ),
        );*/
      });
    });
  }

  @override
  void initState() {
    showPassword = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Anmelden',
            style: Theme.of(context).primaryTextTheme.button,
          ),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              CupertinoIcons.arrow_left,
              color: Theme.of(context).iconTheme.color,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                //__________________Foode_Kundenkonto_erstellen____
                Text('Anmelden',
                    style: Theme.of(context).primaryTextTheme.headline2),

                SizedBox(
                  height: 15,
                ),
                //____________________Facebook_____Google__________
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //___________________Facebook_______________
                    Expanded(
                      flex: 25,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        color: Theme.of(context).cardColor,
                        onPressed: () {
                          print('Facebook');
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(
                                    image: AssetImage('assets/facebook.jpg'),
                                  )),
                              height: 25,
                              width: 25,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text('Facebook',
                                style:
                                    Theme.of(context).primaryTextTheme.button),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        width: 10,
                      ),
                    ),
                    //____________________Google________________
                    Expanded(
                      flex: 25,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        color: Theme.of(context).cardColor,
                        onPressed: () {
                          setState(() {
                            click();
                          });
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 7),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                image: AssetImage('assets/google.png'),
                              )),
                              height: 30,
                              width: 30,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Google',
                              style: Theme.of(context).primaryTextTheme.button,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                //____________________________Oder_________________
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 2,
                        color: Theme.of(context).hoverColor,
                        margin: EdgeInsets.only(right: 15),
                        child: Divider(
                          color: blackColor,
                          height: 25,
                        ),
                      ),
                    ),
                    Text(
                      'oder',
                      style: TextStyle(
                        fontSize: 13,
                        color: Theme.of(context).hoverColor,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 2,
                        color: Theme.of(context).hoverColor,
                        margin: EdgeInsets.only(left: 10),
                        child: Divider(
                          color: blackColor,
                          height: 30,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                //_____________________Mit E-Mail registrieren_____
                Text(
                  'Mit E-Mail einloggen',
                  style: Theme.of(context).primaryTextTheme.headline2,
                ),
                SizedBox(
                  height: 40,
                ),
                //_____________________Name_E-Mail_Password________
                Container(
                  child: Form(
                    key: _formKey,
                    autovalidateMode:AutovalidateMode.onUserInteraction ,
                    child: Column(
                      children: [
                        CustomTextField(
                          lable: 'E-Mail',
                          controller: _emailController,
                          obscureText: false,
                          // inputFormatters: FilteringTextInputFormatter.deny(
                          //     RegExp(r"\s\b|\b\s")),
                          textInputType: TextInputType.emailAddress,
                          prefixIcon: Icon(
                            CupertinoIcons.mail,
                            color: Colors.grey[500],
                            size: 18,
                          ),
                          onSave: (input) =>
                              _emailController.text = input!.trim(),
                          validator: validateEmail,
                        ),
                        /*TextFormField(
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(
                                RegExp(r"\s\b|\b\s"))
                          ],
                          style: Theme.of(context)
                              .primaryTextTheme
                              .headline3!
                              .apply(fontSizeDelta: 2),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'E-Mail',
                            suffixIcon: Icon(
                              CupertinoIcons.mail,
                              color: Colors.grey[500],
                              size: 18,
                            ),
                          ),
                          validator: validateEmail,
                          onSaved: (input) => _email = input!.trim(),
                          controller: _emailController,
                        ),*/
                        SizedBox(height: 10),
                        CustomTextField(
                          lable: 'Password',
                          controller: _passwordController,
                          obscureText: !showPassword ? true : false,
                          // inputFormatters: FilteringTextInputFormatter.deny(
                          //     RegExp(r"\s\b|\b\s")),
                          textInputType: TextInputType.emailAddress,
                          prefixIcon: !showPassword
                              ? IconButton(
                                  onPressed: () {
                                    setState(() {
                                      showPassword = true;
                                    });
                                  },
                                  icon: Icon(
                                    CupertinoIcons.eye,
                                    size: 20,
                                    color: Colors.grey[500],
                                  ),
                                )
                              : IconButton(
                                  onPressed: () {
                                    setState(() {
                                      showPassword = false;
                                    });
                                  },
                                  icon: Icon(
                                    CupertinoIcons.eye_slash,
                                    color: Colors.grey[500],
                                  ),
                                ),
                          onSave: (input) =>
                              _passwordController.text = input!.trim(),
                          validator: validatePassword,
                        ),
                        /*TextFormField(
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(
                                RegExp(r"\s\b|\b\s"))
                          ],
                          obscureText: !showPassword ? true : false,
                          style: Theme.of(context)
                              .primaryTextTheme
                              .headline3!
                              .apply(fontSizeDelta: 2),
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'Password',
                            suffixIcon: !showPassword
                                ? IconButton(
                                    onPressed: () {
                                      setState(() {
                                        showPassword = true;
                                      });
                                    },
                                    icon: Icon(
                                      CupertinoIcons.eye,
                                      size: 20,
                                      color: Colors.grey[500],
                                    ),
                                  )
                                : IconButton(
                                    onPressed: () {
                                      setState(() {
                                        showPassword = false;
                                      });
                                    },
                                    icon: Icon(
                                      CupertinoIcons.eye_slash,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                          ),
                          validator: validatePassword,
                          onSaved: (input) => _password = input!.trim(),
                          controller: _passwordController,
                        ),*/
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 200,
                ),
                //__________________KUNDENKONTO_ERSTELLE___________
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  child: MaterialButton(
                    color: primaryColor,
                    onPressed: signIn,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Text('Anmelden'.toUpperCase(),
                        style: Theme.of(context)
                            .primaryTextTheme
                            .button!
                            .copyWith(fontSize: 14, color: Color(0xFFFFFFFF))),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: TextButton(
                    onPressed: () => Get.to(() => ResetPasswordScreen()),
                    child: Text(
                      'Password vergessen?',
                      style: TextStyle(color: primaryColor, fontSize: 11),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? validateEmail(String? value) {
    final pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    return !regex.hasMatch(value!)?
       'Bitte gib eine gültige E-Mail-Adresse ein':
       null;

  }

  String? validatePassword(String? value) {
    final pattern = r'^(?=.*\d)(?=.*[a-zA-Z])[a-zA-Z0-9!@#$%&*]{6,20}$';
    RegExp regex = RegExp(pattern);

   return value!.isEmpty?
       'Please enter password':
     !regex.hasMatch(value) ?

        'Bitte gib eine gültige Password ein':
         null;

    }

  Future<void> signIn() async {
    final formState = _formKey.currentState;
    if (formState!.validate()) {
      formState.save();
      try {
        final User? user = (await FirebaseAuth.instance
                .signInWithEmailAndPassword(
                    email: _emailController.text,
                    password: _passwordController.text))
            .user;
        userData.write('userName', user!.displayName);
        userData.write('userName', user.email);
        userData.write('isLogged', true);
        Get.offAll(BottomNavBarWidget());
      } catch (e) {
        Get.snackbar('Achtung', 'Kennword oder Email passt nicht!!');
        e.printError();
      }
    }
  }
}
