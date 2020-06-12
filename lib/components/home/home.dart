
import 'package:flutter/material.dart';
import 'package:flutter_app/Tools/GlobalState/global.dart';
import 'package:flutter_app/Tools/Model/loseOrpickInfo_model.dart';
import 'package:flutter_app/Tools/Model/user_model.dart';
import 'package:flutter_app/Tools/Toast/Toast.dart';
import 'package:flutter_app/Tools/network/request.dart';
import 'package:flutter_app/components/home/LoseInfoManager.dart';
import 'package:flutter_app/components/home/UserManger.dart';
import 'package:flutter_app/components/home/pickInfoManager.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Homecontent();
  }
}

class Homecontent extends State<HomePage> {
  List<UserInfoModel> userData = [];
  List<InfoModel> loseData = [];
  List<InfoModel> pickData = [];
  @override
  void initState() {
    super.initState();
    getUserData();
    getLoseData();
    getPickData();
  }
  /* 1.用户信息数据请求 */
  void getUserData(){
        HttpRequest.request('/admin/user_manager').then((value){
      List<UserInfoModel> userList = [];
      for(var user in value['data']) {
        UserInfoModel userModel = UserInfoModel.fromUser(Map.from(user));
        userList.add(userModel);
      }
      setState(() => this.userData = userList);
    })
    .catchError((onError) => Toast.toast(context, msg: '$onError'));
  }
    /* 2.丢失信息数据请求 */
  void getLoseData(){
        HttpRequest.request('/lose/getloseInfo', parmas: {"isroot": Global.isroot}).then((value){
      List<InfoModel> loseList = [];
      for(var lose in value['data']) {
        InfoModel loseModel = InfoModel.formMap(Map.from(lose));
        loseList.add(loseModel);
      }
      setState(() => this.loseData = loseList);
    });
  }
     /* 3.丢失信息数据请求 */
  void getPickData(){
        HttpRequest.request('/pick/getpickInfo', parmas: {"isroot": Global.isroot}).then((value){
      List<InfoModel> pickList = [];
      for(var pick in value['data']) {
        InfoModel pickModel = InfoModel.formPick(Map.from(pick));
        pickList.add(pickModel);
      }
      setState(() => this.pickData = pickList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('管理员操作'),centerTitle: true,),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: isAdminShow()
      ),
    );
  }
//  判断权限
   Widget isAdminShow() {
    if(Global.isroot != 0) {
      return ListView(
        children: <Widget>[
          // 1. 用户信息管理模块展示：
          getManagerTitle('用户信息模块管理'),
          getColumnName_user(),
          getManagerUser(),
          SizedBox(height: 30,),
          // 2. 物品管理模块
          getManagerTitle('丢失物品信息模块管理'),
          getColumnName_lose_pick(),
          getLoseInfo(),
          // 2. 物品管理模块
          getManagerTitle('捡到物品信息模块管理'),
          getColumnName_lose_pick(),
          getPickInfo()
        ],
      );
    } else {
      return Center(child: Text('您没有权限访问此页面'),);
    }
  }
  /* 公工具函数 */
    Widget getManagerTitle(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      child: Text('$title :', style: TextStyle(fontSize: 18, color: Colors.blueAccent)),
    );
    }
    Widget getColumnName_user() {
      return Container(
          child: Row(
            children: <Widget>[
              Text('姓名:    ', style: TextStyle(fontSize: 16, color: Colors.black54),),
              Text('班级:      ', style: TextStyle(fontSize: 16, color: Colors.black54),),
              Text('所属院系:          ', style: TextStyle(fontSize: 16, color: Colors.black54),),
              Text('性别:                    ', style: TextStyle(fontSize: 16, color: Colors.black54),),
              Text('Action:', style: TextStyle(fontSize: 16, color: Colors.black54))
            ],
          )
      );
    }
    Widget getColumnName_lose_pick() {
      return Container(
        child: Row(
          children: <Widget>[
          Text('编号:    ', style: TextStyle(fontSize: 16, color: Colors.black54),),
          Text('图片:      ', style: TextStyle(fontSize: 16, color: Colors.black54),),
          Text('介绍:                               ', style: TextStyle(fontSize: 16, color: Colors.black54),),
          Text('当事人:   ', style: TextStyle(fontSize: 16, color: Colors.black54),),
          Text('Action:', style: TextStyle(fontSize: 16, color: Colors.black54))
          ],
          )
      );
    }
  /* 1. 用户信息管理模块 */
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

  /* 2. 丢失物品信息模块 */
  Widget getLoseInfo() {
    return Container(
      child: Column(
        children: getLoseInfoList()
      ),
    );
  }
  List<Widget> getLoseInfoList(){
    return List.generate(loseData.length, (int index) => LoseItemModel(loseData[index]));
  }

    /* 3. 丢失物品信息模块 */
  Widget getPickInfo() {
    return Container(
      child: Column(
        children: getPickInfoList()
      ),
    );
  }
  List<Widget> getPickInfoList(){
    return List.generate(pickData.length, (int index) => PickItemModel(pickData[index]));
  }
}