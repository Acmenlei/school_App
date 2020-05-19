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
    return Scaffold(
      appBar: AppBar(title: Text('江西工业工程职业技术学院寻物平台'),centerTitle: true,),
      body: Container(child: Center(child: Text('首页暂不开发', style: TextStyle(fontSize: 30,color: Colors.purpleAccent),),),),
    );
  }
}