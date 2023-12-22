import 'package:flutter/material.dart';
import 'package:mapflutter/LoginpageSQL/Loginpage.dart';
import 'package:mapflutter/Sharedpreference/Homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Uihome extends StatelessWidget{
  final data;

  const Uihome({Key ? key,required this.data}): super(key: key);
  @override
  Widget build(BuildContext context) {
    var name = data[0]["name"];
    return Scaffold(backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: NetworkImage("https://upload.wikimedia.org/wikipedia"
                  "/commons/thumb/f/f4/BMW_logo_%28gray%29.svg/1024px-BMW_logo_%"
                  "28gray%29.svg.png"),width: 150,),
              SizedBox(height: 30,),
              Text("Helloooo$name",
                style: TextStyle(fontSize: 25),),
              SizedBox(height: 50,),
              ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Newlogin()));
              } , child: Text("Logout")),
            ],
          ),
        ),
      ),
    );
  }
}