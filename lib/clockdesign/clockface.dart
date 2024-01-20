import 'package:fastclock2/clockdesign/analogcircle.dart';
import 'package:fastclock2/clockdesign/hourpointer.dart';
import 'package:fastclock2/clockdesign/minutepointer.dart';
import 'package:flutter/material.dart';

class ClockFace extends StatefulWidget {
  ClockFace({Key? key, required this.hour, required this.minute}) : super(key: key);

  final int hour;
  final int minute;

  @override
  ClockFaceState createState() => ClockFaceState();
}

class ClockFaceState extends State<ClockFace> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: Stream.periodic(
        Duration(seconds: 1),
        (i) => i, // This will emit a new value every second
      ),
      builder: (context, snapshot) {
        // Use the initial values from the constructor
        final hour = widget.hour;
        final minute = widget.minute;

        return SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  const AnalogCircle(),
                  HourPointer(hour: hour),
                  MinutePointer(minute: minute),
                  Container(
                    height: 16,
                    width: 16,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}