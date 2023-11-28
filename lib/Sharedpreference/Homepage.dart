import 'package:flutter/material.dart';
import 'package:mapflutter/Sharedpreference/SharedPreference.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main(){
  runApp(MaterialApp(home: Home(),));
}

class Home extends StatefulWidget{
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
     body: Padding(
       padding: const EdgeInsets.all(200),
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Text("Helloooo$username",
             style: TextStyle(fontSize: 25),),
           SizedBox(height: 50,),
           ElevatedButton(onPressed: (){
             data.setBool('newuser', true);
             Navigator.push(context, MaterialPageRoute(builder: (context)=>Loginpagee()));
           } , child: Text("Logout")),
         ],
       ),
     ),
   );
  }
}