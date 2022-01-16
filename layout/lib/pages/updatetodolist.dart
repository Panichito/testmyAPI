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
            deleteTodo();
            Navigator.pop(context, 'delete');  // pop ออกจากหน้านี้เลย เหมือนการกด back <-- (ส่ง value ว่า 'delete' กลับไปด้วย)
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
                  print("--------HERE FOR UPDATING--------");
                  print('title: ${todo_title.text}');
                  print('detail: ${todo_detail.text}');
                  updateTodo();
                  final snackBar = SnackBar(     // https://docs.flutter.dev/cookbook/design/snackbars
                    content: const Text('อัพเดตรายการแล้ว'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
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

  Future updateTodo() async{
    // ngrok http 8000
    //var url = Uri.https('.ngrok.io', '/api/post-todolist');
    var url = Uri.http('192.168.42.114:8000', '/api/update-todolist/${_v1}');
    Map<String, String> header = {"Content-type":"application/json"};
    String jsondata = '{"title":"${todo_title.text}", "detail":"${todo_detail.text}"}';
    var response = await http.put(url, headers: header, body: jsondata);
    print("---update result---");
    print(response.body);
  }

  Future deleteTodo() async{
    var url = Uri.http('192.168.42.114:8000', '/api/delete-todolist/${_v1}');
    Map<String, String> header = {"Content-type":"application/json"};
    var response = await http.delete(url, headers: header);
    print("---delete result---");
    print(response.body);
  }
}