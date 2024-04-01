import 'dart:async';
import 'package:flutter/material.dart';
import '../clockdesign/clockface.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TimePage extends StatefulWidget{
   TimePage({Key? key, required this.timeOfDay, required this.speed}) : super(key: key);
   TimeOfDay timeOfDay;
   int speed;

  @override
  State<TimePage> createState() => _TimePageState(time: timeOfDay, hour: timeOfDay.hour, minute: timeOfDay.minute, speed: speed);
}

class _TimePageState extends State<TimePage> with WidgetsBindingObserver{
  _TimePageState({required this.time, required this.hour, required this.minute, required this.speed});

  int hour;
  int minute;
  TimeOfDay time;
  int speed;

  var state = AppLifecycleState;

  final storage = FlutterSecureStorage();

  var pausedTime = DateTime.now();
  var resumedTime = DateTime.now();


  /* DateTime bgTime = DateTime.now();
  DateTime startTime = DateTime.now(); */

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async{
    super.didChangeAppLifecycleState(state);
    switch(state){
      case AppLifecycleState.paused:
        pausedTime = DateTime.now();
        storage.write(key: 'pause', value: pausedTime.toString());
        print('paused');
        break;
      case AppLifecycleState.inactive:
        print('inactive');
        break;
      case AppLifecycleState.resumed:
        resumedTime = DateTime.now();
        String tempPause = await storage.read(key: 'pause') ?? '';
        var dt = DateTime.parse(tempPause);
        var difference = resumedTime.difference(dt);
        print("time added " + (difference.inSeconds/60).round().toString());
        addTime(0, 50);
        print('resumed');
        break;
      case AppLifecycleState.detached:
        print('detached');
        break;
      case AppLifecycleState.hidden:
        print("HIDDEN");
        break;
    }
  }

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

 
  /* @override
  void dispose(){
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  } */

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    //WidgetsBinding.instance.addObserver(this);
    startTimer();
  }

  @override
  void dispose(){
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /* @override
  void didChangeAppLifecycleState(AppLifecycleState state){
    super.didChangeAppLifecycleState(state);

    if(state == AppLifecycleState.inactive || state == AppLifecycleState.detached) return;

    final isBackground = state == AppLifecycleState.paused;

    if(isBackground){
      bgTime = DateTime.now();
      print("IN BACKGROUND!");
    }
    else{
      print("IN FOREGROUND");
    }
  } */

 @override
  Widget build(BuildContext context) {
    hour = time.hour;
    minute = time.minute;

    String sMinute = minute.toString().padLeft(2, "0");
    String sHour = hour.toString().padLeft(2, "0");

    //didChangeAppLifecycleState(state as AppLifecycleState);

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
