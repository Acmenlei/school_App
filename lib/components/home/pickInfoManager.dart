import 'package:flutter/material.dart';
import 'package:flutter_app/Tools/Model/loseOrpickInfo_model.dart';
import 'package:flutter_app/Tools/Toast/Toast.dart';
import 'package:flutter_app/Tools/network/request.dart';

class PickItemModel extends StatefulWidget {
  final InfoModel pickData;
  PickItemModel(this.pickData);
  @override
  State<StatefulWidget> createState() {
    return PickModel();
  }
}

class PickModel extends State<PickItemModel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 5, color: Colors.black12)
        )
      ),
      child: Row(
        children: <Widget>[
         Expanded(
           child: Row(
             mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>[
               Text('${widget.pickData.id}'),
               Container(
                 padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                 child: Image.file(widget.pickData.imageURL, width: 80, height: 80,),),
               Expanded(
                 child: Container(
                   padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                   child: Text(widget.pickData.introduce, overflow: TextOverflow.ellipsis, maxLines: 4,),
                 )
               ),
               Container(
                 padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                 child: Text(widget.pickData.name, style: TextStyle(fontSize: 16, color: Colors.greenAccent),),
               )
             ],
           ),
         ),
          FloatingActionButton(
            child: Icon(Icons.delete), backgroundColor: Colors.red,
              onPressed: deletepickInfo,
          )
        ],
      )
    );    
  }

 /* 1. 删除用户信息逻辑处理 */
  void deletepickInfo() {
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: Text("删除提示信息"),
          content: Text("是否要删除这个物品的信息？"),
          actions: <Widget>[
            FlatButton(onPressed: deleteOk, child: Text('确定'),),
            FlatButton(onPressed: () => Navigator.pop(context), child: Text('取消'),)
          ],
        );
      });
  }
  /* 1.2 确定删除 */
  void deleteOk() {
    HttpRequest.request('/admin/del_Pick', parmas: {"id": widget.pickData.id}, method:"post")
    .then((value) {
      Navigator.pop(context);
      Toast.toast(context, msg: '物品信息删除成功!');
    })
    .catchError((onError) => Toast.toast(context, msg: '$onError'));
  }
}