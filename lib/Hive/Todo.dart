
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();//hive initialization cheydhonn check cheyyunnadh
  //hive Initialization
  await Hive.initFlutter();//mele
  await Hive.openBox("task_box");// create database

  runApp(MaterialApp(home:Todo() ,debugShowCheckedModeBanner: false,));
}

class Todo extends StatefulWidget{
  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  //to store task from hive
  List<Map<String,dynamic>>task=[];

  final tbox=Hive.box('task_box');

  //create new data
  Future<void>createTask(Map<String,dynamic>task)async{
    await tbox.add(task);
    loadTask();
  }
  @override
  void initState() {
    super.initState();
    loadTask();
  }
  //read all the data
  void loadTask() {
    final data =tbox.keys.map((id){
      final value= tbox.get(id);
      return {
        'key': id , 'name' : value['name'], 'details' : value['details']
      };
    }).toList();
    setState(() {
      task=data.reversed.toList();
    });
  }
  Future<void> updateTask(int key, Map<String, dynamic> uptask) async {
    await tbox.put(key, uptask);
    loadTask();
  }
  Future<void>deleteform(int key)async{
    await tbox.delete(key);
    loadTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.teal,
      appBar: AppBar(title: Text("ToDo"),backgroundColor: Colors.red,),
      body:task.isEmpty ? Center(child: Text("No data"),): ListView.builder(
        itemCount: task.length,
          itemBuilder: (context,index){
        return Card(
          child: ListTile(
            title:Text(task[index]['name']) ,
            subtitle:Text(task[index]['details']) ,
            trailing: SizedBox(
              width: 100,
              child: Row(
                children: [
                  IconButton(onPressed: (){
                    showform(context, task[index]["key"]);
                  }, icon: Icon(Icons.edit)),
                  IconButton(onPressed: (){
                    deleteform(task[index]["key"]);
                  }, icon: Icon(Icons.delete)),
                ],
              ),
            ),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>showform(context,null),
        child: Icon(Icons.add),
      ),
    );
  }
  final title=TextEditingController();

  final note=TextEditingController();

  void showform( BuildContext context, int?id) async{
    if(id != null){
      final ex_task=
          task.firstWhere((element) => element['key']==id);
      title.text=ex_task['name'];
      note.text=ex_task['details'];

    }
    showModalBottomSheet(context: context,
        elevation: 3,
        builder: (context)=>Container(
            padding: EdgeInsets.only(
                left: 10,
                right: 10,
                top: 10,
                bottom: MediaQuery.of(context).viewInsets.bottom+120),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  controller: title,
                  decoration: const InputDecoration(
                      hintText: "Title",border: OutlineInputBorder()),
                ),
                SizedBox(height: 10,),
                TextField(
                  controller: note,
                  decoration:const InputDecoration(
                      hintText: "Enter note",border: OutlineInputBorder()),
                ),
                SizedBox(height: 10,),
                ElevatedButton(onPressed: (){
                  if (id == null){
                    createTask({'name': title.text , 'details': note.text});
                  }
                  if(id != null){
                    updateTask(id ,{'name': title.text, 'details':note.text});
                  }
                  title.text="";
                  note.text="";
                  Navigator.of(context).pop();
                }, child: Text(id==null?"add":"update")),
              ],
            ),
            ));


    }
}