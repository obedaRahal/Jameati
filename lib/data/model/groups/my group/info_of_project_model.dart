// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this


class InfoOfProjectModel {
  DataProject? data;
  int? statusCode;

  InfoOfProjectModel({this.data, this.statusCode});

  InfoOfProjectModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new DataProject.fromJson(json['data']) : null;
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

class DataProject {
  int? groupId;
  String? name;
  Form1Model? form1;
  Form2Model? form2;
  GradesModel? grades;
  List<MembersAtProjectModel>? members;
  FinalInterviewModel? finalInterview;

  DataProject(
      {this.groupId,
      this.name,
      this.form1,
      this.form2,
      this.grades,
      this.members,
      this.finalInterview});

  DataProject.fromJson(Map<String, dynamic> json) {
    groupId = json['group_id'];
    name = json['name'];
    form1 = json['form1'] != null ? new Form1Model.fromJson(json['form1']) : null;
    form2 = json['form2'] != null ? new Form2Model.fromJson(json['form2']) : null;
    grades =
        json['grades'] != null ? new GradesModel.fromJson(json['grades']) : null;
    if (json['members'] != null) {
      members = <MembersAtProjectModel>[];
      json['members'].forEach((v) {
        members!.add(new MembersAtProjectModel.fromJson(v));
      });
    }
    finalInterview = json['final_interview'] != null
        ? new FinalInterviewModel.fromJson(json['final_interview'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['group_id'] = this.groupId;
    data['name'] = this.name;
    if (this.form1 != null) {
      data['form1'] = this.form1!.toJson();
    }
    if (this.form2 != null) {
      data['form2'] = this.form2!.toJson();
    }
    if (this.grades != null) {
      data['grades'] = this.grades!.toJson();
    }
    if (this.members != null) {
      data['members'] = this.members!.map((v) => v.toJson()).toList();
    }
    if (this.finalInterview != null) {
      data['final_interview'] = this.finalInterview!.toJson();
    }
    return data;
  }
}

class Form1Model {
  int? id;
  String? title;
  String? supervisor;
  String? supervisorProfileImage;
  String? submissionDate;
  String? status;
  int? signaturesCount;

  Form1Model(
      {this.id,
      this.title,
      this.supervisor,
      this.supervisorProfileImage,
      this.submissionDate,
      this.status,
      this.signaturesCount});

  Form1Model.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    supervisor = json['supervisor'];
    supervisorProfileImage = json['supervisor_profile_image'];
    submissionDate = json['submission_date'];
    status = json['status'];
    signaturesCount = json['signatures_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['supervisor'] = this.supervisor;
    data['supervisor_profile_image'] = this.supervisorProfileImage;
    data['submission_date'] = this.submissionDate;
    data['status'] = this.status;
    data['signatures_count'] = this.signaturesCount;
    return data;
  }
}

class Form2Model {
  int? id;
  String? title;
  String? submissionDate;
  String? status;

  Form2Model({this.id, this.title, this.submissionDate, this.status});

  Form2Model.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    submissionDate = json['submission_date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['submission_date'] = this.submissionDate;
    data['status'] = this.status;
    return data;
  }
}

class GradesModel {
  int? presentationGrade;
  int? projectGrade;
  int? total;
  CommitteeMOdel? committee;

  GradesModel(
      {this.presentationGrade, this.projectGrade, this.total, this.committee});

  GradesModel.fromJson(Map<String, dynamic> json) {
    presentationGrade = json['presentation_grade'];
    projectGrade = json['project_grade'];
    total = json['total'];
    committee = json['committee'] != null
        ? new CommitteeMOdel.fromJson(json['committee'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['presentation_grade'] = this.presentationGrade;
    data['project_grade'] = this.projectGrade;
    data['total'] = this.total;
    if (this.committee != null) {
      data['committee'] = this.committee!.toJson();
    }
    return data;
  }
}

class CommitteeMOdel {
  String? supervisor;
  String? supervisorProfileImage;
  String? member;
  String? memberProfileImage;

  CommitteeMOdel(
      {this.supervisor,
      this.supervisorProfileImage,
      this.member,
      this.memberProfileImage});

  CommitteeMOdel.fromJson(Map<String, dynamic> json) {
    supervisor = json['supervisor'];
    supervisorProfileImage = json['supervisor_profile_image'];
    member = json['member'];
    memberProfileImage = json['member_profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['supervisor'] = this.supervisor;
    data['supervisor_profile_image'] = this.supervisorProfileImage;
    data['member'] = this.member;
    data['member_profile_image'] = this.memberProfileImage;
    return data;
  }
}

class MembersAtProjectModel {
  int? id;
  String? name;
  String? universityNumber;
  String? profileImage;

  MembersAtProjectModel({this.id, this.name, this.universityNumber, this.profileImage});

  MembersAtProjectModel.fromJson(Map<String, dynamic> json) {
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

class FinalInterviewModel {
  String? date;
  String? startTime;
  String? endTime;

  FinalInterviewModel({this.date, this.startTime, this.endTime});

  FinalInterviewModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    return data;
  }
}