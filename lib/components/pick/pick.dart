import 'package:flutter/material.dart';
import 'package:flutter_app/Tools/GlobalState/global.dart';
import 'package:flutter_app/Tools/Model/loseOrpickInfo_model.dart';
import 'package:flutter_app/Tools/Toast/Toast.dart';
import 'package:flutter_app/Tools/network/request.dart';
import 'package:flutter_app/components/lose/loseItem.dart';
import 'package:flutter_app/components/pick/pickPublish.dart';

class PickPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Pickcontent();
  }
}

class Pickcontent extends State<PickPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('失物招领'), centerTitle: true,),
      body: getPickContent(),
    );
  }
  List<InfoModel> pickInfoList = [];
  @override
  void initState() {
    super.initState();
    // 后台丢失物品信息的数据请求
    HttpRequest.request('/pick/getpickInfo').then((value){
      List<InfoModel> pickList = [];
      for(var loseData in Map.from(value)['data']) {
        InfoModel loseModel = InfoModel.formPick(Map.from(loseData));
        pickList.add(loseModel);
      }
      setState(() => this.pickInfoList = pickList);
    })
    .catchError((onError)=> Toast.toast(context, msg: "请求物品信息失败了，稍后再试试吧!"));
  }

  // 1. 寻物启事模块widget
  Widget getPickContent() {
    return Stack(
      children: <Widget>[
        ListView( children: <Widget>[ Column( children: pickContent())]),
        Positioned(
            bottom: 30,
            right: 30,
            child: FloatingActionButton(
                heroTag: "发布失物招领",
                onPressed: pickPublishPage,
                backgroundColor: Colors.purpleAccent,
                child: Icon(Icons.add, color: Colors.white),)),
      ],
    );
  }
  // 2. 寻物启事内容
  List<Widget> pickContent() {
    return List.generate(this.pickInfoList.length, (int index) {
              return LoseItem(pickInfoList[index]);
        });
  }
  // 3. 内容跳转
  void pickPublishPage() {
    if(Global.name == null){
      Toast.toast(context, msg: "同学,请先去登陆再来发表!");
    } else {
      Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => PickInfoPublish())
    );
    }
  }
}