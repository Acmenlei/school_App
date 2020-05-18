import 'package:flutter/material.dart';
import 'package:flutter_app/components/lose/losePublish.dart';

class LosePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Losecontent();
  }
}

class Losecontent extends State<LosePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('寻物启示'),
        centerTitle: true,
      ),
      body: getLoseContent(),
    );
  }

  // 1. 寻物启事模块widget
  Widget getLoseContent() {
    return Stack(
      children: <Widget>[
        ListView( children: <Widget>[ Column( children: loseContent())]),
        Positioned(
            bottom: 30,
            right: 30,
            child: FloatingActionButton(
                heroTag: "发布寻物启事",
                onPressed: losePublishPage,
                backgroundColor: Colors.yellow,
                child: Icon(Icons.add, color: Colors.black54),)),
      ],
    );
  }
  // 2. 寻物启事内容
  List<Widget> loseContent() {
    return List.generate(30, (int index) {
              return Text("我是第$index");
        });
  }
  // 3. 内容跳转
  void losePublishPage() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => LoseInfoPublish())
    );
  }
}
