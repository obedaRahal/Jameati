// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this

class CompleteGroupModel {
  List<FullGroupsModel>? groups;
  int? statusCode;

  CompleteGroupModel({this.groups, this.statusCode});

  CompleteGroupModel.fromJson(Map<String, dynamic> json) {
    if (json['groups'] != null) {
      groups = <FullGroupsModel>[];
      json['groups'].forEach((v) {
        groups!.add(new FullGroupsModel.fromJson(v));
      });
    }
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.groups != null) {
      data['groups'] = this.groups!.map((v) => v.toJson()).toList();
    }
    data['statusCode'] = this.statusCode;
    return data;
  }
}

class FullGroupsModel {
  int? id;
  String? name;
  String? image;

  FullGroupsModel({this.id, this.name, this.image});

  FullGroupsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}