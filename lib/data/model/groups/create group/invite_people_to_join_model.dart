// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this

class InvitePeopleToJoinModel {
  List<StudentsModel>? students;
  int? statusCode;

  InvitePeopleToJoinModel({this.students, this.statusCode});

  InvitePeopleToJoinModel.fromJson(Map<String, dynamic> json) {
    if (json['students'] != null) {
      students = <StudentsModel>[];
      json['students'].forEach((v) {
        students!.add(new StudentsModel.fromJson(v));
      });
    }
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.students != null) {
      data['students'] = this.students!.map((v) => v.toJson()).toList();
    }
    data['statusCode'] = this.statusCode;
    return data;
  }
}

class StudentsModel {
  int? id;
  String? name;
  String? studentStatus;
  String? studentSpeciality;
  String? profileImage;

  StudentsModel(
      {this.id,
      this.name,
      this.studentStatus,
      this.studentSpeciality,
      this.profileImage});

  StudentsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    studentStatus = json['student_status'];
    studentSpeciality = json['student_speciality'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['student_status'] = this.studentStatus;
    data['student_speciality'] = this.studentSpeciality;
    data['profile_image'] = this.profileImage;
    return data;
  }
}