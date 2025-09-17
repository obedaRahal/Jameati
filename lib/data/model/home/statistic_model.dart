class StatisticsModel {
  Data? data;
  int? statusCode;

  StatisticsModel({this.data, this.statusCode});

  StatisticsModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['statusCode'] = statusCode;
    return data;
  }
}

class Data {
  int? doctorsCount;
  int? groupsCount;
  int? studentsCount;

  Data({this.doctorsCount, this.groupsCount, this.studentsCount});

  Data.fromJson(Map<String, dynamic> json) {
    doctorsCount = json['doctorsCount'];
    groupsCount = json['groupsCount'];
    studentsCount = json['studentsCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['doctorsCount'] = doctorsCount;
    data['groupsCount'] = groupsCount;
    data['studentsCount'] = studentsCount;
    return data;
  }
}
