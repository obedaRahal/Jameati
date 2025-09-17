// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this

class AdvModel {
  int? count;
  List<DataAdvModel>? data;
  int? statusCode;

  AdvModel({this.count, this.data, this.statusCode});

  AdvModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['data'] != null) {
      data = <DataAdvModel>[];
      json['data'].forEach((v) {
        data!.add(new DataAdvModel.fromJson(v));
      });
    }
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['statusCode'] = this.statusCode;
    return data;
  }
}

class DataAdvModel {
  int? id;
  String? title;
  bool? isFavorite;
  String? createdAt;
  String? attachmentPath;

  DataAdvModel({this.id, this.title, this.createdAt, this.attachmentPath , this.isFavorite});

  DataAdvModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    isFavorite = json['is_favorite'];
    createdAt = json['created_at'];
    attachmentPath = json['attachment_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['is_favorite'] = this.isFavorite;
    data['title'] = this.title;
    data['created_at'] = this.createdAt;
    data['attachment_path'] = this.attachmentPath;
    return data;
  }
}