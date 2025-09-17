// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this

class MemberForFormOneModel {
  int? count;
  List<DataMember>? data;

  MemberForFormOneModel({this.count, this.data});

  MemberForFormOneModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['data'] != null) {
      data = <DataMember>[];
      json['data'].forEach((v) {
        data!.add(new DataMember.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataMember {
  int? id;
  String? name;
  String? phoneNumber;
  String? studentStatus;

  DataMember({this.id, this.name, this.phoneNumber, this.studentStatus});

  DataMember.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    studentStatus = json['student_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone_number'] = this.phoneNumber;
    data['student_status'] = this.studentStatus;
    return data;
  }
}