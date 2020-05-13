import 'package:flutter/material.dart';
// 入口函数
main() => runApp(MyApp());
// 页面结构
class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('个人博客'),
          ),
        ), // 标题
        body: ContentWidget(),
      ),
    );
  }
}
// body内容
class ContentWidget extends StatelessWidget {
  Widget build(BuildContext context){
    return Center( // body 为显示的内容
//      设置文本widget为从左到右显示
        child: Text('欢迎来到我的个人博客！',
          textDirection: TextDirection.ltr,
          style: TextStyle(
              color: Colors.blue,
              fontSize: 20
          ),
        )
    );
  }
}
