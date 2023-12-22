import 'package:flutter/material.dart';
import 'package:mapflutter/LoginpageSQL/HelperclasSQL.dart';



class Adminui extends StatefulWidget{
  @override
  State<Adminui> createState() => _AdminuiState();
}

class _AdminuiState extends State<Adminui> {
  var data;

  void delete(int id)async{
    await SQLHelper1.deleteuser(id);
  } 
@override
  void initState() {
    Refresh();
    super.initState();
  }
  void Refresh()async{
    var mydata= await SQLHelper1.getall();
    setState(() {
      data=mydata;
    });
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(itemCount: data.lenght,
          itemBuilder: (context,int index){
        return Card(
          child: ListTile(
            title: Text('${data[index]['name']}'),
            trailing: IconButton(onPressed: (){
              delete(data[index]['id']);
            }, icon: Icon(Icons.delete)),
          ),
        );
      }
      )
    );
  }
}