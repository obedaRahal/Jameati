// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this


class ShowUserToStartChatmodel {
  List<UserNewChatModel>? doctors;
  List<UserNewChatModel>? myGroup;
  List<UserNewChatModel>? students;
  int? statusCode;

  ShowUserToStartChatmodel(
      {this.doctors, this.myGroup, this.students, this.statusCode});

  ShowUserToStartChatmodel.fromJson(Map<String, dynamic> json) {
    if (json['doctors'] != null) {
      doctors = <UserNewChatModel>[];
      json['doctors'].forEach((v) {
        doctors!.add(new UserNewChatModel.fromJson(v));
      });
    }
    if (json['myGroup'] != null) {
      myGroup = <UserNewChatModel>[];
      json['myGroup'].forEach((v) {
        myGroup!.add(new UserNewChatModel.fromJson(v));
      });
    }
    if (json['students'] != null) {
      students = <UserNewChatModel>[];
      json['students'].forEach((v) {
        students!.add(new UserNewChatModel.fromJson(v));
      });
    }
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.doctors != null) {
      data['doctors'] = this.doctors!.map((v) => v.toJson()).toList();
    }
    if (this.myGroup != null) {
      data['myGroup'] = this.myGroup!.map((v) => v.toJson()).toList();
    }
    if (this.students != null) {
      data['students'] = this.students!.map((v) => v.toJson()).toList();
    }
    data['statusCode'] = this.statusCode;
    return data;
  }
}

class UserNewChatModel {
  int? id;
  String? name;
  String? profileImage;

  UserNewChatModel({this.id, this.name, this.profileImage});

  UserNewChatModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['profile_image'] = this.profileImage;
    return data;
  }
}