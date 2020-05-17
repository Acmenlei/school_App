import 'package:flutter/material.dart';
import 'package:flutter_app/Tools/LoadingDialog/LoadingDialog.dart';
import 'package:flutter_app/Tools/Model/profile_model.dart';
import 'package:flutter_app/Tools/Toast/Toast.dart';
import 'package:flutter_app/Tools/network/request.dart';
import './LoginTitle.dart';

// 登陆
class Login extends StatefulWidget {
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

/* 登陆模块管理 */
class LoginState extends State<Login> {
  String username, password;
  GlobalKey<FormState> loginFormState = GlobalKey();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('工院寻物平台登陆')),
      body: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
              key: loginFormState, // 获取formstate
              child: ListView(
                children: <Widget>[
                  GongyuanTitle(), // 登陆标题
                  SizedBox(height: 20),
                  TextFormField(
                    onSaved: (value) => this.username = value,
                    validator: (v) {
                      if (v == null || v.length != 11) {
                        return "学号格式错误!";
                      }
                    },
                    decoration: InputDecoration(
                        labelText: '学号', prefixIcon: Icon(Icons.people)),
                  ),
                  TextFormField(
                    onSaved: (value) => this.password = value,
                    validator: (v) {
                      if (v == null || v.length == 0) {
                        return "密码不能为空!";
                      } else if (v.length > 16) {
                        return "密码长度不能大于16位!";
                      }
                    },
                    decoration: InputDecoration(
                        labelText: '密码', prefixIcon: Icon(Icons.lock)),
                    obscureText: true,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: double.infinity, // 撑满整个容器
                        height: 44,
                        child: RaisedButton(
                          color: Colors.yellow,
                          onPressed: () {
                            // 调用save方法触发save回调
                            loginFormState.currentState.save();
                            loginFormState.currentState.validate();
                            if (username == null ||
                                username.length != 11 ||
                                password == null ||
                                password.length > 16) return;
                            // 打开加载动画
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return new LoadingDialog(
                                    text: "正在登录中…",
                                  );
                                });
                            Map<String, dynamic> data = {
                              "student_id": username,
                              "password": password
                            };
                            HttpRequest.request('/user/login',
                                    method: 'post', parmas: data)
                                .then((value) {
                              ProfileData profiledata =
                                  ProfileData(value['data'][0]);
                              Navigator.pop(context); // 这个是关闭我们的dialog
                              Navigator.pop(
                                  context, profiledata); // 这个是返回我们的个人信息页面
                            }).catchError((onError){
                              Navigator.pop(context);
                              Toast.toast(context, msg: "登陆失败,请检查账号密码后在登陆!");
                            });
                          },
                          child: Text('登陆', style: TextStyle(fontSize: 15)),
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        width: double.infinity,
                        height: 44,
                        child: OutlineButton(
                          onPressed: () => print('注册'),
                          child: Text('注册', style: TextStyle(fontSize: 15)),
                        ),
                      )
                    ],
                  ),
                ],
              ))),
    );
  }
}
