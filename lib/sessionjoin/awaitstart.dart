import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastclock2/sessionjoin/timepage.dart';
import 'package:flutter/material.dart';
import 'dart:core';

class AwaitStart extends StatefulWidget{
  AwaitStart ({Key? key, required this.time, required this.speed, required this.code}): super(key: key);

  TimeOfDay time;
  int speed;
  String code;

  @override
  State<AwaitStart> createState () => AwaitStartState(time: time, speed: speed, code: code);
}

class AwaitStartState extends State<AwaitStart>{
  AwaitStartState({required this.time, required this.speed, required this.code});
  TimeOfDay time;
  int speed;
  int users = 0;
  String code;
  bool moved = false;

  @override
  void initState(){
    super.initState();
    moved = false;
  }

  @override
  Widget build(BuildContext context) {
    getUsers();
    checkStart();
  
    return Scaffold(
      appBar: AppBar(
        title: const Text('Waiting...'),
        backgroundColor: const Color(0xFFD8D8D8,),
      ),
      body: Center(
        child: Column(children: [
          Text('Waiting for creator to start session...', style: TextStyle(color: Colors.black, fontSize: 20)),
          Text('Users connected: $users', style: TextStyle(color: Colors.black, fontSize: 30)),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
        )
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

  void checkStart() async{
    var info = await FirebaseFirestore.instance.collection('session').where('key', isEqualTo: code).get();
    var data = info.docs.first.data();
      if(data['start'] == true){
        if(mounted && !moved){
          moved = true;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TimePage(timeOfDay: time, speed: speed)),
      );
        }
    }
  }
}