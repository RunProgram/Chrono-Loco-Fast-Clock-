import 'package:flutter/material.dart';
import 'dart:math';

class HourPointer extends StatelessWidget{
  HourPointer({Key? key, required this.hour}) : super(key:key);

  int hour;

  @override
  Widget build(BuildContext context){
    final height = MediaQuery.of(context).size.height;
    //final width = MediaQuery.of(context).size.width;
    final angle = (-pi * (hour / -12)) * 2;
    return RotatedBox(
      quarterTurns: 2,
      child: Transform.rotate(
        angle: angle,
        child: Transform.translate(
          offset: Offset(0, 20),
          child: Center(
            child: Container(
              height: height * 0.06,
              width: 4,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
              ),
            ),
          ),
        ),
      ),
    );
  }
}