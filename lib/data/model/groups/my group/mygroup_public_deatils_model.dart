// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this

class MyGroupPublicDeatilsModel {
  Details? details;
  int? statusCode;

  MyGroupPublicDeatilsModel({this.details, this.statusCode});

  MyGroupPublicDeatilsModel.fromJson(Map<String, dynamic> json) {
    details =
        json['details'] != null ? new Details.fromJson(json['details']) : null;
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.details != null) {
      data['details'] = this.details!.toJson();
    }
    data['statusCode'] = this.statusCode;
    return data;
  }
}

class Details {
  int? groupId;
  String? supervisorName;
  String? groupCreatedAt;
  String? ideaArabicName;
  int? membersCount;
  List<MembersPublicDeatilsModel>? members;
  String? qrCode;

  Details(
      {this.groupId,
      this.supervisorName,
      this.groupCreatedAt,
      this.ideaArabicName,
      this.membersCount,
      this.members,
      this.qrCode});

  Details.fromJson(Map<String, dynamic> json) {
    groupId = json['group_id'];
    supervisorName = json['supervisor_name'];
    groupCreatedAt = json['group_created_at'];
    ideaArabicName = json['idea_arabic_name'];
    membersCount = json['members_count'];
    if (json['members'] != null) {
      members = <MembersPublicDeatilsModel>[];
      json['members'].forEach((v) {
        members!.add(new MembersPublicDeatilsModel.fromJson(v));
      });
    }
    qrCode = json['qr_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['group_id'] = this.groupId;
    data['supervisor_name'] = this.supervisorName;
    data['group_created_at'] = this.groupCreatedAt;
    data['idea_arabic_name'] = this.ideaArabicName;
    data['members_count'] = this.membersCount;
    if (this.members != null) {
      data['members'] = this.members!.map((v) => v.toJson()).toList();
    }
    data['qr_code'] = this.qrCode;
    return data;
  }
}

class MembersPublicDeatilsModel {
  String? name;
  String? speciality;
  String? studentStatus;
  String? image;
  bool? isLeader;

  MembersPublicDeatilsModel(
      {this.name,
      this.speciality,
      this.studentStatus,
      this.image,
      this.isLeader});

  MembersPublicDeatilsModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    speciality = json['speciality'];
    studentStatus = json['student_status'];
    image = json['image'];
    isLeader = json['is_leader'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['speciality'] = this.speciality;
    data['student_status'] = this.studentStatus;
    data['image'] = this.image;
    data['is_leader'] = this.isLeader;
    return data;
  }
}