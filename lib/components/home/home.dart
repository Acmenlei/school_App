import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Homecontent();
  }
}

class Homecontent extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('江西工业工程职业技术学院寻物平台'),centerTitle: true,),
      body: Container(child: Text('首页'),),
    );
  }
}