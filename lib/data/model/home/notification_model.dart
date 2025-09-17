// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this

class NotificationModel {
  List<NotificationData>? data;
  int? statusCode;

  NotificationModel({this.data, this.statusCode});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <NotificationData>[];
      json['data'].forEach((v) {
        data!.add(new NotificationData.fromJson(v));
      });
    }
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['statusCode'] = this.statusCode;
    return data;
  }
}

class NotificationData {
  String? id;
  String? title;
  String? body;
  String? date;

  NotificationData({this.id, this.title, this.body, this.date});

  NotificationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    data['date'] = this.date;
    return data;
  }
}