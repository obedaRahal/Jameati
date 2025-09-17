// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this

class ShowJoinRequestModel {
  List<Requests>? requests;
  int? statusCode;

  ShowJoinRequestModel({this.requests, this.statusCode});

  ShowJoinRequestModel.fromJson(Map<String, dynamic> json) {
    if (json['requests'] != null) {
      requests = <Requests>[];
      json['requests'].forEach((v) {
        requests!.add(new Requests.fromJson(v));
      });
    }
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.requests != null) {
      data['requests'] = this.requests!.map((v) => v.toJson()).toList();
    }
    data['statusCode'] = this.statusCode;
    return data;
  }
}

class Requests {
  int? id;
  int? groupId;
  int? userId;
  String? status;
  User? user;

  Requests({this.id, this.groupId, this.userId, this.status, this.user});

  Requests.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupId = json['group_id'];
    userId = json['user_id'];
    status = json['status'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['group_id'] = this.groupId;
    data['user_id'] = this.userId;
    data['status'] = this.status;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  String? name;
  String? studentSpeciality;
  String? profileImage;

  User({this.name, this.studentSpeciality, this.profileImage});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    studentSpeciality = json['student_speciality'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['student_speciality'] = this.studentSpeciality;
    data['profile_image'] = this.profileImage;
    return data;
  }
}