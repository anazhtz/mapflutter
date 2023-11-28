import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Loginpage1.dart';

void main(){
  runApp(MaterialApp(home: Registerr(),));
}

class Registerr extends StatefulWidget{
  @override
  State<Registerr> createState() => _RegisterrState();
}

class _RegisterrState extends State<Registerr> {

final name= TextEditingController();
final username= TextEditingController();
final password= TextEditingController();

late SharedPreferences logindataa;

@override
  void dispose() {
   name.dispose();
   username.dispose();
   password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(backgroundColor: Colors.teal,
    title: Text("Register now"),),
    body: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.only(right: 250),
            child: Text('please enter your name'),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(left: 50,right: 50),
            child: TextFormField(
              controller: name,
              decoration: InputDecoration(
                hintText: 'name',
                border: OutlineInputBorder(borderRadius: BorderRadius.vertical(top: Radius.zero,bottom: Radius.zero)),
              ),
            ),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(right: 330),
            child: Text('user name'),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(left: 50,right: 50),
            child: TextFormField(
              controller: username,
              decoration: InputDecoration(
                hintText: 'User name',
                border: OutlineInputBorder(borderRadius: BorderRadius.vertical(top: Radius.zero,bottom: Radius.zero)),
              ),
            ),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(right: 230),
            child: Text('please enter your password'),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(left: 50,right: 50),
            child: TextFormField(
              controller: password,
              decoration: InputDecoration(
                hintText: 'Password',
                border: OutlineInputBorder(borderRadius: BorderRadius.vertical(top: Radius.zero,bottom: Radius.zero)),
              ),
            ),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(right: 180),
            child: Text('please enter your Confirm passowrd'),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(left: 50,right: 50),
            child: TextFormField(
              controller: password,
              decoration: InputDecoration(
                hintText: 'Confirm password',
                border: OutlineInputBorder(borderRadius: BorderRadius.vertical(top: Radius.zero,bottom: Radius.zero)),
              ),
            ),
          ),
          SizedBox(height: 50,),
          ElevatedButton(onPressed: (){
            registerrr();
          }, child: Text("Done"),style: ElevatedButton.styleFrom(fixedSize: const Size(290, 30), //fixed size box nde leghn cheyyan
              backgroundColor: Colors.white30,foregroundColor: Colors.blue.shade900,elevation: 0,
              side: const BorderSide(width: 1.0,color: Colors.blue))),
        ],
      ),
    ),
  );
  }
void registerrr()async{
  logindataa=await SharedPreferences.getInstance();
  String nam = name.text;
  String usnam= username.text;
  String pass= password.text;

  if(username!=''&&password!=''){
    logindataa.setString('name', nam);
    logindataa.setString('username', usnam);
    logindataa.setString('password', pass);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Loginpage()));
  }
}
}
