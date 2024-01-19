import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastclock2/sessioncreate/timepagecreate.dart';
import 'package:flutter/material.dart';
import 'dart:core';

class StartPage extends StatefulWidget {
  StartPage({Key? key, required this.time, required this.speed, required this.code}) : super(key: key);

  TimeOfDay time;
  int speed;
  String code;

  @override
  State<StartPage> createState() => StartPageState(time: time, speed: speed, code: code);
}

class StartPageState extends State<StartPage> {
  StartPageState({required this.time, required this.speed, required this.code});

  TimeOfDay time;
  int speed;
  String code;
  int users = 0;


  @override
  void initState(){
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    getUsers();
    return Scaffold (
      appBar: AppBar(
        title: const Text('Key & Start'),
        backgroundColor: const Color(0xFFD8D8D8,),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Key: ' + code, style: TextStyle(color: Colors.black, fontSize: 50)),

            Text('Users connected: $users', style: TextStyle(color: Colors.black, fontSize: 30)),

            //Text('Users connected: $users', style: TextStyle(color: Colors.black, fontSize: 30)),
            ElevatedButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 30),
                //backgroundColor: Colors.black,
              ),
              onPressed: createPage,
              child: const Text('Start Session!', style: TextStyle(color: Colors.black,)),
            ),
          ],
        ),
      ),
    );
  }



  void getUsers() async{
    var info = await FirebaseFirestore.instance.collection('session').where('key', isEqualTo: code).get();
    var data = info.docs.first.data();
    if(mounted){
      setState((){
      users = data['user'];
    });
    }  
  }

  void createPage(){
    Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TimePageCreate(timeOfDay: time, speed: speed,)),
      );
  }

}
