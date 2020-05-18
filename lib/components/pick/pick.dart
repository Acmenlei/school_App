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
      appBar: AppBar(title: Text('失物招领'), centerTitle: true,),
      body: getPickContent(),
    );
  }
  // 1. 失物招领模块
    Widget getPickContent() {
    return Stack(
      children: <Widget>[
        ListView( children: <Widget>[ Column( children: pickContent())]),
        Positioned(
            bottom: 30,
            right: 30,
            child: FloatingActionButton(
                onPressed: () => print('发布信息'),
                backgroundColor: Colors.yellow,
                child: Icon(Icons.add, color: Colors.black54))),
      ],
    );
  }
  // 2. 失物招领内容
  List<Widget> pickContent() {
    return List.generate(30, (int index) {
              return Text("我是第$index");
        });
  }
}