import 'package:flutter/material.dart';
import 'package:mapflutter/LoginpageSQL/Registationpage.dart';

import 'Loginpage.dart';

void main(){
  runApp(MaterialApp(home: Logsign()));
}
class Logsign extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 70),
                    child: Column(
                      children: [
                        Text("Helloo!",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
                        Center(child: Image(image: AssetImage("asset/log.png"),width:400,)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  TextButton(style: TextButton.styleFrom(
                    fixedSize: Size(320, 20),
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.purple,
                    textStyle: TextStyle(fontSize: 20),
                    shape: RoundedRectangleBorder(side: BorderSide(style: BorderStyle.solid),borderRadius: BorderRadius.circular(50)),
                  ),onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Newlogin()));
                  }, child: Text("LOGIN")),
                  SizedBox(
                    height: 10,
                  ),
                  TextButton(style: TextButton.styleFrom(
                    fixedSize: Size(320, 20),
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red[700],
                    textStyle: TextStyle(fontSize: 20),
                    shape: RoundedRectangleBorder(side: BorderSide(style: BorderStyle.solid),borderRadius: BorderRadius.circular(50)),
                  ),onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Regis()));
                  }, child: Text("SIGHN UP")),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
  
}