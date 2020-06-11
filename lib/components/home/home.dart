import 'package:flutter/material.dart';
import 'package:flutter_app/Tools/GlobalState/global.dart';
import 'package:flutter_app/Tools/Model/user_model.dart';
import 'package:flutter_app/Tools/Toast/Toast.dart';
import 'package:flutter_app/Tools/network/request.dart';
import 'package:flutter_app/components/home/UserManger.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Homecontent();
  }
}

class Homecontent extends State<HomePage> {
  List<UserInfoModel> userData = [];
  @override
  void initState() {
    super.initState();
    HttpRequest.request('/admin/user_manager').then((value){
      List<UserInfoModel> userList = [];
      for(var user in value['data']) {
        UserInfoModel userModel = UserInfoModel.fromUser(Map.from(user));
        userList.add(userModel);
      }
      setState(() => this.userData = userList);
    })
    .catchError((onError) => Toast.toast(context, msg: onError));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('管理员界面'),centerTitle: true,),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            // 1. 用户信息管理模块展示：
            getManagerUserTitle(),
            getManagerUser()
          ],
        ),
      ),
    );
  }
  
  /* 1. 用户信息管理模块 */
  Widget getManagerUserTitle() {
    return Text('用户管理模块：', style: TextStyle(fontSize: 16, color: Colors.purpleAccent));
  }
  Widget getManagerUser() {
    return Container(
      child: Column(
        children: getUserList(),
      ),
    );
  }
  List<Widget> getUserList() {
    return List.generate(userData.length, (int index) => ManagerUser(userData[index]));
  }
}