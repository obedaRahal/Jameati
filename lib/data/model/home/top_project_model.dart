// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this

class TopProjectModel {
  List<TopProjectData>? data;

  TopProjectModel({this.data});

  TopProjectModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <TopProjectData>[];
      json['data'].forEach((v) {
        data!.add(new TopProjectData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TopProjectData {
  int? groupId;
  String? name;
  String? groupImage;
  String? ideaTitle;
  Grades? grades;
  List<Members>? members;

  TopProjectData(
      {this.groupId,
      this.name,
      this.groupImage,
      this.ideaTitle,
      this.grades,
      this.members});

  TopProjectData.fromJson(Map<String, dynamic> json) {
    groupId = json['group_id'];
    name = json['name'];
    groupImage = json['group_image'];
    ideaTitle = json['idea_title'];
    grades =
        json['grades'] != null ? new Grades.fromJson(json['grades']) : null;
    if (json['members'] != null) {
      members = <Members>[];
      json['members'].forEach((v) {
        members!.add(new Members.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['group_id'] = this.groupId;
    data['name'] = this.name;
    data['group_image'] = this.groupImage;
    data['idea_title'] = this.ideaTitle;
    if (this.grades != null) {
      data['grades'] = this.grades!.toJson();
    }
    if (this.members != null) {
      data['members'] = this.members!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Grades {
  int? presentationGrade;
  int? projectGrade;
  int? total;

  Grades({this.presentationGrade, this.projectGrade, this.total});

  Grades.fromJson(Map<String, dynamic> json) {
    presentationGrade = json['presentation_grade'];
    projectGrade = json['project_grade'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['presentation_grade'] = this.presentationGrade;
    data['project_grade'] = this.projectGrade;
    data['total'] = this.total;
    return data;
  }
}

class Members {
  int? id;
  String? name;
  String? universityNumber;
  String? profileImage;

  Members({this.id, this.name, this.universityNumber, this.profileImage});

  Members.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    universityNumber = json['university_number'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['university_number'] = this.universityNumber;
    data['profile_image'] = this.profileImage;
    return data;
  }
}