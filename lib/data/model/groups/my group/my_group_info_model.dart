// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this


class MyGroupInfoModel {
  Data? data;
  int? statusCode;

  MyGroupInfoModel({this.data, this.statusCode});

  MyGroupInfoModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['statusCode'] = this.statusCode;
    return data;
  }
}

class Data {
  String? name;
  String? description;
  String? image;
  List<String>? specialityNeeded;
  List<String>? frameworkNeeded;
  String? type;

  Data(
      {this.name,
      this.description,
      this.image,
      this.specialityNeeded,
      this.frameworkNeeded,
      this.type});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    image = json['image'];
    specialityNeeded = json['speciality_needed'].cast<String>();
    frameworkNeeded = json['framework_needed'].cast<String>();
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['image'] = this.image;
    data['speciality_needed'] = this.specialityNeeded;
    data['framework_needed'] = this.frameworkNeeded;
    data['type'] = this.type;
    return data;
  }
}