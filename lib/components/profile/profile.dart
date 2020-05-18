import 'package:flutter/material.dart';
import 'package:flutter_app/Login/Login.dart';
import 'package:flutter_app/Tools/GlobalState/global.dart';
import 'package:flutter_app/Tools/LoadingDialog/LoadingDialog.dart';
import 'package:flutter_app/Tools/Model/profile_model.dart';
import 'package:flutter_app/Tools/Toast/Toast.dart';
import 'package:flutter_app/Tools/network/request.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Profilecontent();
  }
}
 // 个人信息的内容
class Profilecontent extends State<ProfilePage> {
  ProfileData profiledata;
  bool logined = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('个人信息'), centerTitle: true,),
      body: Container(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: <Widget>[getHeaderWidget(), getStudentInfo()],
          )),
    );
  }

  // 1. 头像与姓名的展示
  Widget getHeaderWidget() {
    if (this.logined == true) {
      return Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 10, color: Color(0xffeeeeee)))),
          child: Row(
            children: <Widget>[
              ClipOval(
                child: Image.network(
                  this.profiledata.head,
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '姓名: ${this.profiledata.name}',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    '学号: ${this.profiledata.studentId}',
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  )
                ],
              )
            ],
          ));
    } else {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(width: 10, color: Color(0xffeeeeee)))),
        child: Row(
          children: <Widget>[
            ClipOval(
                child: Image.network(
              'https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3968417432,4100418615&fm=26&gp=0.jpg',
              width: 90,
              height: 90,
              fit: BoxFit.cover,
            )),
            SizedBox(
              width: 20,
            ),
            Expanded(
                child: Text('登陆 / 注册',
                    style: TextStyle(fontSize: 20, color: Color(0xff333333)))),
            IconButton(
              icon: Icon(
                Icons.chevron_right,
                color: Colors.black54,
                size: 30,
              ),
              onPressed: () async {
                var result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Login();
                    },
                  ),
                );
                setState(() {
                  this.profiledata = result;
                  if(this.profiledata != null) {
                    this.logined = true;
                  }
                });
              },
            ),
          ],
        ),
      );
    }
  }

  // 2. 获取个人信息班级学院等
  Widget getStudentInfo() {
    if (this.logined == true) {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            getClassRootandCollege('所属院系', this.profiledata.college),
            getClassRootandCollege('性别', this.profiledata.sex),
            getClassRootandCollege('班级', this.profiledata.classId),
            getClassRootandCollege('联系方式', this.profiledata.telephone),
            Container(
              width: double.infinity,
              child: RaisedButton(
              onPressed: isExitLogin,
              child: Text(
                '退出登陆',
              ),
              color: Colors.yellow,
            ),
            )
          ],
        ),
      );
    } else {
      return Text('');
    }
  }
  // 2.0.1 退出登陆
  void isExitLogin() {
    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text('提示信息'),
          content: Text('是否确定要退出登陆？'),
          actions: <Widget>[
            FlatButton(onPressed:exitok, child: Text('退出')),
            FlatButton(onPressed: () => Navigator.pop(context), child: Text('取消'))
          ],
        );
      }
    );
  }
  // 2. 退出登陆
  void exitok(){
      setState(() => this.logined = false);
 // 打开加载动画
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new LoadingDialog(
            text: "正在退出…",
          );
      });
      HttpRequest.request('/user/exit').then((value){
      // 退出成功
      Navigator.pop(context);
      Navigator.pop(context);
      Global.destoryState(); // 清除个人信息
      // 给个提示框
      Toast.toast(context, msg: value['message']);
      });
    }
  // 2.1 信息展示
  Widget getClassRootandCollege(String title, dynamic value) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
      width: double.infinity,

      child: Text.rich(TextSpan(children: [
        TextSpan(text: '$title:   ', style: TextStyle(fontSize: 17)),
        TextSpan(
            text: value.toString(),
            style: TextStyle(fontSize: 16, color: Colors.black54))
      ])),
    );
  }
}
