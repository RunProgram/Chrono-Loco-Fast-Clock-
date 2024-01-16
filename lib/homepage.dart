import 'dart:core';

import 'package:flutter/material.dart';
import 'timepage.dart';

class HomePage extends StatefulWidget{
  const HomePage({Key? key}) : super(key: key);

  @override
 State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

  TimeOfDay _timeOfDay = const TimeOfDay(hour: 8, minute: 30);

  int speed = 1;

  String sMinute = "";
  String sHour = "";

  @override
  void initState(){
    super.initState();
    sHour = _timeOfDay.hour.toString().padLeft(2, "0");
    sMinute = _timeOfDay.minute.toString().padLeft(2, "0");
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

  void nextPage(){
    Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TimePage(timeOfDay: _timeOfDay, speed: speed)),
          );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
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
                DropdownMenuItem(child: Text("5:1"), value: 5),
                DropdownMenuItem(child: Text("10:1"), value: 10),
                DropdownMenuItem(child: Text("20:1"), value: 20),
                DropdownMenuItem(child: Text("30:1"), value: 30),
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
              onPressed: nextPage,
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

            Text("Start Clock"),

            ],)
          ],
        ),
      ),
    );
  }
}