import 'package:flutter/material.dart';

/* 登陆标题 */
class GongyuanTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.bookmark_border),
        Text(
          '工院校园失物招领平台',
          style: TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}