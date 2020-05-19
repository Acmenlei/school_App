import 'package:flutter/material.dart';
import 'package:flutter_app/Tools/Model/loseOrpickInfo_model.dart';

class LoseItem extends StatelessWidget {
 final InfoModel loseModel;
  LoseItem(this.loseModel);
    @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Card(
        elevation: 15.0,
        child: Column(
          children: <Widget>[
            Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(padding: const EdgeInsets.all(5), child: Image.file(loseModel.imageURL, height: 200,)),
              getLoseIntroduce()
            ],
          ),
          getLoseName()
          ],
        )
      ),
    );
  }
  //1. 获取丢失物品的信息
  Widget getLoseIntroduce() {
    return Expanded(child: Container(
      padding: const EdgeInsets.all(10),
      child: Text("物品信息描述：${loseModel.introduce}", maxLines: 9, overflow: TextOverflow.ellipsis,)
    ));
  }
  //2. 失主信息展示
  Widget getLoseName() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text( "当事人: ${loseModel.name}, 联系方式: ${loseModel.telephone}, 丢失地点：${loseModel.palce}", overflow: TextOverflow.ellipsis,maxLines: 1,
          style: TextStyle(color: Colors.black54),
          )
        ],
      ),
    );
  }
}