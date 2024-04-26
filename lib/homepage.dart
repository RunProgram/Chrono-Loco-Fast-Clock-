import 'package:fastclock2/offline/offlineselect.dart';
import 'package:fastclock2/sessioncreate/selectorpagecreate.dart';
import 'package:fastclock2/sessionjoin/entercode.dart';
import 'package:flutter/material.dart';
import 'dart:core';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 30),
                //backgroundColor: Colors.black,
              ),
              onPressed: createPage,
              child: const Text('Create Session', style: TextStyle(color: Colors.black,)),
            ),

            ElevatedButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 30),
                //backgroundColor: Colors.black,
              ),
              onPressed: offlinePage,
              child: const Text('Create Offline Session', style: TextStyle(color: Colors.black,)),
            ),

            ElevatedButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 30),
                //backgroundColor: Colors.black,
              ),
              onPressed: joinPage,
              child: const Text('Join Session', style: TextStyle(color: Colors.black,)),
            ),

          ],
        ),
      ),
    );
  }

  void joinPage(){
    Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EnterCode()),
      );
  }

  void createPage(){
    Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SelectorPageCreate()),
      );
  }

  void offlinePage(){
    Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OfflineSelect()),
      );
  }

}
