import 'package:flutter/material.dart';

class LoseInfoPublish extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InfoPushlish();
}

class InfoPushlish extends State<LoseInfoPublish> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('寻物启事信息发布'),centerTitle: true),
      body: Center(child: Text('发布')),
    );
  }
}