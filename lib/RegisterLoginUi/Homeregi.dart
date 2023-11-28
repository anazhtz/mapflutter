import 'package:flutter/material.dart';
import 'package:mapflutter/Sharedpreference/SharedPreference.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Loginpage1.dart';

void main(){
  runApp(MaterialApp(home: Homere(),));
}

class Homere extends StatefulWidget{
  @override
  State<Homere> createState() => _HomeState();
}

class _HomeState extends State<Homere> {

  late SharedPreferences data;
  late String username;

  @override
  void initState(){
    fetchname();
    super.initState();
  }
  void fetchname()async{
    data=await SharedPreferences.getInstance();
    setState(() {
      username=data.getString('username')!;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.teal,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Helloooo$username",
                style: TextStyle(fontSize: 25),),
              SizedBox(height: 50,),
              ElevatedButton(onPressed: (){
                data.setBool('newuser', true);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Loginpage()));
              } , child: Text("Logout")),
            ],
          ),
        ),
      ),
    );
  }
}