import 'package:flutter/material.dart';
import 'package:flutter_app/Tools/Model/user_model.dart';
import 'package:flutter_app/Tools/Toast/Toast.dart';
import 'package:flutter_app/Tools/network/request.dart';

class ManagerUser extends StatefulWidget {
  final UserInfoModel userData;
  ManagerUser(this.userData);
  @override
  State<StatefulWidget> createState() {
    return UserModel();
  }
}

class UserModel extends State<ManagerUser> {
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
             children: <Widget>[
               Text('姓名:'),
               Text(widget.userData.name),
               Text('班级:'),
               Text(widget.userData.classroom),
               Text('所属院系:'),
               Text(widget.userData.college),
             ],
           ),
         ),
          FloatingActionButton(
            child: Icon(Icons.delete), backgroundColor: Colors.red,
              onPressed: deleteAccessInfo,
          )
        ],
      )
    );    
  }

 /* 1. 删除用户信息逻辑处理 */
  void deleteAccessInfo() {
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: Text("删除提示信息"),
          content: Text("是否要删除这名用户的信息？"),
          actions: <Widget>[
            FlatButton(onPressed: deleteOk, child: Text('确定'),),
            FlatButton(onPressed: () => Navigator.pop(context), child: Text('取消'),)
          ],
        );
      });
  }
  /* 1.2 确定删除 */
  void deleteOk() {
    HttpRequest.request('/admin/delUser', parmas: {"id": widget.userData.id}, method:"post")
    .then((value) {
      Navigator.pop(context);
      Toast.toast(context, msg: '用户信息删除成功!');
    })
    .catchError((onError) => Toast.toast(context, msg: '$onError'));
  }
}