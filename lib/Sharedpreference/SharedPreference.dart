import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Homepage.dart';
void main(){
  runApp(MaterialApp(home: Loginpagee(),));
}
class Loginpagee extends StatefulWidget{
  @override
  State<Loginpagee> createState() => _LoginpageeState();
}

class _LoginpageeState extends State<Loginpagee> {

  late SharedPreferences data;
//saving values on this SharedPreference data
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  late bool newuser;

  @override
  void initState(){
    checkUser();
    super.initState();
  }
  void checkUser()async{
   data = await SharedPreferences.getInstance();
   newuser =(data.getBool('newuser')?? true);
   if(newuser==false){
     Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
   }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.teal,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height:200,
                child: Center(child: Text("Hello again",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                )),
            SizedBox(height: 40,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25 ),
              child: Container(decoration: BoxDecoration(
                color: Colors.grey[200],borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white),
              ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: TextField(
                    controller: username,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Email or Username'
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Container(decoration: BoxDecoration(
                color: Colors.grey[200],borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white),
              ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: TextField(
                    controller: password,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password',
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Container(decoration: BoxDecoration(
              color: Colors.purple,border: Border.all(color: Colors.purple),
            ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(onPressed: (){
                    String uname=username.text;
                    String pwd=password.text;
                    if(uname !=''&& pwd !=''){
                      print("Login Success");
                      data.setString('username', uname);
                      data.setBool('newuser', false);
                      print(uname);
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
                    }
                  },
                      child: Text("Login",style: TextStyle(fontSize: 10,color: Colors.black),),),
                ],
              )
            ),

          ],
        ),
      ),

    );
  }
}