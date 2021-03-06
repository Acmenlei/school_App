// 个人信息数据模型
import 'package:flutter_app/Tools/GlobalState/global.dart';

class ProfileData {
  String name;
  String classId;
  int telephone;
  String college;
  int studentId;
  String head;
  int isroot;
  String sex;
  ProfileData(Map<String, dynamic> data){
    this.name = data['student_name'];
    Global.name = data['student_name'];
    Global.studentId = data['student_id'];
    Global.isroot = data['isroot'];
    this.studentId = data['student_id'];
    this.classId = data['class_id'];
    this.head = data['head_portrait'];
    this.isroot = data['isroot'];
    this.telephone = data['telephone'];
    this.college = data['college'];
    this.sex = data['sex'];
  }
}