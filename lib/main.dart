import 'package:flutter/material.dart';
import 'homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastclock2/firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  const MyApp({Key? key}) : super(key: key);

/*   static var keyController = TextEditingController();
  static var hourController = TextEditingController();
  static var minuteController = TextEditingController(); */

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fast Clock',
      theme: ThemeData(scaffoldBackgroundColor: Color.fromARGB(206, 192, 207, 218),),
      home: HomePage(),
    );
  }
}