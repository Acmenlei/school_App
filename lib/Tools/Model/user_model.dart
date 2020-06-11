class UserInfoModel {
  String name;
  String classroom;
  String college;
  int id;
  String sex;
  
  UserInfoModel.fromUser(Map<String, dynamic> userdata) {
    this.name = userdata['student_name'];
    this.classroom = userdata['class_id'];
    this.college = userdata['college'];
    this.id = userdata['student_id'];
    this.sex = userdata['sex'];
  }
}