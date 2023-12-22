import 'package:flutter/material.dart';
import 'package:mapflutter/LoginpageSQL/HelperclasSQL.dart';
import 'package:mapflutter/LoginpageSQL/Loginpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../RegisterLoginUi/Loginpage1.dart';

void main(){
  runApp(MaterialApp(home: Regis(),));
}
class Regis extends StatefulWidget{
  @override
  State<Regis> createState() => _RegisState();
}

class _RegisState extends State<Regis> {
  var homekey= GlobalKey<FormState>();
  final name= TextEditingController();
  final username= TextEditingController();
  final email=TextEditingController();
  final password= TextEditingController();
  final ccpassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Future<void> Addnewuser(String name , String email , String password) async {
      var id= await SQLHelper1.AddNewUser(name, email, password);
      if (id != null){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Newlogin()));
      }
    }
    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Please Register"),backgroundColor: Colors.blue[800],),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: homekey,
              child: Column(
                children: [
                  SizedBox(height: 90,),
                  Text("Hellooo!",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 30,),
                        Padding(
                          padding: const EdgeInsets.only(left: 50,right: 50),
                          child: TextFormField(
                            validator: (name){
                              if(name!.isEmpty){
                                return "Name is requierd";
                              }else{
                                return null;
                              }
                            },
                            controller: name,
                            decoration: InputDecoration(
                              labelText: "Name",
                              fillColor: Colors.white,
                              filled: true,
                              disabledBorder:OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.red, width: 2.0),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              enabledBorder:OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.black, width: 2.0),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                          )
                        ),
                        SizedBox(height: 30,),
                        Padding(
                            padding: const EdgeInsets.only(left: 50,right: 50),
                            child: TextFormField(
                              controller: username,
                              decoration: InputDecoration(
                                labelText: "User name",
                                fillColor: Colors.white,
                                filled: true,
                                enabledBorder:OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.black, width: 2.0),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                              ),
                            )
                        ),
                        SizedBox(height: 30,),
                        Padding(
                            padding: const EdgeInsets.only(left: 50,right: 50),
                            child: TextFormField(
                              validator: (email){
                                if(email!.isEmpty &&
                                    email.contains("@") &&
                                    email.contains(".")){
                                  return "Email requierd";
                                }else{
                                  return null;
                                }
                              },
                              controller: email,
                              decoration: InputDecoration(
                                labelText: "Email adress",
                                fillColor: Colors.white,
                                filled: true,
                                enabledBorder:OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.black, width: 2.0),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                              ),
                            )
                        ),
                        SizedBox(height: 30,),
                        Padding(
                            padding: const EdgeInsets.only(left: 50,right: 50),
                            child: TextFormField(
                              validator: (password){
                                if(password!.isEmpty || password.length<6){
                                  return "Password must should be grater than 6";
                                }else{
                                  return null;
                                }
                              },
                              controller: password,
                              decoration: InputDecoration(
                                labelText: "Password",
                                fillColor: Colors.white,
                                filled: true,
                                enabledBorder:OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.black, width: 2.0),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                              ),
                            )
                        ),
                        SizedBox(height: 30,),
                        Padding(
                            padding: const EdgeInsets.only(left: 50,right: 50),
                            child: TextFormField(
                              validator: (cpassword){
                                if(cpassword!.isEmpty || cpassword.length <6){
                                  return "password not match";
                                }
                                else if(
                                  password.text != ccpassword.text){
                                  return "password not match";
                                }
                                else{
                                  return null;
                                }
                              },
                              controller: ccpassword,
                              decoration: InputDecoration(
                                labelText: "Confirm password",
                                fillColor: Colors.white,
                                filled: true,
                                enabledBorder:OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.black, width: 2.0),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                              ),
                            )
                        ),
                        SizedBox(height: 20,),
                        ElevatedButton(onPressed: ()async{
                          final valid1= homekey.currentState!.validate();
                          if(valid1){
                            String uname= email.text;
                            String cname = name.text;
                            var data = await SQLHelper1.userFound(cname, uname);
                            if(data.isNotEmpty){
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("User already exist"))
                              );
                            }else {
                              Addnewuser(name.text, email.text, password.text);
                            }
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  action:  SnackBarAction(label: 'UNDo', onPressed: (){}),
                                    content: Text("Invalid login details"))
                            );
                          }
                        }, child: Text("Register"),style: ElevatedButton.styleFrom(fixedSize: Size(200, 20)),),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}