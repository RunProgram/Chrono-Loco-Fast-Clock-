import 'package:flutter/material.dart';
import 'homepage.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() {
  
  runApp(const MyApp());
}

//await Firebase.initializeApp(
  //options: DefaultFirebaseOptions.currentPlatform,
//);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fast Clock',
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFD8D8D8,),),
      home: HomePage(),
    );
  }
}