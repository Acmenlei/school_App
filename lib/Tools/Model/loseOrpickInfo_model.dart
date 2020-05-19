import 'dart:io';

class InfoModel {
  File imageURL;
  String introduce;
  String palce;
  String telephone;
  String dateTime;
  String name;
  String publishTime;
  
  InfoModel.formMap(Map<String, dynamic> data){
   this.imageURL = File(data['lose_img']);
   this.name = data['loser'];
   this.introduce = data['lose_introduce'];
   this.palce = data['lose_location'];
   this.telephone = data['loser_telephone'];
   this.dateTime = data['lose_time'];
   this.publishTime = data['publish_time'];
  }
  InfoModel.formPick(Map<String, dynamic> data){
    this.imageURL = File(data['pick_img']);
   this.name = data['picker'];
   this.introduce = data['pick_introduce'];
   this.palce = data['pick_location'];
   this.telephone = data['picker_telephone'];
   this.dateTime = data['pick_time'];
   this.publishTime = data['publish_time'];
  }
}