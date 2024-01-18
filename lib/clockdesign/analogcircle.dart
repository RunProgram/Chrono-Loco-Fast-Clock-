import 'package:flutter/material.dart';

class AnalogCircle extends StatelessWidget {
  const AnalogCircle({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context){
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.5,
      width: width * 0.7,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        shape: BoxShape.circle,
        boxShadow : const [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0,5),
            blurRadius: 15,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(6.0),
        child: Container(
          decoration: BoxDecoration(
          color: Colors.blueGrey[800],
          shape: BoxShape.circle,
          ),
            child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Container(
            decoration: const BoxDecoration(
            color: Colors.black54,
            shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}