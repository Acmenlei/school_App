import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_app/Tools/GlobalState/global.dart';
import 'package:flutter_app/Tools/Toast/Toast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_app/Tools/network/request.dart';

class PickInfoPublish extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InfoPushlish();
}

class InfoPushlish extends State<PickInfoPublish> {
  File imageSRC;
  String imageServer;
  String introduce;
  DateTime selectedDate;
  String place;
  String telephone;
  GlobalKey<FormState> losePublishkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('失物招领信息发布'), centerTitle: true),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Form(key: losePublishkey, child: getInfoPublish()),
      ),
    );
  }

  // 1. 发布信息
  Widget getInfoPublish() {
    return ListView(
      children: <Widget>[
        Text(
          "温馨提示：在这里发布你捡到的物品信息,同学们会很感谢你的~",
          style: TextStyle(color: Colors.black54),
        ),
        SizedBox(height: 20),
        RaisedButton(
          onPressed: _openPhotos,
          child: this.imageSRC == null ?  
           Text('点击选择捡到物品图片', style: TextStyle(color: Colors.white),)
           : Text('已上传物品图片', style: TextStyle(color: Colors.white)),
          color: Colors.purpleAccent,
        ),
        SizedBox(height: 20),
        imageSRC == null
            ? Text(
                'Ps: 你还未上传捡到物品的图片信息',
                style: TextStyle(color: Colors.black54),
              )
            : Image.file(imageSRC),
        SizedBox(height: 20),
        TextFormField(
            maxLines: 6,
            onSaved: (value) => this.introduce = value,
            validator: (v) {
              if (v == null || v.length == 0) {
                return "请输入物品的描述信息，这将有利于同学们更好的分辨~";
              }
            },
            decoration: InputDecoration(
                hintText: "请输入你捡到物品的描述信息...",
                border: OutlineInputBorder(borderSide: BorderSide(width: 1)))),
        SizedBox(height: 20),
        TextFormField(
          onSaved: (value) => this.place = value,
          validator: (v){
            if(v == null || v.length == 0) {
              return "输入捡到地点,这样更方便确认失主噢";
            }
          },
          decoration: InputDecoration(
            labelText: '填写物品拾到地点',
            prefixIcon: Icon(Icons.place),
          ),
        ),
        TextFormField(
          onSaved: (value) => this.telephone = value,
          decoration: InputDecoration(
            labelText: '填写联系方式',
            prefixIcon: Icon(Icons.phone),
          ),
        ),
         SizedBox(height: 20),
        getDateWidget(),
        publishBtn()
      ],
    );
  }

  // 2.打开相机上传图片到本地
  void _openPhotos() async{
    // print('打开相册');
    // File image = await ImagePicker.pickImage(source: ImageSource.camera, maxWidth: 400);
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() => this.imageSRC = image);
  }

  // 3. 日期组件
  Widget getDateWidget() {
    return RaisedButton(
      onPressed: () async {
        var result = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime(2030),
            builder: (context, child) {
            return Theme(
              data: ThemeData.dark(),
              child: child,
            );
        },
        );
        setState(() => this.selectedDate = result);
      },
      child: getBtnName(),
      color: Colors.purpleAccent,
    );
  }
  // 3. 控制日期按钮的文字显示
  Widget getBtnName(){
    return this.selectedDate == null ? 
     Text('请选择物品捡到日期', style: TextStyle(color: Colors.white)):
     Text('已选择',style: TextStyle(color: Colors.white));
  }
  // 4. 失物招领信息发布。
  Widget publishBtn() {
    return RaisedButton(
    onPressed: _publishLoseInfo,
     color: Colors.purpleAccent,
     child: Text('发布信息',
     style: TextStyle(color: Colors.white)
     ));
  }
  // 4. 发布信息
  void _publishLoseInfo() {
    losePublishkey.currentState.save();
    losePublishkey.currentState.validate();
    // 判断是否输入
    if(this.imageSRC == null || this.introduce == null || this.introduce.length == 0 || this.place == null|| 
    this.place.length == 0 || this.telephone == null || this.telephone.length != 11 || this.selectedDate ==null
    ) return;
    // 开始发表
    Map<String, dynamic> loseInfoData = {
      "picker": Global.name,
      "picker_telephone": this.telephone,
      "pick_img": this.imageSRC.path,
      "pick_introduce": this.introduce,
      "pick_place": this.place,
      "pick_time": this.selectedDate.toString().substring(0, this.selectedDate.toString().length - 4)
    };
    HttpRequest.request('/pick/pickInfo_publish', method: 'post', parmas: loseInfoData)
    .then((value){
      Navigator.pop(context);
      Toast.toast(context, msg: "你的失物招领信息发布成功啦~");
    })
    .catchError((onError) => print(onError));
  }
}
