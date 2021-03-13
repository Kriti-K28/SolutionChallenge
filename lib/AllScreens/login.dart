// import 'dart:html';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tracking_app/AllScreens/Signup.dart';

import '../main.dart';
import 'mainScreen.dart';


// ignore: camel_case_types
// ignore: must_be_immutable
class login extends StatelessWidget {
  static const String idScreen = "login";
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 100.0,
            ),
            Image(
              image: AssetImage("images/logo.png"),
              width: 350.0,
              height: 300.0,
              alignment: Alignment.center,
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              "Login as a user",
              style: TextStyle(
                fontSize: 24.0,
              ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 1.0,
                  ),
                  TextField(
                    controller: emailTextEditingController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(
                        fontSize: 14.0,
                      ),
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 10.0,
                      ),
                    ),
                    style: TextStyle(fontSize: 14.0),
                  ),
                  SizedBox(
                    height: 1.0,
                  ),
                  TextField(
                    controller: passwordTextEditingController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(
                        fontSize: 14.0,
                      ),
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 10.0,
                      ),
                    ),
                    style: TextStyle(fontSize: 14.0),
                  ),
                  SizedBox(
                    height: 1.0,
                  ),
                  // ignore: deprecated_member_use
                  RaisedButton(
                    color: Colors.yellow,
                    textColor: Colors.white,
                    child: Container(
                      height: 50.0,
                      child: Center(
                        child: Text(
                          "Login",
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(24.0),
                    ),
                    onPressed: () {
                      if (!emailTextEditingController.text.contains("@")) {
                        displayToastMessage("Email address not valid", context);
                      } else if (passwordTextEditingController.text.length <
                          7) {
                        displayToastMessage(
                            "Password must be atleast 6 characters", context);
                      } else {
                        LoginWithAuth(context);
                      }
                    },
                  ),
                ],
              ),
            ),
            FlatButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, Signup.idScreen, (route) => false);
              },
              child: Text(
                "Do not have account ? Register now",
              ),
            )
          ],
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void LoginWithAuth(BuildContext context) async {
    final User firebaseUser = (await _firebaseAuth
            .signInWithEmailAndPassword(
                email: emailTextEditingController.text,
                password: passwordTextEditingController.text)
            .catchError((errmsg) {
      displayToastMessage("Error : " + errmsg.toString(), context);
    }))
        .user;
    if (firebaseUser != null) {
      userRef.child(firebaseUser.uid).once().then((DataSnapshot snap) {
        if (snap.value != null) {
          Navigator.pushNamedAndRemoveUntil(
              context, mainScreen.idScreen, (route) => false);
          displayToastMessage("You are logged in", context);
        } else {
          _firebaseAuth.signOut();
          displayToastMessage("Email or password is incorrect", context);
        }
      });
    } else {
      displayToastMessage("Error occurred .Please try again later", context);
    }
  }

  void displayToastMessage(String s, BuildContext context) {}
}
