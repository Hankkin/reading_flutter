import 'package:flutter/material.dart';

class GankPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Reading',
      theme: new ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: new Scaffold(body: new Center(child: new Text('干货'),),),
    );
  }
  
}