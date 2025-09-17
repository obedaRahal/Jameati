// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this

class DoctorForFormOneModel {
  int? count;
  List<DoctorData>? data;

  DoctorForFormOneModel({this.count, this.data});

  DoctorForFormOneModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['data'] != null) {
      data = <DoctorData>[];
      json['data'].forEach((v) {
        data!.add(new DoctorData.fromJson(v));
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

class DoctorData {
  int? id;
  int? pending_forms_count;
  String? name;
  String? profileImage;
  bool? isSupervisorOfAnyForm;


  DoctorData({this.id, this.name, this.profileImage, this.isSupervisorOfAnyForm});

  DoctorData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pending_forms_count = json['pending_forms_count'];
    name = json['name'];
    profileImage = json['profile_image'];
    isSupervisorOfAnyForm = json['is_supervisor_of_any_form'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pending_forms_count'] = this.pending_forms_count;
    data['name'] = this.name;
    data['profile_image'] = this.profileImage;
    data['is_supervisor_of_any_form'] = this.isSupervisorOfAnyForm;
    return data;
  }
}