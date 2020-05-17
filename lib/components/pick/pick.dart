import 'package:flutter/material.dart';

class PickPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Pickcontent();
  }
}

class Pickcontent extends State<PickPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('失物招领'),),
      body: Container(child: Text('失物招领')),
    );
  }
}