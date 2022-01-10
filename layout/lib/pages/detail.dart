import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  //const DetailPage({ Key? key }) : super(key: key);
  final v1, v2, v3, v4;
  DetailPage(this.v1, this.v2, this.v3, this.v4);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  var _v1, _v2, _v3, _v4;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _v1 = widget.v1;
    _v2 = widget.v2;
    _v3 = widget.v3;
    _v4 = widget.v4;
  }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("รายละเอียด", style: TextStyle(fontStyle: FontStyle.italic)), backgroundColor: Colors.black,),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Text(_v1, style: TextStyle(fontSize: 29)),
            Text(_v2, style: TextStyle(fontSize: 17, color: Colors.grey[800], fontStyle: FontStyle.italic)),
            SizedBox(height: 20),
            Image.network(_v3, width: 200, height: 200),
            SizedBox(height: 20),
            Text(_v4)
          ],
        ),
      ),
    );
  }
}