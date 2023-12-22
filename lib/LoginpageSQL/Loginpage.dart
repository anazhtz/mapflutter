
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:mapflutter/LoginpageSQL/Homepage.dart';
import 'package:mapflutter/LoginpageSQL/Registationpage.dart';
import 'package:mapflutter/LoginpageSQL/SplashScreenSQl.dart';

import 'AdminHomeUi.dart';
import 'HelperclasSQL.dart';

void main (){
  runApp(DevicePreview(builder: (BuildContext context)=>
      MaterialApp(useInheritedMediaQuery: true,debugShowCheckedModeBanner: false,
        home: Newlogin(),
      )
  )
  );
}


class Newlogin extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=>loginstate();

}
class loginstate extends State<Newlogin>{
  GlobalKey<FormState> formkey=GlobalKey();

  bool showpas=true;

  TextEditingController username_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();
  void logincheck(String email, String password) async {
    if (email == 'admin@gmail.com' && password == '123456') {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) =>Adminui()));
    } else {
      var data = await SQLHelper1.CheckLogin(email, password);
      if (data.isNotEmpty) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => Uihome(data: data,)));
        print('Login Success');
      } else if (data.isEmpty) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Logsign()));
        print('Login faild');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 310),
                    child: IconButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Logsign()));
                    }, icon: Icon(Icons.backspace_outlined)),
                  ),
                  const SizedBox(height: 50,),
                  const Image(image: NetworkImage("https://upload.wikimedia.org/wikipedia"
                      "/commons/thumb/f/f4/BMW_logo_%28gray%29.svg/1024px-BMW_logo_%"
                      "28gray%29.svg.png"),height: 200,width: 200,),
                  SizedBox(height: 50,),
                  Padding(padding: const EdgeInsets.only(left: 40,right: 40,),
                    child: TextFormField(
                        controller: username_controller,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.person),
                            hintText: "User name or email address",
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
                        validator: (uname){
                          if(uname!.isEmpty || ! uname.contains("@")|| !uname.contains(".")){
                            return "Please enter valid userName";
                          }
                          else{
                            return null;
                          }
                        }
                    ),
                  ),
                  Padding(padding: const EdgeInsets.only(left: 40,right: 40,top: 20),
                    child: TextFormField(
                        controller: password_controller,
                        obscureText: showpas,
                        obscuringCharacter: "*",
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(onPressed: (){
                              setState(() {
                                if(showpas){
                                  showpas=false;
                                }else{
                                  showpas=true;
                                }
                              });
                            },icon: Icon(showpas==true ? Icons.visibility_off : Icons.visibility),),
                            hintText: "Password",
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))
                        ),
                        validator: (upassword){
                          if(upassword!.isEmpty || upassword.length<6){
                            return "please enter valid password";
                          }else{
                            return null;
                          }
                        }
                    ),
                  ),
                  SizedBox(height: 30,),
                  ElevatedButton(onPressed: (){
                    final valid=formkey.currentState!.validate();
                    if (valid){
                      logincheck(username_controller.text, password_controller.text);
                    }else{
                      return null;
                    }
                  }, child: Text("Log in"),style: ElevatedButton.styleFrom
                    (fixedSize: const Size(290, 30),backgroundColor: Colors.red[900]),
                  ),
                  SizedBox(height: 30,),
                  TextButton(onPressed: (){}, child: Text("Forgotten Password?",
                    style: TextStyle(color: Colors.black),)),
                  SizedBox(height: 100,),
                  ElevatedButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Regis()));
                  }, child: Text("Create new account"),
                    style: ElevatedButton.styleFrom(fixedSize: const Size(290, 30), //fixed size box nde leghn cheyyan
                      backgroundColor: Colors.transparent,foregroundColor:
                        Colors.blue.shade900,elevation: 0,
                      side: const BorderSide(
                          width: 1.0,color: Colors.blue)),),
                  //SizedBox(height: 10,),

                ],
              ),
            ),
          ),

        ),
      ),

    );
  }

}