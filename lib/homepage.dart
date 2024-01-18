import 'package:fastclock2/sessioncreate/selectorpagecreate.dart';
import 'package:fastclock2/sessionjoin/selectorpage.dart';
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
            MaterialPageRoute(builder: (context) => SelectorPage()),
      );
  }

  void createPage(){
    Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SelectorPageCreate()),
      );
  }

}
