import 'package:flutter/material.dart';
//import 'package:layout/pages/addtodolist.dart';
//import 'package:layout/pages/home.dart';
import 'package:layout/pages/showtodolist.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp( 
      debugShowCheckedModeBanner: false,
      title: "DogDogApp",
      //home: HomePage(), 
      //home: AddPage(),  // ลองทำโปรเจ็ค todolist แต่ขก. สร้างใหม่
      home: Todolist(),
    );
  }
}
