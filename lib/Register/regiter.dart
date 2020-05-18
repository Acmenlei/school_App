import 'package:flutter/material.dart';
import 'package:flutter_app/Tools/LoadingDialog/LoadingDialog.dart';
import 'package:flutter_app/Tools/Toast/Toast.dart';
import 'package:flutter_app/Tools/network/request.dart';

class Register extends StatefulWidget {
  State<StatefulWidget> createState() => RegisterContent();
}

class RegisterContent extends State<Register> {
  bool checkSex = true;
  int sex = 1;
  String sexValue = "男";
  String password;
  String telephone;
  String studentId;
  String classId;
  String college;
  String name;
  GlobalKey<FormState> registerkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('工院校园失物招领平台'),centerTitle: true,),
      body: Container(
        width: double.infinity,
      padding: EdgeInsets.all(20),
      child:Form(
        key: registerkey,
        child: registerCpnt(),
      ) ,
      ),
    );
  }

  // 1. 用户名密码性别等等
  Widget registerCpnt() {
    return ListView(
      children: <Widget>[
        getRegisterTitle(),
        TextFormField( /* 学号 */
          onSaved: (value) => this.studentId = value,
          validator: (v) {
          if(v == null || v.length != 11) {
              return "请输入正确的学号.";
            }
          },
          decoration: InputDecoration(
            labelText: '学号',
            prefixIcon: Icon(Icons.person_add)
          ),
        ),
        TextFormField( /* 密码 */
          onSaved: (value) => this.password = value,
          validator: (v) {
            if(v == null || v.length == 0) {
              return "密码不能为空.";
            } else if(v.length > 16) {
              return "密码长度不能超过16位.";
            }
          },
          decoration: InputDecoration(
            labelText: '密码',
            prefixIcon: Icon(Icons.lock)
          ),
          obscureText: true,
        ),
        TextFormField( /* 手机号码 */
          onSaved: (value) => this.telephone = value,
          validator: (v) {
            if(v == null || v.length != 11) {
              return "请输入正确的手机号码格式.";
            }
          },
          decoration: InputDecoration(
            labelText: '手机号码',
            prefixIcon: Icon(Icons.phone)
          ),
        ),
        TextFormField(
          onSaved: (value) => this.name = value, /* 班级 */
          validator: (v){
            if(v == null || v.length == 0) {
              return '请输入你的姓名'; 
            }
          } ,
          decoration: InputDecoration(
            labelText: '姓名',
            prefixIcon: Icon(Icons.person)
          ),
        ),
        Container(child: Row(
          children: <Widget>[
          Radio(value: 1, groupValue: sex, onChanged: manEvent, activeColor: Colors.yellow),
          Text('男', style: TextStyle(fontSize: 18)),
          Radio(value: 2, groupValue: sex, onChanged: womanEvent, activeColor: Colors.yellow),
          Text('女', style: TextStyle(fontSize: 18))]
        ),),
        TextFormField(
          onSaved: (value) => this.classId = value, /* 班级 */
          validator: (v){
            if(v == null || v.length == 0) {
              return '请输入班级信息'; 
            }
          } ,
          decoration: InputDecoration(
            labelText: '班级',
            prefixIcon: Icon(Icons.class_)
          ),
        ),
        TextFormField(
          onSaved: (value) => this.college = value, /* 班级 */
          validator: (v) {
            if(v == null || v.length == 0) {
               return "请输入您的所在院系";
            }
          },
          decoration: InputDecoration(
            labelText: '所属院系',
            prefixIcon: Icon(Icons.school)
          ),
        ),
        RaisedButton(onPressed: registerEvent,color: Colors.yellow,child: Text("注册", style: TextStyle(fontSize: 16),))
      ],
    );
  }
  
  // 2.1 单选按钮
  void manEvent(value) { // 男生
    setState(() {
      this.sex = value;
      this.sexValue = '男';
    });
  }
  void womanEvent(value) { // 女生
  setState(() {
    this.sex = value;
    this.sexValue = '女';
  });
}
  // 3.1 注册事件
  void registerEvent() {
    // 调用save方法触发save回调
   registerkey.currentState.save();
   registerkey.currentState.validate();
   if(
     this.studentId == null || this.studentId.length != 11 || this.password == null || this.password.length > 16 ||
     this.telephone == null || this.telephone.length != 11 || this.classId == null || this.classId.length == 0 ||
     this.college == null || this.college.length == 0 || this.name == null || this.name.length == 0
   ) return;
   // 注册加载遮罩层
   showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return LoadingDialog(
        text: "正在注册稍等…",
      );
    });
      /* 发起请求注册 */
    // print("学号: $studentId, 姓名: $name 密码: $password 手机: $telephone 性别: $sexValue 班级: $classId 院系: $college");
    Map<String, dynamic> registerData = {
       "studentId": studentId,
       "password": password,
       "telephone": telephone,
       "sexValue": sexValue,
       "classId": classId,
       "college": college,
       "name": name
    };
    // 发起注册请求
    HttpRequest.request('/user/register', method: 'post', parmas:registerData )
    .then((value){
      Toast.toast(context, msg: "注册成功，现在可以去登陆了呀~");
      Navigator.pop(context); 
      Navigator.pop(context); // 注册成功返回登陆界面
    })
    .catchError((onError) {
      Toast.toast(context, msg: "很遗憾，注册失败了~$onError");
      Navigator.pop(context);
    });
  }
  // 3.2 注册标题的展示
  Widget getRegisterTitle() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.bookmark_border, size: 30,),
          Text('工院校园失物招领平台注册', style: TextStyle(fontSize: 18),)
        ],
      ),
    );
  }
}