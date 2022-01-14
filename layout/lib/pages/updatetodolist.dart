import 'package:flutter/material.dart';
// http method packages
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';   // JSON decode

class UpdatePage extends StatefulWidget {
  final v1, v2, v3;
  const UpdatePage(this.v1, this.v2, this.v3);

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  var _v1, _v2, _v3;
  TextEditingController todo_title =TextEditingController();
  TextEditingController todo_detail =TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _v1 = widget.v1;  // id
    _v2 = widget.v2;  // title
    _v3 = widget.v3;  // detail
    todo_title.text = _v2;
    todo_detail.text = _v3;
  }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แก้ไขข้อมูล', style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic),),
        backgroundColor: Colors.orange[800],
        actions: [
          IconButton(onPressed: () {
            print("Delete ID = $_v1");
          }, icon: Icon(Icons.delete)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.5),
        child: ListView(
          children: [
            // ช่องกรอกข้อมูล title
            TextField(
              controller: todo_title,
              decoration: InputDecoration(
                labelText: 'หัวข้อ',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            // ช่องกรอก detail
            TextField(
              minLines: 4,
              maxLines: 8,
              controller: todo_detail,
              decoration: InputDecoration(
                labelText: 'รายละเอียด',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 30),
            // ปุ่มกดเพิ่มข้อมูล
            Padding(
              padding: const EdgeInsets.all(80),
              child: ElevatedButton(
                onPressed: () {
                  print("--------OK, WE'RE HERE--------");
                  print('title: ${todo_title.text}');
                  print('detail: ${todo_detail.text}');
                  postTodo();
                  setState(() {   // กดส่งแล้ว clear ข้อมูล
                    todo_title.clear();
                    todo_detail.clear();
                  });
                },
                child: Text("แก้ไข", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red[400]),
                  padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(50, 20, 50, 20)),
                  textStyle: MaterialStateProperty.all(TextStyle(fontSize: 20)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future postTodo() async{
    // ngrok http 8000
    var url = Uri.https('.ngrok.io', '/api/post-todolist');
    //var url = Uri.http('192.168.1.42:8000', '/api/post-todolist');
    Map<String, String> header = {"Content-type":"application/json"};
    String jsondata = '{"title":"${todo_title.text}", "detail":"${todo_detail.text}"}';
    var response = await http.post(url, headers: header, body: jsondata);
    print("---result---");
    print(response.body);
  }
}