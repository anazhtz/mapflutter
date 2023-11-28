import 'package:flutter/material.dart';
import 'package:mapflutter/RegisterLoginUi/Homeregi.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Registration page.dart';

void main(){
  runApp(MaterialApp(home: Loginpage(),));
}

class Loginpage extends StatefulWidget{
  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {

  late SharedPreferences data;

  TextEditingController username_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();

  late bool newuser;
  late String uname;
  late String pswd;
  late String name;


  @override
  void initState(){
    checkUser();
    getvalue();
  }
  void getvalue()async{
    data=await SharedPreferences.getInstance();
    setState(() {
      name=data.getString('name')!;
      uname=data.getString('username')!;
      pswd=data.getString('password')!;
    });

  }
  void checkUser()async{
    data = await SharedPreferences.getInstance();
    newuser =(data.getBool('newuser')?? true);
    if(newuser==false){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Homere()));
    }
  }
  @override
  void dispose() {
    username_controller.dispose();
    password_controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.teal[200],
     body: SafeArea(
       child: Center(
         child: SingleChildScrollView(
           child: Column(
             children: [
               Image(
                   width:200,
                   image: AssetImage ("asset/logo.png")),
               SizedBox(height: 20,),
               TextFormField(
                 controller: username_controller,
                 decoration: InputDecoration(
                   hintText:"Mobile number or Email",
                     border:OutlineInputBorder(borderRadius:BorderRadius.circular(30)
                 ),
               )),
               SizedBox(height:20,),
               TextFormField(
                 controller: password_controller,
                 decoration: InputDecoration(
                   hintText: 'Password',
                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))
                 ),
               ),
               SizedBox(height: 10,),
               ElevatedButton(onPressed: (){
                 String username=username_controller.text;
                 String password=password_controller.text;
                 if (username!='' && password!='' && username == uname && password==pswd){
                   print('Successfull');
                   data.setBool('newuser', false);
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>Homere()));
                 }
               }, child: Text("Log-in"),),
               TextButton(onPressed: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>Registerr()));
               }, child: Text("Register new user"),)

             ],
           ),
         ),
       ),
     ),
    );
  }
}