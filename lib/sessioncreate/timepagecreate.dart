import 'dart:async';
import 'package:flutter/material.dart';
import '../clockdesign/clockface.dart';

class TimePageCreate extends StatefulWidget{
   TimePageCreate({Key? key, required this.timeOfDay, required this.speed}) : super(key: key);
   TimeOfDay timeOfDay;
   int speed;

  @override
  State<TimePageCreate> createState() => _TimePageState(time: timeOfDay, hour: timeOfDay.hour, minute: timeOfDay.minute, speed: speed);
}

class _TimePageState extends State<TimePageCreate> with WidgetsBindingObserver{
  _TimePageState({required this.time, required this.hour, required this.minute, required this.speed});

  int hour;
  int minute;
  TimeOfDay time;
  int speed;
  

  DateTime bgTime = DateTime.now();
  int diff = 0; 

   TimeOfDay addTime(int hour, int minute){
    if (minute == 0) {
      return time;
    } else {
      int mofd = this.hour * 60 + this.minute;
      int newMofd = ((minute % 1440) + mofd + 1440) % 1440;
      if (mofd == newMofd) {
        return time;
      } else {
        int newHour = newMofd ~/ 60;
        int newMinute = newMofd % 60;
        return TimeOfDay(hour: newHour, minute: newMinute);
      }
    }
  } 


  void startTimer(){
    double test = 0;
    Timer.periodic(Duration(seconds: 1), (_) { 
      if(mounted){
        test += speed/60;
        test = double.parse(test.toStringAsFixed(3));
        //print("new val: ${test}");
        if(test >= 1){
          setState(() => time = addTime(0, test.toInt()));
          test = 0;
        }
      }


    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state){
    super.didChangeAppLifecycleState(state);

    final isBackground = state == AppLifecycleState.paused;
    final isForeground = state == AppLifecycleState.resumed;

    if(isBackground){
      bgTime = DateTime.now();
      print("IN BACKGROUND!");
    }
    if(isForeground){
      diff = DateTime.now().difference(bgTime).inSeconds;
      var converted = ((diff / 60) * speed).round();
      setState(() => time = addTime(0, converted));
      print("IN FOREGROUND, gone for ${diff} seconds, added ${converted} minutes at speed ${speed}");
    }
  } 

 
   @override
  void dispose(){
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  } 

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    startTimer();
  }

   

 @override
  Widget build(BuildContext context) {
    hour = time.hour;
    minute = time.minute;

    String sMinute = minute.toString().padLeft(2, "0");
    String sHour = hour.toString().padLeft(2, "0");

    return Scaffold(
      appBar: AppBar(
        title: const Text('Operation Session Time'),
        backgroundColor: const Color(0xFFD8D8D8,),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

          //Text("Current Time"),

           Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                sHour + ":" + sMinute,
                style: const TextStyle(fontSize: 100),
              ),
              ClockFace(hour: hour, minute: minute),
            ],
           ),
          ],
        ),
      ),
    );
  }
}
