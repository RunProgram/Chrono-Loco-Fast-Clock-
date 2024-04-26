
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastclock2/sessionjoin/awaitstart.dart';
import 'package:flutter/material.dart';
import 'dart:core';

class EnterCode extends StatefulWidget {

  const EnterCode({Key? key}) : super(key:key);

  @override
  State<EnterCode> createState() => EnterCodeState();
}

class EnterCodeState extends State<EnterCode> {

  TimeOfDay time = TimeOfDay(hour: 8, minute: 30);
  int speed = 1;
  bool wrong = false;

  var keyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Key & Start'),
        backgroundColor: const Color(0xFFD8D8D8,),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Enter key: ', style: TextStyle(color: Colors.black, fontSize: 50)),
            Container(
              width: MediaQuery.of(context).size.width * 0.6,
              child: TextFormField(
              controller: keyController,
              decoration: InputDecoration(
                hintText: 'Key',
                contentPadding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
            ),
            ),

            wrong ? Text('Invalid key! Try again.', style: TextStyle(color: Colors.red, fontSize: 25)) : SizedBox(),

            ElevatedButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 30),
                //backgroundColor: Colors.black,
              ),
              onPressed: () async {
                if(await checkKey(keyController.text)){
                  setState((){
                    wrong = false;
                  });

                  var info = await FirebaseFirestore.instance.collection('session').where('key', isEqualTo: keyController.text).get();

                  var data = info.docs.first.data();
                  
                  int tempHour = data['hour'];
                  int tempMinute = data['minute'];
                  int tempSpeed = data['speed'];
                  int tempUser = data['user'];

                  var docId;

                  info.docs.forEach((element){
                    docId = element.id;
                  });

                  await FirebaseFirestore.instance.collection('session').doc(docId).update({'user': tempUser+1});

                  time = TimeOfDay(hour: tempHour, minute: tempMinute);
                  speed = tempSpeed;

                  nextPage();
                }
                else{
                  setState((){
                    wrong = true;
                    print("wrong");
                  });
                }
              },
              child: const Text('Join Session!', style: TextStyle(color: Colors.black,)),
            ),

          ],
        ),
      ),
    );
  }


  void nextPage() async{
  
    Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AwaitStart(time: time, speed: speed, code: keyController.text)),
      );
  }

  Future<bool> checkKey(String code) async{
    ///bool test = false;
    var test = await FirebaseFirestore.instance.collection('session').where('key', isEqualTo: code).get();
    return test.docs.isNotEmpty;
  }
}
