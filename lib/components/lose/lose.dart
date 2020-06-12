import 'package:flutter/material.dart';
import 'package:flutter_app/Tools/GlobalState/global.dart';
import 'package:flutter_app/Tools/Model/loseOrpickInfo_model.dart';
import 'package:flutter_app/Tools/Toast/Toast.dart';
import 'package:flutter_app/Tools/network/request.dart';
import 'package:flutter_app/components/lose/loseItem.dart';
import 'package:flutter_app/components/lose/losePublish.dart';

class LosePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Losecontent();
  }
}

class Losecontent extends State<LosePage> {
  List<InfoModel> loseInfoList = [];
  @override
  void initState() {
    super.initState();
    // 后台丢失物品信息的数据请求
    HttpRequest.request('/lose/getloseInfo', parmas: {"isroot": 1}).then((value){
      List<InfoModel> loseList = [];
      for(var loseData in Map.from(value)['data']) {
        InfoModel loseModel = InfoModel.formMap(Map.from(loseData));
        loseList.add(loseModel);
      }
      setState(() => this.loseInfoList = loseList);
    })
    .catchError((onError)=> Toast.toast(context, msg: "请求物品信息失败了，稍后再试试吧!"));
  }
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
                heroTag: 'lose.send.page',
                onPressed: losePublishPage,
                backgroundColor: Colors.purpleAccent,
                child: Icon(Icons.add, color: Colors.white),)),
      ],
    );
  }
  // 2. 寻物启事内容
  List<Widget> loseContent() {
    return List.generate(this.loseInfoList.length, (int index) {
              return LoseItem(loseInfoList[index]);
        });
  }
  // 3. 内容跳转
  void losePublishPage() {
    if(Global.name == null){
      Toast.toast(context, msg: "同学,请先去登陆再来发表!");
    } else {
      Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => LoseInfoPublish())
    );
    }
  }
}
