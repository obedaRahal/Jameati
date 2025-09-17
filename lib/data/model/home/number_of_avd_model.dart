// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this

class NumberOfAdvModel {
  int? total;
  int? images;
  int? files;
  int? statusCode;

  NumberOfAdvModel({this.total, this.images, this.files, this.statusCode});

  NumberOfAdvModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    images = json['images'];
    files = json['files'];
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['images'] = this.images;
    data['files'] = this.files;
    data['statusCode'] = this.statusCode;
    return data;
  }
}