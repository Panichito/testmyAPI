import 'package:flutter/material.dart';
// http method packages
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';   // JSON decode

class AddPage extends StatefulWidget {
  const AddPage({ Key? key }) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController todo_title =TextEditingController();
  TextEditingController todo_detail =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('หน้าเพิ่มรายการใหม่', style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic),), backgroundColor: Colors.orange[800],),
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
                child: Text("เพิ่ม", style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.bold, fontSize: 15)),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.amber),
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
    //var url = Uri.https('19ce-2001-fb1-b3-56f8-dc33-56a1-8efe-3b15.ngrok.io', '/api/post-todolist');
    var url = Uri.http('192.168.1.42:8000', '/api/post-todolist');
    Map<String, String> header = {"Content-type":"application/json"};
    String jsondata = '{"title":"${todo_title.text}", "detail":"${todo_detail.text}"}';
    var response = await http.post(url, headers: header, body: jsondata);
    print("---result---");
    print(response.body);
  }
}