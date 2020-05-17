import 'package:flutter/material.dart';

class LosePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Losecontent();
  }
}

class Losecontent extends State<LosePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('寻物启示'),),
      body: Container(child: Text('寻物启事')),
    );
  }
}