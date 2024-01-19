import 'dart:core';
import 'dart:math';
import 'dart:convert';
import 'package:fastclock2/firebase_options.dart';
import 'package:fastclock2/sessioncreate/startcode.dart';
import 'package:fastclock2/sessioncreate/timepagecreate.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'timepage.dart';

class SelectorPageCreate extends StatefulWidget{
  const SelectorPageCreate({Key? key}) : super(key: key);

  @override
 State<SelectorPageCreate> createState() => _SelectorPageCreateState();
}

class _SelectorPageCreateState extends State<SelectorPageCreate>{
  
  TimeOfDay _timeOfDay = const TimeOfDay(hour: 8, minute: 30);

  String key = "";

  int speed = 1;

  String sMinute = "";
  String sHour = "";

  @override
  void initState() {
    super.initState();
    sHour = _timeOfDay.hour.toString().padLeft(2, "0");
    sMinute = _timeOfDay.minute.toString().padLeft(2, "0");
    key = generateKey();
  }


  void _showTimePicker(){
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value){
      setState((){
          if(value == null){
            return;
          }
          _timeOfDay = value;

          sHour = _timeOfDay.hour.toString().padLeft(2, "0");
          sMinute = _timeOfDay.minute.toString().padLeft(2, "0");
          
      });
    });
  }

  void selectSpeed(int? selectedValue){
    if(selectedValue is int){
      setState((){
        speed = selectedValue;
      });
    }
  }

  void createPage(){

    CollectionReference collRef = FirebaseFirestore.instance.collection('session');
    collRef.add({
      'key': key,
      'hour': _timeOfDay.hour,
      'minute': _timeOfDay.minute,
      'start': false,
      'speed': speed,
    });

    Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => StartPage(time: _timeOfDay, speed: speed, code: key)),
          );
  }

  String generateKey(){
    var random = Random.secure();
    var values = List<int>.generate(3, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(

      appBar: AppBar(
        title: const Text('Create Selector Page'),
        backgroundColor: const Color(0xFFD8D8D8,),
      ),

      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(children: [
              IconButton(
              onPressed: _showTimePicker,
              icon: const Icon(
                Icons.access_time,
              ),
              iconSize: 100,
              //child: const Padding(
              //  padding: EdgeInsets.all(20.0),
              //  child: Text('PICK TIME', style: TextStyle(color: Colors.white, fontSize: 30)),
             // ),
              color: Colors.black,
            ),
            Text('Start Time: ' + sHour + ':' + sMinute),
            ],),
            
            Column(children: [
            const Icon(
              Icons.speed,
              size: 100,
              color: Colors.black,
            ),
          
            DropdownButton(
              items: const [
                DropdownMenuItem(child: Text("1:1"), value: 1),
                DropdownMenuItem(child: Text("2:1"), value: 2),
                DropdownMenuItem(child: Text("3:1"), value: 3),
                DropdownMenuItem(child: Text("4:1"), value: 4),
                DropdownMenuItem(child: Text("5:1"), value: 5),
                DropdownMenuItem(child: Text("6:1"), value: 6),
                DropdownMenuItem(child: Text("10:1"), value: 10),
                DropdownMenuItem(child: Text("12:1"), value: 12),
              ],
              value: speed,
              onChanged: selectSpeed,
              style: new TextStyle(
                color: Colors.black,
              ),
            ),
            
            ],),
            
            Column(children: [
              IconButton(
              onPressed: createPage,
              icon: const Icon(
                Icons.train_outlined,
              ),
              iconSize: 100,
              //child: const Padding(
              //  padding: EdgeInsets.all(20.0),
              //  child: Text('START', style: TextStyle(color: Colors.white, fontSize: 30)),
              //),
              color: Colors.black,
            ),

            Text("Create Session"),

            ],)
          ],
        ),
      ),
    );
  }
}