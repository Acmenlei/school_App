import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_app/Tools/GlobalState/global.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_app/Tools/network/request.dart';

class LoseInfoPublish extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InfoPushlish();
}

class InfoPushlish extends State<LoseInfoPublish> {
  final String imageUploadLocation = 'http://';
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
      appBar: AppBar(title: Text('寻物启事信息发布'), centerTitle: true),
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
          "温馨提示：在这里发布你丢失的物品信息,同学们会帮你一起找哦~",
          style: TextStyle(color: Colors.black54),
        ),
        SizedBox(height: 20),
        RaisedButton(
          onPressed: _openPhotos,
          child: this.imageSRC == null ? Text('点击选择丢失物品图片') : Text('已选择物品图片'),
          color: Colors.yellow,
        ),
        SizedBox(height: 20),
        imageSRC == null
            ? Text(
                'Ps: 你还未上传图片信息',
                style: TextStyle(color: Colors.black54),
              )
            : Image.file(imageSRC),
        SizedBox(height: 20),
        TextFormField(
            maxLines: 6,
            onSaved: (value) => this.introduce = value,
            validator: (v) {
              if (v == null || v.length == 0) {
                return "请输入物品的描述信息，否则将是大海捞针噢~";
              }
            },
            decoration: InputDecoration(
                hintText: "请输入你丢失物品的描述信息...",
                border: OutlineInputBorder(borderSide: BorderSide(width: 1)))),
        SizedBox(height: 20),
        TextFormField(
          onSaved: (value) => this.place = value,
          validator: (v){
            if(v == null || v.length == 0) {
              return "输入地点,这样更方便查找噢";
            }
          },
          decoration: InputDecoration(
            labelText: '填写物品丢失地点',
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
        RaisedButton(onPressed: _publishLoseInfo, color: Colors.yellow,child: Text('发布信息'),)
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
      color: Colors.yellow,
    );
  }
  // 3. 控制日期按钮的文字显示
  Widget getBtnName(){
    return this.selectedDate == null ? Text('请选择物品丢失日期'): Text('已选择');
  }
  // 4. 发布信息
  void _publishLoseInfo() {
    losePublishkey.currentState.save();
    losePublishkey.currentState.validate();
    // 判断是否输入
    if(this.imageSRC == null || this.introduce == null || this.introduce.length == 0 || this.place == null|| 
    this.place.length == 0 || this.telephone == null || this.telephone.length != 11 || this.selectedDate ==null
    ) return;
    // print(Global.name);
    // print('图片信息:$imageSRC，描述信息：$introduce，丢失地点：$place ，联系方式：$telephone, 丢失日期：$selectedDate');
    Map<String, dynamic> loseInfoData = {
      "loser": Global.name,
      "lose_telephone": this.telephone,
      "lose_img": File(this.imageSRC.path),
      "lose_introduce": this.introduce,
      "lose_place": this.place,
      "lose_time": this.selectedDate
    };
    HttpRequest.request('/lose/loseInfo_publish', method: 'post', parmas: loseInfoData)
    .then((value) => print(value))
    .catchError((onError) => print(onError));
  }
}
