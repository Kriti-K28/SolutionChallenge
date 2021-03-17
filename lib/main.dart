import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracking_app/AllScreens/Signup.dart';
import 'package:tracking_app/AllScreens/login.dart';
import 'package:tracking_app/AllScreens/mainScreen.dart';
import 'package:tracking_app/DataHandle/Appdata.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create : (_) => AppData()),
    ],
    child: MyApp()));
}

DatabaseReference userRef =
    FirebaseDatabase.instance.reference().child("users");

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return 
        MaterialApp(
        title: "Flutter App",
        home: mainScreen(),
        theme: ThemeData(
          
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // initialRoute: mainScreen.idScreen,
        routes: {
          Signup.idScreen: (context) => Signup(),
          login.idScreen: (context) => login(),
          mainScreen.idScreen: (context) => mainScreen(),
        },
        debugShowCheckedModeBanner: false,
      
    );
  }
}
