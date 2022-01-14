import 'package:flutter/material.dart';
import 'package:layout/pages/addtodolist.dart';
// http method packages
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';  // JSON Decode

import 'package:layout/pages/updatetodolist.dart';

class Todolist extends StatefulWidget {
  //const Todolist({ Key? key }) : super(key: key);

  @override
  _TodolistState createState() => _TodolistState();
}

class _TodolistState extends State<Todolist> {
  List todolistitems = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTodolist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Go to Add Page');
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddPage()));
        },
        child: Icon(Icons.add, color: Colors.white,),
        backgroundColor: Colors.orange[800],
      ),
      appBar: AppBar(title: Text('แสดงรายการทั้งหมด', style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic),), backgroundColor: Colors.orange[800],),
      body: todolistCreate(),
    );
  }

  Widget todolistCreate() {
    return ListView.builder(itemCount: todolistitems.length, itemBuilder: (context, index) {
      return Card(
        child: ListTile(
        title: Text("Title = ${todolistitems[index]['title']}"),
        onTap: () {
          print('Go to Update Page');
          Navigator.push(context, MaterialPageRoute(builder: (context) => UpdatePage(todolistitems[index]['id'], todolistitems[index]['title'], todolistitems[index]['detail'])));
          getTodolist();  // ให้มันกดไปดูสักอันเพื่อ refresh
        },));
    });
  }

  Future<void> getTodolist() async {
    List alltodo = [];
    var url = Uri.http('192.168.1.42:8000', '/api/all-todolist/');  // ดูเลข ip จาก cmd ipconfig IPv4 Address
    var response = await http.get(url);
    //var result = json.decode(response.body);   // มันขึ้นเป็นตัวไส้เดือน ถ้าเป็นภาษาไทยใช้ utf8
    var result = utf8.decode(response.bodyBytes);   
    print(result);
    setState(() {
      //todolistitems = result;
      todolistitems = jsonDecode(result);
    });
  }
}