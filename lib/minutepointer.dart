import 'package:flutter/material.dart';
import 'dart:math';

class MinutePointer extends StatelessWidget{
  MinutePointer({Key? key, required this.minute}) : super(key:key);

  int minute;

  @override
  Widget build(BuildContext context){
    final height = MediaQuery.of(context).size.height;
    //final width = MediaQuery.of(context).size.width;
    final angle = (-pi * (minute / -60)) * 2;
    return RotatedBox(
      quarterTurns: 2,
      child: Transform.rotate(
        angle: angle,
        child: Transform.translate(
          offset: Offset(0, 20),
          child: Center(
            child: Container(
              height: height * 0.11,
              width: 4,
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(32),
              ),
            ),
          ),
        ),
      ),
    );
  }
}